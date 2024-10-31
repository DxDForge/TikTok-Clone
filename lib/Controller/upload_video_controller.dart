import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Model/video_model.dart';
import 'package:news_proved/constant.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController instance = Get.find();

  // Track the upload status
  RxString uploadStatus = ''.obs;

  // Upload video thumbnail to storage
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    uploadStatus.value = "Uploading thumbnail...";
    Reference ref = firebaseStorage.ref().child('Thumbnails').child(id);
    File thumbnail = await _videoThumbnail(videoPath);
    UploadTask uploadTask = ref.putFile(thumbnail);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Generate video thumbnail
  Future<File> _videoThumbnail(String videoPath) async {
    final videoThumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return videoThumbnail;
  }

  // Upload video to Firebase storage without compression
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    uploadStatus.value = "Uploading video...";
    Reference ref = firebaseStorage.ref().child('Videos').child(id);
    File videoFile = File(videoPath); // Directly upload the original video

    try {
      UploadTask uploadTask = ref.putFile(videoFile);
      TaskSnapshot snap = await uploadTask;
      String downloadLink = await snap.ref.getDownloadURL();
      return downloadLink;
    } catch (e) {
      throw Exception("Video upload failed: $e");
    }
  }

  // Upload video details to Firestore
  Future<void> uploadVideo(
      String videoPath, String songName, String caption) async {
    try {
      // Validate input
      if (videoPath.isEmpty || songName.isEmpty || caption.isEmpty) {
        Get.snackbar(
          "Upload Failed",
          "Video path, song name, or caption cannot be empty.",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          icon: const Icon(Icons.error, color: Colors.white),
        );
        return;
      }

      uploadStatus.value = "Preparing upload...";
      var uid = firebaseAuth.currentUser?.uid;
      if (uid == null) {
        throw Exception("User not authenticated. Please log in again.");
      }

      // Fetch user data
      DocumentSnapshot userData =
          await firebaseFirestore.collection('Users').doc(uid).get();
      if (!userData.exists) throw Exception("User data not found.");

      final data = userData.data() as Map<String, dynamic>;
      String? userName = data['name'];
      String? profilePic = data['imagePath'];
      if (userName == null || profilePic == null) {
        throw Exception("User info incomplete.");
      }

      // Get video count for unique ID
      var allDocs = await firebaseFirestore.collection("Videos").get();
      int len = allDocs.docs.length;

      // Upload video and thumbnail
      String videoUrl = await _uploadVideoToStorage('video $len', videoPath);
      String thumbnailUrl =
          await _uploadImageToStorage('video $len', videoPath);

      // Prepare video object
      Video video = Video(
        uid: uid,
        id: 'video $len',
        name: userName,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        songName: songName,
        caption: caption,
        profilePicPath: profilePic,
        likeCount: [],
        commentCount: 0,
        shareCount: 0,
      );

      // Save video to Firestore
      uploadStatus.value = "Saving video info...";
      await firebaseFirestore
          .collection("Videos")
          .doc('video $len')
          .set(video.toMap());

      // Notify success
      uploadStatus.value = "Upload successful!";
      Get.snackbar(
        "Upload Successful",
        "Your video has been uploaded successfully.",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.greenAccent,
        colorText: Colors.white,
        icon: const Icon(Icons.check_circle, color: Colors.white),
      );

      // Navigate back to the previous screen after upload completes
      Get.back();
    } catch (e) {
      uploadStatus.value = "Upload failed: ${e.toString()}";
      Get.snackbar(
        "Upload Failed",
        "Failed to upload video: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 4),
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
  }
}

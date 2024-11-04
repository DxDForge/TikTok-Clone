import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_proved/View/Screens/confirm_video.dart';
import 'package:news_proved/constant.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  // Pick Video
  Future pickVideo(ImageSource src, BuildContext context) async {
    final pickedVideo = await ImagePicker().pickVideo(source: src);
    if (pickedVideo != null) {
      Get.snackbar(
        'Video Picked',
        "Video picked from the ${src == ImageSource.gallery ? 'Gallery' : 'Camera'}",
        // snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => ConfirmVideoScreen(
          videoFile: File(pickedVideo.path),
          videoPath: pickedVideo.path,
        ),
      ));
    } else {
      Get.snackbar(
        'Error',
        "Try Again... video not picked",
        // snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  // Show Dialog Box
  showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: const Text(
          'Select Video Source',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () => pickVideo(ImageSource.gallery, context),
            child: Row(
              children: [
                Icon(Icons.image, color: buttonColor),
                const SizedBox(width: 10),
                const Text(
                  'Gallery',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              pickVideo(ImageSource.camera, context);
              Navigator.of(context).pop();
            },
            child: Row(
              children: [
                Icon(Icons.camera_alt, color: buttonColor),
                const SizedBox(width: 10),
                const Text(
                  'Camera',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.cancel, color: Colors.redAccent),
                SizedBox(width: 10),
                Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
        child: InkWell(
          onTap: () => showDialogBox(context),
          borderRadius: BorderRadius.circular(25),
          child: Container(
            height: 55,
            width: 160,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

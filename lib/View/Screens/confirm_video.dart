import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/upload_video_controller.dart';
import 'package:news_proved/View/Widgets/text_input_from.dart';
import 'package:news_proved/constant.dart';
import 'package:video_player/video_player.dart';

class ConfirmVideoScreen extends StatefulWidget {
  final File videoFile;
  final String videoPath;

  const ConfirmVideoScreen(
      {super.key, required this.videoFile, required this.videoPath});

  @override
  State<ConfirmVideoScreen> createState() => _ConfirmVideoScreenState();
}

class _ConfirmVideoScreenState extends State<ConfirmVideoScreen> {
  late VideoPlayerController vController;
  final TextEditingController _songController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();
  final UploadVideoController videoController =
      Get.put(UploadVideoController());

  @override
  void initState() {
    super.initState();
    vController = VideoPlayerController.file(widget.videoFile);
    vController.initialize().then((_) {
      setState(() {});
      vController.play();
    });
    vController.setLooping(true);
    vController.setVolume(1);
  }

  @override
  void dispose() {
    vController.dispose();
    _songController.dispose();
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirm Video"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video preview
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.black,
                ),
                child: vController.value.isInitialized
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio: vController.value.aspectRatio,
                          child: VideoPlayer(vController),
                        ),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 20),
            // Song Name Input
            TextInputForm(
              labelText: const Text("Song Name"),
              icon: const Icon(Icons.music_note),
              controller: _songController,
            ),
            const SizedBox(height: 16),
            // Caption Input
            TextInputForm(
              labelText: const Text("Caption"),
              icon: const Icon(Icons.closed_caption),
              controller: _captionController,
            ),

            // Display upload status
            Obx(() {
              return Text(
                videoController.uploadStatus.value,
                style: TextStyle(
                  fontSize: 16,
                  color: videoController.uploadStatus.value.contains("failed")
                      ? Colors.red
                      : Colors.green,
                ),
              );
            }),

            const SizedBox(height: 20), // Share Button
            ElevatedButton(
              onPressed: () => videoController.uploadVideo(
                widget.videoPath,
                _songController.text,
                _captionController.text,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Share",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

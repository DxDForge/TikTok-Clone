import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerItem({super.key, required this.videoUrl});

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  // Controller
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          controller.play();
          controller.setVolume(1);
          controller.setLooping(true); // Optional: set video to loop
        });
      }).catchError((error) {
        // Handle errors here
        debugPrint("Error loading video: $error");
      });
  }

  @override
  void dispose() {
    // Dispose of the controller to free up resources
    controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: _togglePlayPause,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: controller.value.isInitialized
            ? Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(controller),
                  if (!controller.value.isPlaying)
                    const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 60,
                    ),
                ],
              )
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

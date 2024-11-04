import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/video_controller.dart';
import 'package:news_proved/View/Screens/comment_screen.dart';
import 'package:news_proved/View/Widgets/circle_animation.dart';
import 'package:news_proved/View/Widgets/video_player_item.dart';
import 'package:news_proved/constant.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});
  buildProfile(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          Positioned(
              left: 5,
              child: Container(
                padding: const EdgeInsets.all(1),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image(
                    image: NetworkImage(profilePhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }

  buildMugicAblum(String profilePhoto) {
    return SizedBox(
      width: 60,
      height: 60,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(11),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              gradient:
                  const LinearGradient(colors: [Colors.grey, Colors.white]),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image(image: NetworkImage(profilePhoto)),
            ),
          )
        ],
      ),
    );
  }

//controller
  final VideoController controller = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: backgroundColor,
        body: Obx(() {
          return PageView.builder(
            itemCount: controller.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = controller.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(videoUrl: data.videoUrl),
                  Column(
                    children: [
                      const SizedBox(
                        height: 100,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Container(
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    data.caption,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.music_note,
                                        size: 15,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        data.songName,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(top: size.height / 5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  buildProfile(data.profilePicPath),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () =>
                                            controller.likeVideo(data.id),
                                        child: Icon(
                                          Icons.favorite,
                                          size: 40,
                                          color: data.likeCount.contains(
                                                  authController.user.uid)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.likeCount.length.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CommentScreen(
                                                      postId: data.id,
                                                    ))),
                                        child: const Icon(
                                          Icons.comment,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.commentCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.reply,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 7,
                                      ),
                                      Text(
                                        data.shareCount.toString(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                  CircleAnimation(
                                    child: buildMugicAblum(data.profilePicPath),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        }));
  }
}

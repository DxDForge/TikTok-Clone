import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/comment_controller.dart';
import 'package:news_proved/constant.dart';
import 'package:timeago/timeago.dart' as tago; // For formatting dates

class CommentScreen extends StatelessWidget {
  final String postId;
  CommentScreen({Key? key, required this.postId}) : super(key: key);

  final TextEditingController commentControllerTxtEditing =
      TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    // Update the post ID to fetch relevant comments
    commentController.updatePostId(postId);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Comments", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Comments List
          Expanded(
            child: Obx(() {
              // Show a message if there are no comments
              if (commentController.comment.isEmpty) {
                return const Center(
                  child: Text(
                    'No comments yet. Be the first to comment!',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                itemCount: commentController.comment.length,
                itemBuilder: (BuildContext context, int index) {
                  final eachComment = commentController.comment[index];
                  // Format the date
                  // String formattedDate = DateFormat('MMM d, yyyy').format(comment.datePublished);

                  return ListTile(
                    title: Row(
                      children: [
                        Text(
                          eachComment.userName,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            eachComment.comment,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          tago.format(eachComment.datePublished
                              .toDate()), // Dynamically formatted date
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${eachComment.likeCount.length} likes',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(eachComment.profilePic),
                      backgroundColor: Colors.grey,
                    ),
                    trailing: InkWell(
                        onTap: () =>
                            commentController.likeComment(eachComment.id),
                        child:  Icon(Icons.favorite,
                        color: eachComment.likeCount.contains(
                          authController.user.uid)? Colors.red:Colors.white,
                  )));
                },
              );
            }),
          ),
          const Divider(color: Colors.grey),
          // Comment Input Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentControllerTxtEditing,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Write a comment',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      labelStyle: TextStyle(color: Colors.red),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.red),
                  onPressed: () {
                    if (commentControllerTxtEditing.text.trim().isNotEmpty) {
                      commentController
                          .addComment(commentControllerTxtEditing.text.trim());
                      commentControllerTxtEditing
                          .clear(); // Clear text after posting
                    } else {
                      Get.snackbar('Empty Comment',
                          'Please write something before posting.');
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

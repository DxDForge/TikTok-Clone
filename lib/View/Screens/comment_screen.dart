import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/comment_controller.dart';
import 'package:news_proved/constant.dart';

class CommentScreen extends StatelessWidget {
  final String postId;
  CommentScreen({super.key,required this.postId});

  final TextEditingController commentControllerTxtEditing = TextEditingController();
  final CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updatePostId(postId);
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Column(
        children: [
          // Using Expanded directly instead of wrapping in SingleChildScrollView
          Expanded(
            child: ListView.builder(
              itemCount: 12,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Row(
                    children: [
                      Text(
                        'UserName',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'This is a comment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '2 days ago',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '2 likes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                  leading: Icon(Icons.person),
                  trailing: Icon(Icons.favorite),
                );
              },
            ),
          ),
          const Divider(),
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
                    ),
                    onChanged: (value) {
                      // Handle comment input
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.red),
                  onPressed: () 
                  {
                    commentController.addComment(commentControllerTxtEditing.text);
                    commentControllerTxtEditing.clear();

  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

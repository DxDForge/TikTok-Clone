import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/constant.dart';
import 'package:news_proved/Controller/search_controll.dart' as custom;

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  // Controllers
  final custom.SearchController controller = Get.put(custom.SearchController());
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: buttonColor,
        title: TextFormField(
          onFieldSubmitted: (value) => controller.searchUser(value),
          controller: textController,
          decoration: const InputDecoration(
            filled: false,
            hintText: "Search",
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.search),
        //     onPressed: () {
        //       controller.searchUser(textController.text);
        //     },
        //   ),
        // ],
      ),
      body: Obx(() {
        if (controller.searchedUsers.isEmpty) {
          return const Center(
            child: Text(
              "Search for USER!!!",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.searchedUsers.length,
          itemBuilder: (context, index) {
            final user = controller.searchedUsers[index];
            return InkWell(
              onTap: () {},
              child: ListTile(
                title: Text(user.name,style: TextStyle(fontSize: 18),),
                leading: CircleAvatar(backgroundImage: NetworkImage(user.imagePath),),
              ),
            );
          },
        );
      }),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_proved/Controller/profile_controller.dart';
import 'package:news_proved/constant.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
   const ProfileScreen({super.key,required this.uid});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

//initialize the uid
@override
void initState() {
  super.initState();
  profileController.updateUserId(widget.uid);
  
}

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        if (controller.user.isEmpty) {
         return const Center(child:  CircularProgressIndicator(),
         );
        }
        return Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            backgroundColor: backgroundColor,
            leading:const Icon(Icons.person_add_alt_1_outlined),
            title: Center(child: Text(profileController.user['name'] )),
            actions: [
              IconButton(
                icon: const Icon(Icons.more_horiz),
                onPressed: () => {},
              ),
            
            ],
          ),
        
          body:SafeArea(
            
            child: SingleChildScrollView(
              child: Column(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: profileController.user['image'],
                            fit: BoxFit.cover,
                            height: 100,width: 100,
                            placeholder: (context, url) => 
                            const CircularProgressIndicator(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.error,
                            ),),
                        ),
                      ],
                    ),
                      const SizedBox(height: 40,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Column(
                          children: [
                            Text(profileController.user['following'],style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20 ),),
                            const Text('Following',style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(width: 20,),
                         Column(
                          children: [
                            Text(profileController.user['followers'],style: const TextStyle(fontWeight:FontWeight.bold ,fontSize: 20),),
                            const Text('Followers',style: TextStyle(fontSize: 14)),
                          ],
                        ),
                        const SizedBox(width: 20,),
                         Column(
                          children: [
                            Text(profileController.user['likes'],style: const TextStyle(fontWeight:FontWeight.bold,fontSize: 20 ),),
                            const Text('Likes',style:  TextStyle(fontSize: 14)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40,),
                    Container(
                      height:47,
                      width: 140,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:Colors.black12,
                        )
                      ),
                      child:  Center(
                        child: InkWell(
                          onTap: () {
                            if (widget.uid == authController.user.uid) {
                              authController.logOut();
                            }else{
                              profileController.followUser();
                            }
                          },
                          child:  Text(
                            widget.uid == authController.user.uid?'Sing Out':profileController.user['isFollowing']?'Unfollow':'Follow',
                            style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                          
                            )),
                      ),
                    ),
                    //videos
                    GridView.builder(
                      itemCount: profileController.user['thumbnail'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),      
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 5,
                      ) ,
                      itemBuilder:(context, index) {
                      String thumbnail = profileController.user['thumbnail'][index];
                      return CachedNetworkImage(
                        imageUrl: thumbnail,
                        fit: BoxFit.cover,
                      );
                    },)
                  ],
                )
              ],
                        ),
            )),
        );
      }
    );}}
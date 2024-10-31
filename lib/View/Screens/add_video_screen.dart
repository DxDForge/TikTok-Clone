import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_proved/View/Screens/confirm_video.dart';
import 'package:news_proved/constant.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});


  //pick Video
  Future pickVideo(ImageSource src,BuildContext context)async{
    final  pickedVideo = await ImagePicker().pickVideo(source:ImageSource.gallery);
    if (pickedVideo !=null) {
      Get.snackbar('Video Picked', "Video Picked From the Gallery");
       // ignore: use_build_context_synchronously
       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  ConfirmVideoScreen(videoFile: File(pickedVideo.path),videoPath: pickedVideo.path,),));

    }else{
      Get.snackbar('Error', "Try Again...video not picked");
    }



  }
  //show dailogbox ->
  showDailgoBox(context ){
    showDialog(context: context, builder: (context)=> SimpleDialog(
        children: [
           SimpleDialogOption(
            onPressed: ()=>pickVideo(ImageSource.gallery,context),
            child: const Row(
              children: [
                Icon(Icons.image),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Gallery'),
                ),
              ],
            ),
            
          ),
          SimpleDialogOption(
              onPressed: ()=>pickVideo(ImageSource.camera,context),
            child: const Row(
              children: [
                Icon(Icons.camera_alt),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Camera'),
                ),
              ],
            ),
          ),
             SimpleDialogOption(
              onPressed: ()=>Navigator.of(context).pop(),
            child: const Row(
              children: [
                Icon(Icons.cancel),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Cancel'),
                ),
              ],
            ),
          ),
        ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: ()=>showDailgoBox(context),
          child: Container(
            height: 50,
            width: 150,
            color: buttonColor,
            child: const Center(child: Text("Add Video",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.white),)),
            
          ),
        ),
      ),
    );
  }
}
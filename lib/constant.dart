
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:news_proved/Controller/auth_controller.dart';
import 'package:news_proved/View/Screens/add_video_screen.dart';
import 'package:news_proved/View/Screens/search_screen.dart';
import 'package:news_proved/View/Screens/video_screen.dart';

//page INDEX
var page =[
   VideoScreen(),
   SearchScreen(),

  const AddVideoScreen(),
  const Text('Message Screen'),
  const Text('Person Screen'),
];
// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

//Firebase
var firebaseAuth=FirebaseAuth.instance; //signing in, signing out, creating accounts).
var firebaseStorage = FirebaseStorage.instance; //uploading and retrieving files like images and videos
var firebaseFirestore = FirebaseFirestore.instance; //adding, updating, reading, and deleting documents


//authController
var  authController = AuthController.instance;
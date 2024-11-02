import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
 String uid;
 String name;
 String email;
 String imagePath;

 UserModel({
  required this.uid,
  required this.email,required this.name,
  required this.imagePath,
 });

 Map<String,dynamic> tojson()=>{

  'uid':uid,
  'name':name,
  'email':email,
  'imagePath':imagePath

 };

 static fromSnap(DocumentSnapshot snap){
  var snapshot = snap.data() as Map<String,dynamic>;
  return UserModel(
    uid: snapshot['uid'], 
    email: snapshot['email'], 
    name: snapshot['name'],
    imagePath: snapshot['imagePath'],
    );
 }
}
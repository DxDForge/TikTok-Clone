import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_proved/constant.dart';

class ProfileController extends GetxController{
  final Rx<Map<String,dynamic>> _user = Rx<Map<String,dynamic>>({});
  Map<String,dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid){
    _uid.value = uid;
    getUserData();
  }

  getUserData()async{
    List<String> thumbnail=[];
    var myVideos = await firebaseFirestore.collection('Videos').where('uid',isEqualTo:_uid.value ).get();
    for(int i =0; i<myVideos.docs.length;i++){
      thumbnail.add((myVideos.docs[i].data()! as dynamic)['thumbnailUrl']);
    }
  
    DocumentSnapshot userDoc = await firebaseFirestore.collection('Users').doc(_uid.value).get();
    String name = userDoc['name'];
    String imagePath = userDoc['imagePath'];
    int likes =0;
    int followers =0;
    int following =0;
    bool isFollowing = false;

    for (var item in myVideos.docs) {
      likes += (item.data() ['likeCount'] as List).length;
  }

  var followerDoc = await firebaseFirestore.collection('Users').doc(_uid.value).collection('followers').get();

  var followingDoc = await firebaseFirestore.collection('Users').doc(_uid.value).collection('following').get();

  followers =followerDoc.docs.length;
  following = followingDoc.docs.length;

  firebaseFirestore.collection('Users').doc(_uid.value).collection('followers').doc(authController.user.uid).get().then((onValue){
    if(onValue.exists){
      isFollowing = true;
    }else{
      isFollowing = false;
    }
  
  });
  
  
    _user.value ={
        'followers':followers.toString(),
        'following':following.toString(),
        'isFollowing':isFollowing,
        'likes':likes.toString(),
        'name': name,
        'thumbnail': thumbnail,
        'image': imagePath,
    

    };
    update();


  }
    followUser()async{
    var doc =await firebaseFirestore.collection('Users').doc(_uid.value).
    collection('followers').doc(authController.user.uid).get();

    if (!doc.exists) {
      await firebaseFirestore.collection('Users').doc(_uid.value).
    collection('followers').doc(authController.user.uid).set({});
      await firebaseFirestore.collection('Users').doc(authController.user.uid).
    collection('following').doc(_uid.value).set({});
    
    _user.value.update(
        'followers',
        (value)=> (int.parse(value) + 1).toString(),
    );
    }else{
            await firebaseFirestore.collection('Users').doc(_uid.value).
    collection('followers').doc(authController.user.uid).delete();
      await firebaseFirestore.collection('Users').doc(authController.user.uid).
    collection('following').doc(_uid.value).delete();
    
    _user.value.update(
        'followers',
        (value)=> (int.parse(value) - 1).toString(),
    );
    }
    _user.value.update('isFollowing', (value)=>!value);
    update();
  }
  }
  
  
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_proved/Model/video_model.dart';
import 'package:news_proved/constant.dart';

class VideoController extends GetxController{

  final Rx<List<Video>> _videoList= Rx<List<Video>>([]);

  List<Video> get videoList => _videoList.value;

@override
  void onInit() {
    
    super.onInit();
     _videoList.bindStream(
      firebaseFirestore.collection("Videos").snapshots().map((QuerySnapshot querry){
          List<Video> retval =[];
          for (var element in querry.docs) {
            retval.add(Video.fromSnapshot(element));
          }
          return retval;
      })
    );
    
  }

likeVideo(String id)async{
 DocumentSnapshot userData = await firebaseFirestore.collection("Videos").doc(id).get();
  var uid = authController.user.uid;

if((userData.data() as dynamic)['likeCount'].contains(uid)){
  await firebaseFirestore.collection("Videos").doc(id).update({
      'likeCount':FieldValue.arrayRemove([uid]),
  });
}else{
  await firebaseFirestore.collection('Videos').doc(id).update({
    "likeCount":FieldValue.arrayUnion([uid]),
  });
}
}

}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_proved/Model/comment_model.dart';
import 'package:news_proved/constant.dart';


class CommentController extends GetxController{
  final Rx<List<CommentModel>> _comment = Rx<List<CommentModel>>([]);
  List get comment => _comment.value;


   String _postId="";

  updatePostId(String postId){
    _postId =postId;
    getComment();
  }
  getComment()async{
    /**  Comment explaining the previous mistake:
**Note: I initially struggled to display the comments correctly. After some troubleshooting and research, 
 I discovered that I was mistakenly typing .doc("_postId") with quotes around _postId, 
 instead of using .doc(_postId) without quotes. This caused the comments to fail to load, 
 as Firestore couldn't find the correct document reference. 
**Lesson learned: always be cautious with syntax when referencing variables vs. strings in Firestore paths!
**/
    _comment.bindStream(firebaseFirestore.collection("Videos").doc(_postId).collection('Comments').snapshots().map((QuerySnapshot quarry){
      List <CommentModel> returnValue =[];
      for(var element in quarry.docs){
        returnValue.add(CommentModel.fromJson(element));
      }
      return returnValue;
    },),);
  }

  void addComment(String commentText)async{
    try {
      if (commentText.isNotEmpty) {
        final userDoc = await firebaseFirestore.collection("Users").doc(firebaseAuth.currentUser!.uid).get();
    final allDocs = await firebaseFirestore.collection('Videos').doc(_postId).collection('Comments').get();
    int len = allDocs.docs.length;
    CommentModel comment =CommentModel(
      id: 'comment $len', 
      uid: (userDoc.data() as dynamic)['uid'],
      userName: (userDoc.data()! as dynamic)['name'],
      datePublished: DateTime.now(),
      profilePic: (userDoc.data() as dynamic)['imagePath'],
      comment: commentText.trim(),
      likeCount: [],

    );

    await firebaseFirestore.collection('Videos').doc(_postId).collection('Comments').doc('comment $len').set(comment.toJson());
    Get.snackbar('Posted', 'comment posted successfully');
    DocumentSnapshot doc = await firebaseFirestore.collection('Videos').doc(_postId).get();
    await firebaseFirestore.collection('Videos').doc(_postId).update({
      'commentCount':(doc.data() as dynamic)['commentCount']+1,
    });
    
      }else{
        Get.snackbar('Empty Comment ', 'Insert comment');
      }
    } catch (e) {
       Get.snackbar(' Error ', e.toString());
    }
    
  }
  likeComment(String id)async{
    try {
      DocumentSnapshot doc = await firebaseFirestore.collection('Videos').doc(_postId).collection('Comments').doc(id).get();
      var uid = firebaseAuth.currentUser!.uid;
      if ((doc.data()! as dynamic)['likeCount'].contains(uid)){
        await firebaseFirestore.collection("Videos").doc(_postId).collection("Comments").doc(id).update({
            'likeCount': FieldValue.arrayRemove([uid])
        });
      }else {
        await firebaseFirestore.collection("Videos").doc(_postId).collection('Comments').doc(id).update({
          'likeCount':FieldValue.arrayUnion([uid]),
        });
      }
 
    } catch (e) {
      Get.snackbar('Error ', e.toString());
    }
  }
}
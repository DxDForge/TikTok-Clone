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
  getComment(){

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
}
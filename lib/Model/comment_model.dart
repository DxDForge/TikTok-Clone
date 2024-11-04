import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  String? id;
  String? uid;
  String? userName;
  // ignore: prefer_typing_uninitialized_variables
  final datePublished;
  String? profilePic;
  String comment;
  List likeCount;

  CommentModel({
    this.id,
    this.uid,
    this.userName,
    required this.datePublished,
    this.profilePic,
    required this.comment,
    required this.likeCount,
  });

  // Method to convert CommentModel to JSON format for Firestore
  Map<String, dynamic> toJson() => {
    'id': id ?? '',
    'uid': uid ?? '',
    'userName': userName ?? 'Unknown User',
    'datePublished': datePublished,
    'profilePic': profilePic ?? '',
    'comment': comment,
    'likeCount': likeCount,
  };

  // Static method to create CommentModel from Firestore DocumentSnapshot
  static CommentModel fromJson(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return CommentModel(
      id: snapshot['id'] ?? '',
      uid: snapshot['uid'] ?? '',
      userName: snapshot['userName'] ?? 'Unknown User',
      datePublished: snapshot['datePublished'] ?? DateTime.now(),
      profilePic: snapshot['profilePic'] ?? '',
      comment: snapshot['comment'] ?? 'No comment',
      likeCount: snapshot['likeCount'] ?? [], // Default to empty list if null
    );
  }
}

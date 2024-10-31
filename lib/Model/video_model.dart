import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String uid;
  String id;
  String name;
  String videoUrl;
  String thumbnailUrl;
  String songName;
  String caption;
  String profilePicPath;
  List likeCount;
  int commentCount;
  int shareCount;

  Video({
    required this.uid,
    required this.id,
    required this.name,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.songName,
    required this.caption,
    required this.profilePicPath,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
  });

  // Convert Video object to a map
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'id': id,
        'name': name,
        'videoUrl': videoUrl,
        'thumbnailUrl': thumbnailUrl,
        'songName': songName,
        'caption': caption,
        'profilePicPath': profilePicPath,
        'likeCount': likeCount,
        'commentCount': commentCount,
        'shareCount': shareCount,
      };

  // Static method to create Video object from Firestore document snapshot
  static Video fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Video(
      uid: snapshot['uid'],
      id: snapshot['id'],
      name: snapshot['name'],
      videoUrl: snapshot['videoUrl'],
      thumbnailUrl: snapshot['thumbnailUrl'],
      songName: snapshot['songName'],
      caption: snapshot['caption'],
      profilePicPath: snapshot['profilePicPath'],
      likeCount: snapshot['likeCount'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
    );
  }
}

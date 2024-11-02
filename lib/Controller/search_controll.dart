import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:news_proved/Model/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<UserModel>> _searchedUsers = Rx<List<UserModel>>([]);
  List<UserModel> get searchedUsers => _searchedUsers.value;

  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  // Logic for Search to get the Users by NAME
  void searchUser(String typedUser) async {
    _searchedUsers.bindStream(
      firebaseFirestore
          .collection('Users')
          .where('name', isGreaterThanOrEqualTo: typedUser)
          .snapshots()
          .map((QuerySnapshot query) {
        List<UserModel> returnValue = [];
        for (var i in query.docs) {
          returnValue.add(UserModel.fromSnap(i));
        }
        return returnValue;
      }),
    );
  }

  void abc() {
    print("abc() function called"); // For testing purpose
  }
}

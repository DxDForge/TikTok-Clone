import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_proved/Model/user_model.dart';
import 'package:news_proved/View/Screens/auth/sing_in.dart';
import 'package:news_proved/View/Screens/home_screen.dart';
import 'package:news_proved/constant.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // Get the currently signed-in user
  User? currentUser = FirebaseAuth.instance.currentUser;
  late Rx<User?> _user;
  RxBool isLoading = false.obs; // For showing loading states
  late Rx<File?> _pickedFile;
  File? get profile_pic => _pickedFile.value;
  User get user => _user.value!;

  @override
  void onReady() {
    super.onReady();
    _user = Rx(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, initializeScreen);
  }

  initializeScreen(User? user) {
    if (user != null) {
      Get.offAll(() => const HomeScreen());
    } else {
      Get.offAll(() => SignInPage());
    }
  }

  //pick image
  Future pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _pickedFile = Rx(File(pickedImage.path));
      Get.snackbar('Profile Pic', 'pic successfully picked');
    } else {
      Get.snackbar(
        'Pic Not Selected',
        'select a pic to upload',
      );
    }
  }

  //upload it to the firebase storage
  Future<String> uploadImageToFirestore(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('Profile Pic')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image); //uploading
    TaskSnapshot snap = await uploadTask; //takin sanp of file
    String downloadUrl = await snap.ref.getDownloadURL(); //get download url
    return downloadUrl;
  }

  // User Registration Method
  Future<void> userRegistration(
      String email, String password, String name, File? image) async {
    isLoading.value = true;
    try {
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          name.isNotEmpty &&
          image != null) {
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String downloadUrl = await uploadImageToFirestore(image);

        UserModel userModel = UserModel(
          uid: cred.user!.uid,
          email: email,
          name: name,
          imagePath: downloadUrl,
        );

        await firebaseFirestore
            .collection('Users')
            .doc(cred.user!.uid)
            .set(userModel.tojson());
        Get.snackbar(
            'Success', 'Successfully registered and stored in Firestore');
      } else {
        Get.snackbar('Error', 'All fields are required');
      }
    } catch (e) {
      Get.snackbar('Registration Error', e.toString());
    } finally {
      isLoading.value = false; // Stop loading after the operation completes
    }
  }

  // User Login Method
  Future<void> userLogin(String email, String password) async {
    isLoading.value = true;
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        Get.snackbar('Login Successful', 'You are now logged in');
      } else {
        Get.snackbar('Error', 'Email and password cannot be empty');
      }
    } catch (e) {
      Get.snackbar('Login Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  //logout
  logOut() async {
    await firebaseAuth.signOut();
  }
}

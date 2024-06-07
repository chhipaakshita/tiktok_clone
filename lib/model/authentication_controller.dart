import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/authentication/global.dart';
import 'package:tiktok_clone/authentication/login_screen.dart';
import 'package:tiktok_clone/authentication/register_screen.dart';
import 'package:tiktok_clone/home/home_screen.dart';
import 'user.dart' as userModel;

class AuthenticationController extends GetxController{
late Rx<User?> _currentUser;
  static AuthenticationController instanceAuth = Get.find();
    Rx<File?>? _pickFile;
  File? get profileImage => _pickFile?.value;

  void chooseImageFromGallery() async{
   final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

   if(pickedImageFile != null){
     Get.snackbar("Profile Image", "You have sucessfully selected your profile");
   }

   _pickFile =  Rx<File?>(File(pickedImageFile!.path));
  }
  void captureImageWithCamera() async{
    final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);

    if(pickedImageFile != null){
      Get.snackbar("Profile Image", "You have sucessfully capture your profile");
    }

    _pickFile =  Rx<File?>(File(pickedImageFile!.path));
  }

  void createAccountForNewUser(File imageFile,String userName,String userEmail,String userPassword) async{
   try{
     //1. crate user in firebase authentication
     UserCredential userCredential = await FirebaseAuth.instance
         .createUserWithEmailAndPassword(
         email: userEmail,
         password: userPassword
     );

     //2. save user profile image to firebase storage
     String imageDownloadUrl = await  uploadImageToStorage(imageFile);
     //3. save user data to firestore database

     userModel.User user = userModel.User(
         name: userName,
         email: userEmail,
         image: imageDownloadUrl,
         uid: userCredential.user!.uid
     );
     await FirebaseFirestore.instance
         .collection("users")
         .doc(userCredential.user!.uid)
         .set(user.toJson());
     Get.snackbar("Account creation successfully","Congratulations! your has been created Suceessfully");
     showProgressBar = false;
     Get.to(LoginScreen());


   }catch(error){
        Get.snackbar("Account creation unsuccessfull","Error occured while creating account..Try again!");

        showProgressBar = false;
        Get.to(LoginScreen());
   }
  }
  Future<String> uploadImageToStorage(File imageFile) async{
        Reference reference = FirebaseStorage.instance.ref()
            .child("Profile Images")
            .child(FirebaseAuth.instance.currentUser!.uid);

        UploadTask uploadTask = reference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask;

       String downloadUrlOfUploadImage =  await taskSnapshot.ref.getDownloadURL();

       return downloadUrlOfUploadImage;
  }

  void logInUser(String userEmail,String userPassword) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: userEmail,
          password: userPassword);
      Get.snackbar("Logged In successfully","Congratulations! your has been signin Suceessfully");
      showProgressBar = false;
      //Get.to(RegisterScreen());
    }catch(error){
      Get.snackbar("Login unsuccessfull","Error occured while signing account..Try again!");

      showProgressBar = false;
      Get.to(RegisterScreen());
    }
  }

  goToScreen(User? currentUser){
    //ehrn user not logged-in
    if(currentUser == null){
      Get.offAll(LoginScreen());
    }
    else{
      Get.offAll(HomeScreen());
    }
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
   _currentUser= Rx<User?>(FirebaseAuth.instance.currentUser);
   _currentUser.bindStream(FirebaseAuth.instance.authStateChanges());
   ever(_currentUser, goToScreen);
  }
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/google_sign_in.dart';
import 'package:pet_kart/MyWidgets/loading_dialog.dart';
import 'package:pet_kart/SControllers/persistent_data_controller.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Firebase/FirebaseFirestore/firestore_firebase.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';
import '../../Models/customer.dart';
import '../../MyWidgets/snackbarAL.dart';

class LoginSignupController extends GetxController {

  var isSignIn = true.obs;
  void toggleView() {
    isSignIn.value = !isSignIn.value;
  }
var move=false.obs;
void toggleMove(){
  move.value=!move.value;
}

}
class SignInController extends GetxController {
  var isObscure = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKeylogin = GlobalKey<FormState>();
  PersistentDataController persistentDataController=Get.find<PersistentDataController>();
  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }
  void clearText() {
    emailController.clear();
    passwordController.clear();
  }
  void loginUser() async {
    if (formKeylogin.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      showLoadingDialog(message: "Logging in...");

      try {
        if (await EmailPassLoginAl().loginInAL(email, password)) {
          storeUserName(email);

          bool isVerified = await EmailPassLoginAl().isEmailVerified();
          hideLoadingDialog(); // Hide the dialog before navigating.

          if (isVerified) {
            Get.toNamed("/home");
          } else {
            Get.toNamed('/emailverify');
          }
        } else {
          hideLoadingDialog();
          showErrorSnackbar("Login Failed");
        }
      } catch (e) {
        hideLoadingDialog();
        showErrorSnackbar("An error occurred: $e");
      }
    }
  }

googleLogin() async {
    showLoadingDialog();
  clearText();
  UserCredential? uc=await GoogleSignInAL().signInGoogle();
  hideLoadingDialog();
  if(uc==null){
    showErrorSnackbar("Some Error");
  }
  else if(uc.additionalUserInfo!.isNewUser){
  Customer user=Customer(customerName: "xyz", email: uc.user!.email??"", phoneNo: "XXXXXXXXXX");
  FirestoreFirebaseAL().uploadUserDataAL(user);
    Get.toNamed("/googlesignup");
  }else{
    storeUserName(uc.user?.email??"");
    Get.toNamed("/home");
  }
}
  @override
  void onClose() {

    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> storeUserName(String email) async {
    persistentDataController.userName.value = await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .get()
        .then((value) {
      final data = value.data();
      return data?["customerName"] ?? "Unknown User"; // Default value if null
    }).catchError((error) {
      print("Error fetching username: $error");
      return "Unknown User";  // Fallback in case of error
    });
  }
}

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: "signup");
  // PersistentDataController persistentDataController=Get.put(PersistentDataController());
  var obscurePassword = true.obs;
  PersistentDataController persistentDataController=Get.find<PersistentDataController>();



  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    // confirmPasswordController.dispose();
    phoneController.dispose();
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }
  void signUpUser() async {
    // if (formKey.currentState?.validate() ?? false) {
//TODO:account existance check
  showLoadingDialog();
      if (await EmailPassLoginAl()
          .signUpAL( emailController.text, passwordController.text)) {

          Customer signupUser=Customer(customerName: nameController.text, email: emailController.text,  phoneNo: phoneController.text);
          bool userDataUploadStatus =
          await FirestoreFirebaseAL().uploadUserDataAL(signupUser);
          hideLoadingDialog();
          if (userDataUploadStatus) {
            storeUserName(emailController.text);
            Get.toNamed("/emailverify");
          } else {
            EmailPassLoginAl().deleteUser();
            // CloudStorage().deleteProfile(emailController.text);
            FirestoreFirebaseAL().deleteUserDataAl(emailController.text);
            print("user failed to upload firebasefirestore");
          }
        // }
      } else {
hideLoadingDialog();
        print("user failed to upload signup firebase auth");
      }

    // }
  }
  Future<void> storeUserName(String email) async {
    persistentDataController.userName.value = await FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .get()
        .then((value) {
      final data = value.data();
      return data?["customerName"] ?? "Unknown User"; // Default value if null
    }).catchError((error) {
      print("Error fetching username: $error");
      return "Unknown User";  // Fallback in case of error
    });
  }
}

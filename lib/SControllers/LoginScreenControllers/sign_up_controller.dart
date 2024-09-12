import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_kart/Firebase/FirebaseFirestore/firestore_firebase.dart';
import 'package:pet_kart/Models/customer.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Firebase/FirebaseStorage/cloud_storage.dart';

class SignUpController extends GetxController {
  final nicknameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>(debugLabel: "signup");

  var image = Rx<File?>(null);
  var obscurePassword = true.obs;
  var obscureConfirmPassword = true.obs;

@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nicknameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
    }
  }

  void toggleObscurePassword() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleObscureConfirmPassword() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void signUpUser() async {
    if (formKey.currentState?.validate() ?? false) {
      // Handle sign up logic here
      print('Nickname: ${nicknameController.text}');
      print('Email: ${emailController.text}');
      print('Password: ${passwordController.text}');
      if (await EmailPassLoginAl()
          .signUpAL( emailController.text, passwordController.text)) {
        print("here");
        String profileUrl = await CloudStorage()
            .uploadImageAL(image.value, emailController.text);
        if (profileUrl == "" || profileUrl.isEmpty) {
          print("here1");
          await EmailPassLoginAl().deleteUser();
          print("user failed to upload userproffile");
        } else {
          print("here2");

          Customer signupUser=Customer(customerName: nicknameController.text, email: emailController.text, profileUrl: profileUrl);
          bool userDataUploadStatus =
              await FirestoreFirebaseAL().uploadUserDataAL(signupUser);
          if (userDataUploadStatus) {
            print("here3");
            Get.toNamed("/emailverify");
          } else {
            print("here4");
            EmailPassLoginAl().deleteUser();
            CloudStorage().deleteProfile(emailController.text);
            FirestoreFirebaseAL().deleteUserDataAl(emailController.text);
            print("user failed to upload firebasefirestore");
          }
        }
      } else {
        print("here5");
        print("user failed to upload signup firebase auth");
      }
    }
  }
}

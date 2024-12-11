import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_kart/SControllers/BottomNavController/bottom_nav_controller.dart';
import 'package:pet_kart/SControllers/theme_controller.dart';
import 'package:rive/rive.dart';
import 'package:flutter/services.dart';

class SettingsScreenController extends GetxController {
  ThemeController themeController = Get.find<ThemeController>();

  Rx<Artboard?> riveArtboard2 = Rx<Artboard?>(null);

  SMIInput<bool>? toggleInput2;
  RxBool notification = false.obs;
  bool check = true;

  @override
  void onInit() {
    super.onInit();

    rootBundle.load('assets/rive/dark_light_switch.riv').then((data) async {
      final file2 = RiveFile.import(data);
      final artboard2 = file2.mainArtboard;

      final controller2 = StateMachineController.fromArtboard(
        artboard2,
        'State Machine 1',
      );

      if (controller2 != null) {
        artboard2.addController(controller2);

        toggleInput2 = controller2.findInput<bool>('isDark');
      }

      riveArtboard2.value = artboard2;
    });
  }

  void toggle2() {
    if (toggleInput2 != null) {
      toggleInput2!.value = !(toggleInput2!.value);
      themeController.toggleTheme();
      print('Toggled theme: ${themeController.themeMode.value}');
    }
  }

  bool block = true;

  void handleBackNavigation() {
    if (check && block) {
      block = false;
      Get.offNamed("/home");
      print("true wala");
    } else if (!check && block) {
      block = false;
      Get.offNamed("/home");
      print("false wala");
    }
  }


  // RxString nameFieldValue = ''.obs;
  //
  // void submit() async {
  // if (nameFieldValue.isEmpty) {
  // Get.snackbar(
  // "Error",
  // "Name field cannot be empty!",
  // snackPosition: SnackPosition.BOTTOM,
  // backgroundColor: Colors.red,
  // colorText: Colors.white,
  // );
  // return;
  // }
  //
  // final FirebaseAuth auth = FirebaseAuth.instance;
  // final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //
  // try {
  // // Get the current user's UID
  // final User? user = auth.currentUser;
  // if (user == null) {
  // throw Exception("User is not logged in.");
  // }
  // final String uid = user.uid;
  //
  // // Update the name in Firestore
  // await firestore.collection('vendorusers').doc(uid).update({
  // 'userName': nameFieldValue.value,
  // });
  //
  // // Notify success
  // Get.snackbar(
  // "Success",
  // "Name updated successfully!",
  // snackPosition: SnackPosition.BOTTOM,
  // backgroundColor: Colors.green,
  // colorText: Colors.white,
  // );
  //
  // // Optionally clear the field
  // nameFieldValue.value = '';
  // } catch (e) {
  // // Handle errors
  // Get.snackbar(
  // "Error",
  // "Failed to update name: $e",
  // snackPosition: SnackPosition.BOTTOM,
  // backgroundColor: Colors.red,
  // colorText: Colors.white,
  // );
  // }
  // }
  // Future<String?> selectCropAndUploadImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   final FirebaseStorage storage = FirebaseStorage.instance;
  //
  //   try {
  //     // Step 1: Select an image from the gallery
  //     final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //
  //     if (pickedImage == null) {
  //       return null; // User canceled image selection
  //     }
  //
  //     // Step 2: Crop the selected image
  //     final croppedImage = await ImageCropper().cropImage(
  //       sourcePath: pickedImage.path,
  //       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
  //       uiSettings: [
  //         AndroidUiSettings(
  //           toolbarTitle: 'Crop Image',
  //           toolbarColor: Get.theme.colorScheme.primary,
  //           toolbarWidgetColor: Colors.white,
  //           lockAspectRatio: false,
  //         ),
  //       ],
  //     );
  //
  //     if (croppedImage == null) {
  //       return null; // User canceled cropping
  //     }
  //
  //     // Step 3: Get the user's email for the file name
  //     final User? user = auth.currentUser;
  //     if (user == null || user.email == null) {
  //       throw Exception("User is not logged in or email is unavailable");
  //     }
  //     final String uid = user.uid;
  //     final String fileName = "$uid-profile.jpg";
  //
  //     // Step 4: Upload the cropped image to Firebase Storage
  //     final File imageFile = File(croppedImage.path);
  //     final Reference storageRef = storage.ref().child("userprofile/$fileName");
  //
  //     final UploadTask uploadTask = storageRef.putFile(imageFile);
  //     final TaskSnapshot snapshot = await uploadTask;
  //     final String downloadUrl = await snapshot.ref.getDownloadURL();
  //
  //     // Step 5: Update the vendorUser document in Firestore with profileUrl
  //     await firestore.collection('users').doc(uid).update({
  //       'profileUrl': downloadUrl,
  //     });
  //
  //     print("Profile URL updated successfully in Firestore: $downloadUrl");
  //     return downloadUrl;
  //   } catch (e) {
  //     print('Error during image upload: $e');
  //     return null;
  //   }
  // }
  }




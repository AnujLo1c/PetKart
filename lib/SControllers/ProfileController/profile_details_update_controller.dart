import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:image_picker/image_picker.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class ProfileDetailsUpdateController extends GetxController {
  var name = ''.obs;
  var address = ''.obs;
  var croppedImagePath = ''.obs; // Holds the path of the cropped image
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  String uid = EmailPassLoginAl().getEmail();
  File? croppedImage; // Holds the actual cropped image file

  Future<void> selectAndCropImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      // Step 1: Pick an image
      final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);

      if (pickedImage == null) {
        Get.snackbar('Cancelled', 'Image selection cancelled');
        return;
      }

      // Step 2: Crop the image
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Get.theme.colorScheme.primary,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: true,
          ),
        ],
      );

      if (croppedFile != null) {
        croppedImage = File(croppedFile.path);  // Assign the cropped file to the variable
        croppedImagePath.value = croppedFile.path;  // Update the cropped image path
        Get.snackbar('Success', 'Image cropped successfully');
      } else {
        Get.snackbar('Cancelled', 'Image cropping cancelled');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to select and crop image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (croppedImage == null || !await croppedImage!.exists()) {
      Get.snackbar('No Image', 'Please select and crop an image first');
      return;
    }

    try {
      final File? imageFile = croppedImage;
      final Reference storageRef = storage.ref().child("userprofile/$uid");
      final UploadTask uploadTask = storageRef.putFile(imageFile!);

      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();

      // Update Firestore with the profile URL
      await _firestore.collection('users').doc(uid).update({
        'profileUrl': downloadUrl,
      });

      Get.snackbar('Success', 'Image uploaded successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
    }
    // croppedImage?.delete();
  croppedImagePath.value='';
  }

  void updateProfile() async {
    Map<String, String> updateData = {};

    if (name.value.isNotEmpty) {
      updateData['customerName'] = name.value;
    }
    if (address.value.isNotEmpty) {
      updateData['address'] = address.value;
    }

    try {
      if (updateData.isNotEmpty) {
        await _firestore.collection('users').doc(uid).update(updateData);
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Info', 'No fields to update');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: $e');
    }
  }
}

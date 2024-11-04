import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_kart/Firebase/FirebaseFirestore/firestore_firebase.dart';
import 'package:pet_kart/Firebase/FirebaseStorage/cloud_storage.dart';
import 'package:pet_kart/Models/community_model.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class CommunityCreateController extends GetxController {
  final titleController = TextEditingController();
  final shortDescriptionController = TextEditingController();
  final descriptionController = TextEditingController();

  var selectedImages = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // Pick from gallery
    if (image != null) {
      selectedImages.add(File(image.path));
    } else {
      Get.snackbar('Error', 'No image selected');
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
  }

  void submitImages() {
    if (selectedImages.isEmpty) {
      Get.snackbar('Error', 'No images selected');
    } else {

      Get.snackbar('Success', 'Images submitted successfully!');
    }
  }
  @override
  void onClose() {

    titleController.dispose();
    shortDescriptionController.dispose();
    descriptionController.dispose();
    super.onClose();
  }

  Future<void> createCommunity() async {
    final title = titleController.text;
    final shortDescription = shortDescriptionController.text;
    final description = descriptionController.text;
    final id=title.replaceAll(RegExp(r'\s+'), ' ').trim();
if(await FirestoreFirebaseAL().isPresentCommunity(id)){
  Get.snackbar("Exists", "Community Already Exists.");
}
else{
    CommunityModel communityModel=CommunityModel(
        name: title,
        rating: 0,
        members: [],
        description: description,
    imagesCount: selectedImages.length,
        shortDescription: shortDescription,
        imageUrls: await CloudStorage().uploadCommunityImages(id, selectedImages.value), owner: EmailPassLoginAl().getEmail());
  bool b=await FirestoreFirebaseAL().createCommunity(communityModel);
if(b){
  Get.back();
  showSuccessSnackbar("Community Created Successfully");
}
else{
  CloudStorage()
.deleteCommunityImages(id);  showErrorSnackbar("Some error.");
}
}
    // print("Community Created: $title, $shortDescription, $description");
  }
}

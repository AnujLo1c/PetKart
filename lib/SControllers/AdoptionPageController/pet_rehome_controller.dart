import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
// import 'package:petkart_vendor/Firebase/FirebaseAuth/email_pass_login.dart';

class PetRehomeController extends GetxController {
  // TextEditingControllers for each input field
  final TextEditingController petNameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController deliveryPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();

  // Observables for dropdowns and toggles
  var category = ''.obs;
  var breed = ''.obs;
  var age = ''.obs;
  var gender = ''.obs;
  var color = ''.obs;
  var size = ''.obs;
  var vaccinated = false.obs;
  var publish = false.obs;
  var neutered = false.obs;
  var healthCondition = 'Good'.obs;
  var delivery = false.obs;
var petCompatible=false.obs;
var kidsCompatible=false.obs;
  @override
  void onClose() {
    // Dispose controllers when the screen is closed
    petNameController.dispose();
    priceController.dispose();
    deliveryPriceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }


  var selectedImages = <String>[].obs;
  var primaryImage = Rx<File?>(null);
  Future<void> pickPrimaryImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      primaryImage.value = File(pickedFile.path); // Store the File object
    }
  }
  Future<void> pickImage() async {
    if (selectedImages.length >= 5) {
      Get.snackbar("Limit Reached", "You can only select up to 5 images.");
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.add(pickedFile.path); // Add the selected image path to the list
    }
  }
  Future<void> uploadPetData() async {
    try {
      final CollectionReference petsCollection =
      FirebaseFirestore.instance.collection('adopt_pets');
      final String vendorId = EmailPassLoginAl().getEmail();
      final CollectionReference vendorCollection =
      FirebaseFirestore.instance.collection('users');
      final docRef = await petsCollection.add({
        'petName': petNameController.text.trim(),
        'description': descriptionController.text.trim(),
        'category': category.value,
        'breed': breed.value,
        'age': age.value,
        'gender': gender.value,
        'color': color.value,
        'city': cityController.text,
        'state': stateController.text,
        'size': size.value,
        'nature': size.value,
        'vaccinated': vaccinated.value,
        'neutered': neutered.value,
        'healthCondition': healthCondition.value,
        'petsCompatible': petCompatible.value,
        'kidsCompatible': kidsCompatible.value,
        // 'price': priceController.text.trim(),
        // 'delivery': delivery.value,
        // 'deliveryPrice': delivery.value ? deliveryPriceController.text.trim() : null,
        'publish': publish.value,
        'createdAt': FieldValue.serverTimestamp(),
        'owner':vendorId
      });
//set doc id
      final String docId = docRef.id;
await petsCollection.doc(docId).update({ 'docid':docId});
      // Upload primary image
      if (primaryImage.value != null) {
        final String primaryImagePath = 'adopt_pets/$docId/primary_image.jpg';
        var temp=await _uploadImage(primaryImage.value!, primaryImagePath);

        // Update Firestore with primary image URL
        // final String primaryImageUrl = await _getImageUrl(primaryImagePath);
        await docRef.update({'primaryImageUrl': temp});
      }

      // Upload other selected images
      List<String> listImagesUrl=<String>[];
      if (selectedImages.isNotEmpty) {
        for (int i = 0; i < selectedImages.length; i++) {
          final String imagePath = 'adopt_pets/$docId/images/image_${DateTime.now().millisecondsSinceEpoch}.jpg';
          var temp=await _uploadImage(File(selectedImages[i]), imagePath);
          listImagesUrl.add(temp);
        }
      }
      try {
        // Update or create a document with the list of strings
        await petsCollection.doc(docId).update({
          'stringList': listImagesUrl,
        });

        print("List of strings uploaded successfully!");
      } catch (e) {
        print("Error uploading list of strings: $e");
      }
      await vendorCollection.doc(vendorId).update({
        'AdoptpetsList': FieldValue.arrayUnion([docId],),
       
      },);

      Get.snackbar('Success', 'Pet details uploaded successfully.',backgroundColor: Get.theme.colorScheme.primary);
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload pet details: $e',backgroundColor: Get.theme.colorScheme.primary);
    }
  }

  // Method to upload image to Firebase Storage
  Future<String> _uploadImage(File image, String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    await ref.putFile(image);
    return ref.getDownloadURL();
  }

  // Method to get the URL of an uploaded image
  Future<String> _getImageUrl(String path) async {
    final ref = FirebaseStorage.instance.ref().child(path);
    return await ref.getDownloadURL();
  }
}
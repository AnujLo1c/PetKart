import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';

class AdoptionFormController extends GetxController {
  // TextEditingControllers for form fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  TextEditingController membersController = TextEditingController();
  TextEditingController reasonForAdoptionController = TextEditingController();
  TextEditingController financiallyPreparedController = TextEditingController();
  TextEditingController caretakerController = TextEditingController();

var passedData=Get.arguments;
  var houseType = ''.obs;
  var ownedPetBefore = false.obs;
  var currentlyHavePet = false.obs;
  var termsAccepted = false.obs;

  Future<void> submitForm() async {
    if (termsAccepted.isTrue) {
      await uploadFormDataToFirebase();

      await Get.toNamed("/adopt_thankyou_screen");
    Get.back();
    } else {
      Get.snackbar('Error', 'Please accept terms and conditions',backgroundColor: Colors.black);
    }
  }
  Future<void> uploadFormDataToFirebase() async {
    try {

      CollectionReference adoptionForms = FirebaseFirestore.instance.collection('adopt_pets').doc(passedData[0]).collection('requests');

      String email=EmailPassLoginAl().getEmail();
      String ownerEmail=passedData[1];
      Map<String, dynamic> formData = {
        'full_name': fullNameController.text,
        'address': addressController.text,
        'contact_no': contactNoController.text,
        'members_in_family': membersController.text,
        'reason_for_adoption': reasonForAdoptionController.text,
        'financially_prepared': financiallyPreparedController.text,
        'caretaker': caretakerController.text,
        'house_type': houseType.value,
        'owned_pet_before': ownedPetBefore.value,
        'currently_have_pet': currentlyHavePet.value,

        'requester_email':email,
        'owner_email':ownerEmail,
        'status':'Pending',
        'submitted_at': Timestamp.now(), // To record the submission time
      };

      // Add the form data to Firestore
      await adoptionForms.doc(email).set(formData);

      // Navigate to the thank-you screen after successful upload
      // Get.toNamed("/adopt_thankyou_screen");
    } catch (e) {
      // Handle errors
      Get.snackbar('Error', 'Failed to upload data. Please try again.',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
  @override
  void onClose() {

    fullNameController.dispose();
    addressController.dispose();
    contactNoController.dispose();
    // emailController.dispose();
    membersController.dispose();
    reasonForAdoptionController.dispose();
    financiallyPreparedController.dispose();
    caretakerController.dispose();
    super.onClose();
  }
}

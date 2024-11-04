import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdoptionFormController extends GetxController {
  // TextEditingControllers for form fields
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController membersController = TextEditingController();
  TextEditingController reasonForAdoptionController = TextEditingController();
  TextEditingController financiallyPreparedController = TextEditingController();
  TextEditingController caretakerController = TextEditingController();

  var houseType = ''.obs;
  var ownedPetBefore = false.obs;
  var currentlyHavePet = false.obs;
  var termsAccepted = false.obs;

  void submitForm() {
    if (termsAccepted.isTrue) {
      Get.toNamed("/adopt_thankyou_screen");
    } else {
      Get.snackbar('Error', 'Please accept terms and conditions');
    }
  }

  @override
  void onClose() {

    fullNameController.dispose();
    addressController.dispose();
    contactNoController.dispose();
    emailController.dispose();
    membersController.dispose();
    reasonForAdoptionController.dispose();
    financiallyPreparedController.dispose();
    caretakerController.dispose();
    super.onClose();
  }
}

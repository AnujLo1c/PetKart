import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  var isEmailVerified = false.obs;
  Timer? timer;
  FirebaseAuth fa = FirebaseAuth.instance;
  @override
  void onInit() {
    super.onInit();
    isEmailVerified.value = false;
    fa.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }

  checkEmailVerified() async {

    if (fa.currentUser != null) {
      await fa.currentUser!.reload();

      isEmailVerified.value = fa.currentUser!.emailVerified;

      if (isEmailVerified.value) {

        Get.snackbar("Success", "Email Successfully Verified",
            snackPosition: SnackPosition.BOTTOM);
Get.offNamed('/intro');
        // Get.until((route) => route.settings.name == "/login_signup_screen");

        timer?.cancel();
      }
    }
  }


  void cancelOp() {
    try {
      timer?.cancel();
      fa.currentUser?.delete();
      Get.offNamed("/login");
    } catch (e) {
      debugPrint('$e');
    }
  }

  void resendEmail() {
    try {
      fa.currentUser?.sendEmailVerification();
      Get.snackbar("Mail Sent", "Check your inbox",backgroundColor: Get.theme.colorScheme.primary);
    } catch (e) {
      debugPrint('$e');
      Get.snackbar("To many attempts", "Please try later.",backgroundColor: Get.theme.colorScheme.primary);
    }
  }
}

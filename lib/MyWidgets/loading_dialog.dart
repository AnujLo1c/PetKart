import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoadingDialog({String message = "Loading..."}) {
  Get.dialog(
    const Center(
        child: SizedBox(
          width: 100,
          height: 100,
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: BorderRadius.circular(10),
          // ),
          child: CircularProgressIndicator(),
        ),
      ),
    barrierColor: Colors.grey.withOpacity(0.5),
    // barrierDismissible: false,
  );
}


void hideLoadingDialog() {
  if (Get.isDialogOpen == true) {

    Get.close(1);
    // print("dialog to close.");
  } else {
    print("No dialog to close.");
  }
}
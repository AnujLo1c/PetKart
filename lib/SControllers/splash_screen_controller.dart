import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
class SplashScreenController extends GetxController{
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Timer(Duration(seconds: 3), () => Get.toNamed("/login"),);
  }
}
import 'dart:async';
import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
class SplashScreenController extends GetxController  {
  late AnimationController animationController;
  @override
  void onInit() {
    super.onInit();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Timer(const Duration(milliseconds: 4300), () => Get.offNamed("/login"),);
  }
  var animation=["assets/lotti/splash0.json"];
  // int random=Random().nextInt(1);
  int random=0;
  bool textAnima=false;
}
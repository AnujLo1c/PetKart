import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';


class IntroScreenController extends GetxController {


  onDonePressed(){
    print("home");
    Get.toNamed("/home");
  }

}

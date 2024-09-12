import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:pet_kart/SControllers/AppIntroController/intro_screen_controller.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IntroScreenController introScreenController=Get.put(IntroScreenController());

    return IntroSlider(
      key: UniqueKey(),
      listContentConfig: introScreenController.slides,

    );
  }
}

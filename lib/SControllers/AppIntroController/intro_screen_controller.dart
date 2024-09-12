import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';


class IntroScreenController extends GetxController {
  List<ContentConfig> slides = [];
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    slides.add(
      const ContentConfig(
        title: "Welcome to MyApp",
        styleTitle: TextStyle(
          color: Colors.deepOrange,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "An app that makes your life easier and more fun.",
        styleDescription: TextStyle(
          color: Colors.deepOrange,
          fontSize: 20.0,
        ),
        // pathImage: "assets/image1.png",
        backgroundColor: Colors.white,

      ),
    );

    slides.add(
      const ContentConfig(
        title: "Track Your Activities",
        styleTitle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "Monitor your daily activities and stay on top of your goals.",
        styleDescription: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20.0,
        ),
        // pathImage: "assets/image2.png",
        backgroundColor: Colors.white,
      ),
    );

    slides.add(
      const ContentConfig(
        title: "Stay Connected",
        styleTitle: TextStyle(
          color: Colors.purple,
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
        description: "Stay in touch with your friends and family, anytime, anywhere.",
        styleDescription: TextStyle(
          color: Colors.purple,
          fontSize: 20.0,
        ),
        // pathImage: "assets/image3.png",
        backgroundColor: Colors.white,
      ),
    );
  }
}

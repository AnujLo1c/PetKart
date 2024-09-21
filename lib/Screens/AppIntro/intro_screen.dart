import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:pet_kart/SControllers/AppIntroController/intro_screen_controller.dart';
class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    IntroScreenController introScreenController=Get.put(IntroScreenController());

    return Stack(
      children:[
        Positioned(
          bottom: -70,
          right: -5,
          child: Container(
              width: Get.width+10,
              height: 170,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.primary,
                borderRadius: const BorderRadius.all(
                    Radius.elliptical(200, 100)
                ),

              )),
        ),

      IntroSlider(
        nextButtonStyle: ElevatedButton.styleFrom(
          foregroundColor: Colors.white
        ),
        skipButtonStyle: ElevatedButton.styleFrom(
          foregroundColor: Colors.white
        ),
        doneButtonStyle: ElevatedButton.styleFrom(
          foregroundColor: Colors.white
        ),
        indicatorConfig: IndicatorConfig(

          indicatorWidget: Container(
            width: 8,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.grey.shade500),
          ),
          activeIndicatorWidget: Container(
            width: 8,
            height: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.white),
          ),
          typeIndicatorAnimation: TypeIndicatorAnimation.sliding,
        ),
        navigationBarConfig: NavigationBarConfig(
          backgroundColor: Get.theme.colorScheme.primary,
          navPosition: NavPosition.bottom
        ),
        backgroundColorAllTabs: Colors.transparent,
        key: UniqueKey(),
        onDonePress: () => introScreenController.onDonePressed(),
        listContentConfig:const [
          ContentConfig(
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
          ContentConfig(
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
          ContentConfig(
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
        ],

      ),
        Positioned(
         top: -70,
right: -5,
          child: Container(
            width: Get.width+10,

              height: 170,
              decoration: BoxDecoration(
              color: Get.theme.colorScheme.primary,
              borderRadius: const BorderRadius.all(
              Radius.elliptical(200, 100)
              ),

              )),
        ),

    ]
    );
  }
}

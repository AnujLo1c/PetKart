import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pet_kart/SControllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SplashScreenController splashScreenController=Get.put(SplashScreenController());
    return Scaffold(

      body: SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                splashScreenController.animation[splashScreenController.random],
            width: 200,
              frameRate: FrameRate.max
            ),
            ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[Colors.blue, Colors.lightBlueAccent],
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child:  AnimatedTextKit(
repeatForever: false,
                totalRepeatCount: 1,
                animatedTexts: [
                  FadeAnimatedText(
                  "PETCART",
                  textStyle: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    // Ensure text color contrasts with the gradient
                  ),
                    duration: const Duration(milliseconds: 4300)

                ),
                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}

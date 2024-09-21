import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipOval(
              child: Container(
                height: 250,
                width: 250,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/picture/welcome.png",))
                ),
              ),
            ),
            const Gap(20),
            const Text("Welcome Screen Text",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 16),),
            const Gap(20),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Get.theme.colorScheme.onPrimary,
                  foregroundColor: Get.theme.colorScheme.primary
                ),
                onPressed: (){
              Get.toNamed("/login");
            }, child: const Text("Let's Go"))
          ],
        ),
      ),
    );
  }
}

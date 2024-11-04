import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AdoptionThankyouScreen extends StatelessWidget {
  const AdoptionThankyouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Petkart'),

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Get.theme.colorScheme.secondary,
              ),
              child: Center(
                child: Icon(
                  Icons.check_circle_outline,
                  size: 80,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'THANK YOU',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
             Text(
              'For Getting In Touch With Us',
              style: TextStyle(
                fontSize: 16,
                color: Get.theme.colorScheme.primary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

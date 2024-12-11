import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdoptionThankyouScreen extends StatelessWidget {
  const AdoptionThankyouScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the argument passed to this screen
    String text = Get.arguments ?? '';

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.primaryDelta! > 10) {
          // If a swipe right-to-left is detected, go back
          Get.back();
          printNavigationStack();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Petkart'),
          leading: IconButton(
            onPressed: () {
              // Back navigation on button press
              Get.offAllNamed('/home');
              printNavigationStack();
            },
            icon: const Icon(Icons.chevron_left),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'THANK YOU',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 8),
              text.isNotEmpty
                  ? Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: Get.theme.colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

void printNavigationStack() {
  // Get the current route
  String currentRoute = Get.currentRoute;

  // Get the previous route
  String previousRoute = Get.previousRoute;

  // Print stack information
  print("Current Route: $currentRoute");
  print("Previous Route: $previousRoute");

  // Optional: Print routing history (if tracked)
  print("Navigation Stack: ${Get.routing.route}");
}

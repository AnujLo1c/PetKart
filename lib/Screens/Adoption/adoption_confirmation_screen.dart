import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';


import '../../SControllers/AdoptionPageController/adoption_confirmation_controller.dart';

class AdoptionConfirmationScreen extends StatelessWidget {

  const AdoptionConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final AdoptionConfirmationController controller = Get.put(AdoptionConfirmationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pet Exchange Location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            Obx(
                  () => TextField(
                controller: controller.locationController.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  hintText: "owner's house",
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const Gap(20),
            const Text(
              "Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            Obx(
                  () => TextField(
                controller: controller.dateController.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.pinkAccent),
                  ),
                  hintText: "10/10/2024",
                  contentPadding: EdgeInsets.all(10),
                ),
              ),
            ),
            const Gap(30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  minimumSize: Size(double.infinity, 50),
                ),
                child: const Text(
                  'Processed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/InfoController/info_page_controller.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    InfoPageController infoPageController = Get.put(InfoPageController());

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(() =>
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10.0, // Space between columns
                mainAxisSpacing: 10.0, // Space between rows
                childAspectRatio: 3 / 4, // Aspect ratio of each tile
              ),
              itemCount: infoPageController.petCategories.length,
              itemBuilder: (context, index) {
                var pet = infoPageController.petCategories[index];
                return petTile(pet['image']!, pet['name']!);
              },
            )),

    );
  }

  Widget petTile(String imageUrl, String categoryName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      shadowColor: Colors.grey.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
              child: Image.asset(
                imageUrl, // Load the image here
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
              Gap(5),
              Text(
              categoryName,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),

        ],
      ),
    );
  }
}
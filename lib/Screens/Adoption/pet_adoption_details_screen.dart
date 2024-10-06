import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/pet_adoption_details_screen_controller.dart';

class PetAdoptionDetailsScreen extends StatelessWidget {
  const PetAdoptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the controller
    PetAdoptionDetailsScreenController petAdoptionDetailsScreenController =
    Get.put(PetAdoptionDetailsScreenController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adopt Me"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back action
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 16.0,left: 16,bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Center(
              child: ImageSlideshow(
                width: double.infinity,

                height: 300,


                initialPage: 0,
                autoPlayInterval: 10000,

                children: petAdoptionDetailsScreenController.cachedImageProviders.map((img) {
                  return Image(image:img );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16.0),

            // Pet Name
            Row(
              children: [
                const Text(
                  "Jax",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      // TODO: implement favorite logic
                    },
                    icon: const Icon(
                      Icons.heart_broken,
                      color: Colors.red,
                    )),
                ElevatedButton(
                    onPressed: () {
                      // TODO: navigate to chat
                    },
                    child: const Text("Adopt"))
              ],
            ),
            const SizedBox(height: 16.0),

            // Facts About Me
            const Text("Facts About Me",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
              ),
              children: [
                factTile("Breed", "Golden Retriever"),
                factTile("Vaccinated", "Yes"),
                factTile("Age", "Adulthood"),
                factTile("Gender", "Male"),
                factTile("Pet ID", "TPN15381"),
                factTile("Neutered", "Yes"),
              ],
            ),
            const SizedBox(height: 16.0),

            const Text("My Info",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            Wrap(
              spacing: 8.0,
              children: [
                infoChip("Spayed"),
                infoChip("Shots Up to Date"),
                infoChip("Good with Cats"),
                infoChip("Good with Dogs"),
                infoChip("Needs Loving Adopter"),
                infoChip("Good with Kids"),
              ],
            ),
            const SizedBox(height: 16.0),

            // My Story
            const Text("My Story",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            const Text("Relocation abroad"),

            // Additional Info
            const SizedBox(height: 16.0),
            const Text("Additional Adoption Info",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            const Text("Very friendly"),

            // Contact Info
            const SizedBox(height: 16.0),
            Container(
              color: Colors.blue.shade100,
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Info",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10.0),
                  Text("Address: Noida, Uttar Pradesh"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget factTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value),
      ],
    );
  }

  Widget infoChip(String label) {
    return Chip(
      label: Text(label),
      backgroundColor: Colors.green.shade100,
    );
  }
}
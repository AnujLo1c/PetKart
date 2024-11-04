import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/pet_adoption_details_screen_controller.dart';

class PetAdoptionDetailsScreen extends StatelessWidget {
  const PetAdoptionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    PetAdoptionDetailsScreenController petAdoptionDetailsScreenController =
        Get.put(PetAdoptionDetailsScreenController());

    return Scaffold(
        appBar: AppBar(
          title: const Text("Adopt Me"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(right: 16.0, left: 16, bottom: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Gap(10),
            Center(
                child: ImageSlideshow(
              width: double.infinity,
              height: 270,
              initialPage: 0,
              autoPlayInterval: 10000,
              children: petAdoptionDetailsScreenController.cachedImageProviders
                  .map((img) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: img,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                );
              }).toList(),
            )),
            const Gap(16.0),
            Row(
              children: [
                RichText(
                  text: const TextSpan(
                      text: "Jax\n",
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: "address",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.normal),
                        )
                      ]),
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
              ],
            ),

            const Gap(8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                tile("Gender", "Female"),
                tile("Age", "10 Months"),
                tile("Breed", "xyz"),
              ],
            ),
            Divider(
              color: Get.theme.colorScheme.primary,
            ),
            const Gap(5.0),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width - 20, 50)),
                onPressed: () {
Get.toNamed("/adopt_form_screen");
                },
                child: const Text("Adopt Now")),
            Gap(10),
            const Text(
              "Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const Row(
              children: [
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nature"),
                    Text("Neutered"),
                    Text("Nature"),
                    Text("Pet-compatible"),
                    Text("Kids-compatible"),
                  ],
                ),
                Gap(20),
                Column(
                  children: [
                    Text("Yes"),
                    Text("Yes"),
                    Text("Yes"),
                    Text("Yes"),
                    Text("Yes"),
                  ],
                )
              ],
            ),
            // Divider(color: Get.theme.colorScheme.primary,),
            const Gap(15.0),
            Row(
              children: [
                const CircleAvatar(),
                const Gap(5),
                Text(
                  "Nandini Dhote",
                  style: TextStyle(
                      color: Get.theme.colorScheme.primary,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Gap(10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: const Text(
                  "The pet is good and well behaving. It is also well trained. "),
            ),
            const Gap(20),
          ]),
        ));
  }

  tile(title, value) {
    return Container(
        padding: const EdgeInsets.all(15),
        width: 110,
        decoration: BoxDecoration(
            color: const Color(0xFFE0D1D1),
            borderRadius: BorderRadius.circular(10)),
        child: RichText(
          textAlign: TextAlign.center, // Center align text inside RichText
          text: TextSpan(
            text: title + '\n',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: value,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.primary),
              ),
            ],
          ),
        ));
  }
}

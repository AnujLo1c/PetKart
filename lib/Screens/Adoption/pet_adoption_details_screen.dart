import 'package:cached_network_image/cached_network_image.dart';
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Obx(() => Center(
              child: petAdoptionDetailsScreenController.imageUrls.isEmpty
                  ? const CircularProgressIndicator()
                  : ImageSlideshow(
                width: double.infinity,
                height: 270,
                initialPage: 0,
                autoPlayInterval: 10000,
                children: petAdoptionDetailsScreenController.imageUrls
                    .map((img) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl: img,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  );
                }).toList(),
              ),
            )),
            const Gap(16.0),
            Obx(() => Row(
              children: [
                RichText(
                  text: TextSpan(
                    text:
                    "${petAdoptionDetailsScreenController.data['petName'] ?? ''}\n",
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                        text:
                        petAdoptionDetailsScreenController.data['city'] ??
                            '',
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    // TODO: implement favorite logic
                  },
                  icon: const Icon(
                    Icons.heart_broken,
                    color: Colors.red,
                  ),
                ),
              ],
            )),
            const Gap(8.0),
            Obx(()=>
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  tile("Gender",
                      petAdoptionDetailsScreenController.data['gender'] ?? 'N/A'),
                  tile("Age",
                      petAdoptionDetailsScreenController.data['age'] ?? 'N/A'),
                  tile("Breed",
                      petAdoptionDetailsScreenController.data['breed'] ?? 'N/A'),
                ],
              ),
            ),
            Divider(
              color: Get.theme.colorScheme.primary,
            ),
            const Gap(5.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width - 20, 50)),
              onPressed: () {
                Get.toNamed("/adopt_form_screen",arguments: [petAdoptionDetailsScreenController.docid,petAdoptionDetailsScreenController.ownerEmail]);
              },
              child: const Text("Adopt Now"),
            ),
            const Gap(10),
            const Text(
              "Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
             Row(
              children: [
                const Gap(10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nature"),
                    Text("Neutered"),
                    Text("Health Condition"),
                    Text("Vaccinated"),
                    Text("Pet-compatible"),
                    Text("Kids-compatible"),
                  ],
                ),
                const Gap(20),
                Obx(()=>
                   Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(petAdoptionDetailsScreenController.data['nature']??"NA"),
                      Text((petAdoptionDetailsScreenController.data['neutered'] ?? false) ? 'Yes' : 'No'),
                      Text(petAdoptionDetailsScreenController.data['healthCondition']??"good"),
                       Text(petAdoptionDetailsScreenController.data['vaccinated']??false?'Yes':'No'),
                       Text(petAdoptionDetailsScreenController.data['petsCompatible']??false?'Yes':'No'),
                       Text(petAdoptionDetailsScreenController.data['kidsCompatible']??false?'Yes':'No'),
                    ],
                  ),
                )
              ],
            ),
            // Divider(color: Get.theme.colorScheme.primary,),
            const Gap(15.0),
            Obx(
                ()=> Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    child: petAdoptionDetailsScreenController.ownerUrl.value != 'null'
                        ? ClipOval(
                      child: Image.network(
                        petAdoptionDetailsScreenController.ownerUrl.value,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                        : Icon(Icons.person),
                  ),

                  const Gap(5),
                  Text(
                    petAdoptionDetailsScreenController.owner.value,
                    style: TextStyle(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Container(
              width: Get.width-20,

              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey)),
              child: Obx(()=>
                Text(
                    petAdoptionDetailsScreenController.data['description']??"No Description"
                ),
              ),
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }

  Widget tile(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      width: 110,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D1D1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        textAlign: TextAlign.center,
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
      ),
    );
  }

}

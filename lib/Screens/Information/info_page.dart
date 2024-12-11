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
      padding: const EdgeInsets.all(12.0),
      child: ListView.builder(
        itemCount: infoPageController.petCategories.length,
        itemBuilder: (context, index) {
          final petCategory = infoPageController.petCategories[index];
          return PetCategoryTile(
            title: petCategory.title,
            description: petCategory.description,
            imageUrl: petCategory.imageUrl,
          );
        },
      ),
    );
  }
}

class PetCategoryTile extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;

  const PetCategoryTile({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        height: 105,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
        decoration: BoxDecoration(

          border: Border.all(color: Colors.pink.shade200),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Gap(35),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                  // Gap(10)
                ],
              ),
            ),
            Gap(12)
          ],
        ),
      ),
      Container(
        height: 70,
        width: 70,
        margin: const EdgeInsets.symmetric(vertical: 25),
        decoration: BoxDecoration(
          color: Colors.white,
            image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.cover),

            border: Border.all(color: Get.theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(10)),
      ),
      Positioned(
        right: 5,
        top: 35,
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Get.theme.colorScheme.primary),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(
              Icons.chevron_right,
              color: Get.theme.colorScheme.primary,
            ),
            color: Colors.white,
            onPressed: () {
              Get.toNamed("/info_options_screen",arguments: title);
            },
          ),
        ),
      )
    ]);
  }
}

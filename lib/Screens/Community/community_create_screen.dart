

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../SControllers/CommunityController/community_create_controller.dart';

class CommunityCreateScreen extends StatelessWidget {
  const CommunityCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityCreateController controller =
        Get.put(CommunityCreateController());
    Color primary = Get.theme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Community'),
        backgroundColor: primary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Gap(10),
              TextField(
                controller: controller.titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primary),
                  ),
                  hintText: 'Title',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Gap(16),
              TextField(
                controller: controller.shortDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Short Description',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primary),
                  ),

                  // labelText: 'Title',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 2,
                maxLength: 200,
              ),
              const Gap(10),
              TextField(
                controller: controller.descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: primary),
                  ),

                  // labelText: 'Title',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                maxLines: 4,
                maxLength: 400,
              ),
              const Gap(10),
              ElevatedButton.icon(
                onPressed: () {
                  controller.pickImage();
                },
                icon: const Icon(Icons.image),
                label: const Text('Add Image'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: Size(Get.width - 20, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Gap(10),
              Obx(() {
                if (controller.selectedImages.isNotEmpty) {
                  return SizedBox(
                    height: 140,
                    child: GridView.builder(
                      itemCount: controller.selectedImages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 100,
                          padding: EdgeInsets.zero,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  FileImage(controller.selectedImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              // Implement remove image functionality here
                              controller.selectedImages.removeAt(index);
                            },
                            child: const Icon(Icons.cancel_outlined,
                                color: Colors.red),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const SizedBox(); // Placeholder if no images
                }
              }),
              const Gap(16),
              ElevatedButton(
                onPressed: () {
                  // Call the function to create a community
                  controller.createCommunity();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../SControllers/ProfileController/profile_details_update_controller.dart';

class ProfileDetailsUpdateScreen extends StatelessWidget {
  const ProfileDetailsUpdateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileDetailsUpdateController controller = Get.put(ProfileDetailsUpdateController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Basic Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              buildTextField('Name', controller.name),
              const SizedBox(height: 10),
              buildTextField('Address', controller.address),
              const SizedBox(height: 20),

              buildUpdateButton('Update Details', controller.updateProfile),
            const Divider(),
            const Gap(20),
            Obx(() {
              return (controller.croppedImagePath.isNotEmpty)
                  ? Center(
                child: Column(
                  children: [
                    Image.file(
                      File(controller.croppedImagePath.value),
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              )
                  : ElevatedButton(
                onPressed: controller.selectAndCropImage,
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width-20, 50)
                      ,backgroundColor: Get.theme.colorScheme.secondary
                ),
                child: const Row(
                  children: [
                    Text('Select and Crop Image'),
    Spacer(),
    Icon(Icons.add_a_photo)
                  ],
                ),
              );
            }),


              const SizedBox(height: 20),


              ElevatedButton(
                onPressed: controller.uploadImage,
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width-20, 50)
                ),
                child: const Text('Upload Image'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText, RxString reactiveValue) {
    return Obx(() {
      return TextField(
        controller: TextEditingController(text: reactiveValue.value)
          ..selection = TextSelection.collapsed(offset: reactiveValue.value.length),
        onChanged: (text) => reactiveValue.value = text,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    });
  }

  Widget buildUpdateButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}


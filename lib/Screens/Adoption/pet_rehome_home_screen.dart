import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../SControllers/AdoptionPageController/pet_rehome_home_controller.dart';

class PetRehomeHomeScreen extends StatelessWidget {
  const PetRehomeHomeScreen({super.key}); // Define the primary color

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Get.theme.colorScheme.primary;
    final PetRehomeHomeController controller =
        Get.put(PetRehomeHomeController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pets'),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Obx(() {
          if (controller.pets.isEmpty && controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.pets.isEmpty && !controller.isLoading.value) {
            return Center(
              child: Text('No Pet Uploaded'),
            );
          }

          return ListView.builder(
            itemCount: controller.pets.length,
            itemBuilder: (context, index) {
              final pet = controller.pets[index];
              return
                Slidable(
                  key: ValueKey(pet.id),
                  closeOnScroll: true,
 // Prevent full dismiss
                  endActionPane: ActionPane(
                    motion: const StretchMotion(), // Smooth sliding effect
                    extentRatio: 0.25, // Limit slide to 25% of total width
                    children: [
                      SlidableAction(
                        onPressed: (context) {
                          controller.deletePet(pet.id); // Perform delete action
                        },
                        borderRadius: BorderRadius.circular(10),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: ()=>Get.toNamed('/adoption_requests_screen',arguments: [pet.id,pet.petName]),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pet.primaryImageUrl),
                        radius: 30,
                      ),
                      title: Text(pet.petName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Age: ${pet.age}'),
                          Text('Created At: ${DateFormat('yyyy-MM-dd').format(pet.createdAt.toLocal())}'),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  ),
                );

            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Trigger add pet logic
          await Get.toNamed('/adopt_rehome');
          controller.fetchPets();
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

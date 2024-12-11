import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/adoption_page_controller.dart';
import 'package:pet_kart/MyWidgets/custom_fillers.dart';

// import 'package:share_plus/share_plus.dart';
class AdoptionPage extends StatelessWidget {
  const AdoptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    AdoptionPageController adoptionPageController =
        Get.put(AdoptionPageController());

    return SingleChildScrollView(
      padding: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          const Gap(10),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              ElevatedButton(
              onPressed: () {
                // Handle your button press
Get.toNamed("/adopt_rehome_home",);
              },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(Get.width/2-20, 50)
                ),
              child: const Text("Pet Rehoming"),
            ),
            ElevatedButton(onPressed: (){
Get.toNamed("/adopt_chat_home");
            },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width/2-10, 50)
                ),
                child: const Text("Ongoing Chat")),

            ]
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(10),
              Expanded(
                flex: 3,
                child: Obx(() => DropdownButton<String>(
                  elevation: 5,
dropdownColor: Get.theme.colorScheme.secondary,
                      value: adoptionPageController.selectedPetType.value,
                      items:
                          adoptionPageController.petTypes.map((String petType) {
                        return DropdownMenuItem<String>(
                          value: petType,
                          child: Text(petType),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        adoptionPageController.selectedPetType.value =
                            newValue!;
                      },
                  borderRadius: BorderRadius.circular(10),
                  menuWidth: 120,
                  alignment: Alignment.bottomRight,

                    )),
              ),
              const SizedBox(width: 10), // Space between the dropdowns
              // Small Dropdown for Pet Sizes
              Expanded(
                flex: 2,
                child: Obx(() => DropdownButton<String>(
                  elevation: 5,
                  dropdownColor: Get.theme.colorScheme.secondary,
                      value: adoptionPageController.selectedCity.value,
                      items:
                          adoptionPageController.petCities.map((String petSize) {
                        return DropdownMenuItem<String>(
                          value: petSize,
                          child: Text(petSize),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        adoptionPageController.selectedCity.value =
                            newValue!;
                      },
                  borderRadius: BorderRadius.circular(10),
                  menuWidth: 120,
                  alignment: Alignment.bottomRight,

                )),
              ),
            ],
          ),

        Obx(() => StreamBuilder(
          stream: adoptionPageController.getStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text('No data available'),
              );
            }

            var documents = snapshot.data!.docs;

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> petData = documents[index].data() as Map<String, dynamic>;



                return GestureDetector(
                  onTap: () {
                    // Ensure docid is not null before calling the method
                    final docId = petData['docid'];
                    if (docId != null) {
                      adoptionPageController.navToPetDetails(docId);
                    } else {
                      // Handle null docid if needed
                      print("DocId is null for this pet.");
                    }
                  },
                  child: Container(
                    height: 120,
                    width: Get.width,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Get.theme.colorScheme.primary),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Get.theme.colorScheme.primary),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: 100,
                          width: 100,
                          child: handeledNetworkImage(petData['primaryImageUrl']),
                        ),
                        const Gap(10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(5),
                            Text(
                              "Name: ${petData['petName'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Age: ${petData['age'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "Gender: ${petData['gender'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "City: ${petData['city'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 12),
                            ),
                            Text(
                              "State: ${petData['state'] ?? 'Unknown'}",
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ))



        ],
      ),
    );
  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/adoption_page_controller.dart';
import 'package:share_plus/share_plus.dart';
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
          Row(
            children:[
              ElevatedButton(
              onPressed: () {
                // Handle your button press
              },
              child: const Text("Pet Rehoming"),
            ),
            ElevatedButton(onPressed: (){
Get.toNamed("/adopt_chat_home");
            }, child: const Text("Ongoing Chat")),

            ]
          ),
          //Selection section
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Obx(() => DropdownButton<String>(
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
                    )),
              ),
              const SizedBox(width: 10), // Space between the dropdowns
              // Small Dropdown for Pet Sizes
              Expanded(
                flex: 2,
                child: Obx(() => DropdownButton<String>(
                      value: adoptionPageController.selectedPetSize.value,
                      items:
                          adoptionPageController.petSizes.map((String petSize) {
                        return DropdownMenuItem<String>(
                          value: petSize,
                          child: Text(petSize),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        adoptionPageController.selectedPetSize.value =
                            newValue!;
                      },
                    )),
              ),
            ],
          ),
          
          StreamBuilder(
            stream: Stream.value(5),
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

              if (!snapshot.hasData) {
                return const Center(
                  child: Text('No data available'),
                );
              }

              //if everthing goes well
              return GestureDetector(
                onTap: (){
                  adoptionPageController.navToPetDetails(0);
                },
                child: Container(
                  height: 100,
                  width: Get.width,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2)
                  ),
                  child: const Row(
                    children: [
                      Image(image: AssetImage("assets/picture/cat.png")),
                      Text("Name Age,\n Gender, city , state(optional)"),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

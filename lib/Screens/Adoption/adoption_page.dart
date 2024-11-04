import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
          const Gap(10),
          Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    )),
              ),
              const SizedBox(width: 10), // Space between the dropdowns
              // Small Dropdown for Pet Sizes
              Expanded(
                flex: 2,
                child: Obx(() => DropdownButton<String>(
                  elevation: 5,
                  dropdownColor: Get.theme.colorScheme.secondary,
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

              return GestureDetector(
                onTap: (){
                  adoptionPageController.navToPetDetails(0);
                },
                child: Container(
                  height: 120,
                  width: Get.width,
padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2,color:Get.theme.colorScheme.primary ),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      
                      Container(

                        decoration: BoxDecoration(
                        border: Border.all(color: Get.theme.colorScheme.primary)
                          ,borderRadius: BorderRadius.circular(21)
                            ,image: const DecorationImage(image: AssetImage("assets/picture/cat.png",),fit: BoxFit.fill),
                      ),
                      height: 100,width: 100,
                      ),
                      const Gap(10),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [Gap(5),
                          Text("Name: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                          Text("Age: ",style: TextStyle(fontSize: 12),),
                          Text("Gender: ",style: TextStyle(fontSize: 12),),
                          Text("City: ",style: TextStyle(fontSize: 12),),
                          Text("State: ",style: TextStyle(fontSize: 12),)
                        ],
                      )
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

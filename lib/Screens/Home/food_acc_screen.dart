import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/HomeController/food_acc_controller.dart';

class FoodAccScreen extends StatelessWidget {
  const FoodAccScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FoodAccController foodAccController = Get.put(FoodAccController());
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(  
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              SizedBox(
                height: 105,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          const Gap(5),
                          const Image(
                            image: AssetImage("assets/picture/puppy.png"),
                          ),
                          Text(foodAccController.categories[index]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Gap(10),
              Obx(() => ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,  // Add shrinkWrap to fit within SingleChildScrollView
                itemBuilder: (context, index) => ProductTile(
                  index: index,
                  foodAccController: foodAccController,
                ),
                separatorBuilder: (context, index) => const Gap(12),
                itemCount: foodAccController.itemCount.value,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final int index;
  final FoodAccController foodAccController;
  const ProductTile({super.key, required this.index, required this.foodAccController});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Get.theme.colorScheme.primary),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 90,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Get.theme.colorScheme.primary),
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/picture/petFood.png"),
              ),
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Food"),
              Text("Weight/Size: 500gr"),
              Text("Rating: 4.5"),
              Text("Price: 4000"),
            ],
          ),
        ],
      ),
    );
  }
}

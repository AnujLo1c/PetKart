import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

import '../../SControllers/HomeController/pet_buy_controller.dart';


class PetBuyScreen extends StatelessWidget {
  const PetBuyScreen({super.key});


  @override
  Widget build(BuildContext context) {
  final PetBuyController petBuyController = Get.put(PetBuyController());
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
        backgroundColor: Colors.pinkAccent,

      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: petBuyController.breedFilter.value,
                    items: <String>['All Breeds', 'Labrador', 'Beagle', 'Pomeranian']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      petBuyController.breedFilter.value = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const Gap(10),
              ],
            ),
            const Gap(10),

            Expanded(
              child: Obx(() {
                return ListView.separated(
                  itemCount: petBuyController.dogsList.length,
                  separatorBuilder: (context, index) => const Gap(10),
                  itemBuilder: (context, index) {
                    return DogTile(
                      name: petBuyController.dogsList[index]['name'] ?? 'Unknown', // Provide a default value
                      gender: petBuyController.dogsList[index]['gender'] ?? 'Unknown',
                      age: petBuyController.dogsList[index]['age'] ?? 'Unknown',
                      location: petBuyController.dogsList[index]['location'] ?? 'Unknown',
                      price: petBuyController.dogsList[index]['price'] ?? '0',  // Default price as '0'
                      imageUrl: petBuyController.dogsList[index]['image'] ?? 'assets/picture/puppy.png', // Default image
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for Dog Tile
class DogTile extends StatelessWidget {
  final String name;
  final String gender;
  final String age;
  final String location;
  final String price;
  final String imageUrl;

  const DogTile({
    Key? key,
    required this.name,
    required this.gender,
    required this.age,
    required this.location,
    required this.price,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.pinkAccent),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    TagWidget(text: gender, color: Colors.pink),
                    const Gap(5),
                    TagWidget(text: age, color: Colors.pink[200]!),
                  ],
                ),
                Text(location, style: const TextStyle(color: Colors.grey)),
                Text("Rs.$price", style: const TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class TagWidget extends StatelessWidget {
  final String text;
  final Color color;

  const TagWidget({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}

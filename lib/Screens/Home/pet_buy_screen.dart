import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import '../../SControllers/HomeController/pet_buy_controller.dart';
import '../../models/cart_animal_item.dart'; // Import the CartAnimalItem model

class PetBuyScreen extends StatelessWidget {
  const PetBuyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PetBuyController petBuyController = Get.put(PetBuyController());
    final Color primary = Get.theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments),
        actions: [IconButton(onPressed: (){
          Get.toNamed('/cart_animal_screen');
        }, icon: Icon(Icons.shopping_cart))],
        backgroundColor: primary,
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
            const Gap(20),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: petBuyController.getPetsStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(child: Text("Error loading data"));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No pets available"));
                  }

                  final pets = snapshot.data!.docs;

                  return ListView.separated(
                    itemCount: pets.length,
                    separatorBuilder: (context, index) => const Gap(10),
                    itemBuilder: (context, index) {
                      final doc = pets[index];
                      final petData = doc.data() as Map<String, dynamic>;

                      // Convert to CartAnimalItem
                      final cartAnimal = CartAnimalItem.fromMap(doc.id, petData);

                      return GestureDetector(
                        onTap: (){
                          Get.toNamed('/pet_display_screen',arguments: [doc.id,Get.arguments]);
                        },
                        child: DogTile(
                          cartAnimal: cartAnimal,
                          primary: primary,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated DogTile widget to use CartAnimalItem
class DogTile extends StatelessWidget {
  final CartAnimalItem cartAnimal;
  final Color primary;

  const DogTile({
    super.key,
    required this.cartAnimal,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primary),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image(
              image: NetworkImage(cartAnimal.imageUrl),
              height: 90,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(cartAnimal.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    TagWidget(text: cartAnimal.gender, color: primary),
                    const Gap(5),
                    TagWidget(text: cartAnimal.age, color: primary),
                  ],
                ),
                Text(cartAnimal.location, style: const TextStyle(color: Colors.grey)),
                Text("Rs.${cartAnimal.price}", style: const TextStyle(color: Colors.black)),
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/HomeController/food_acc_controller.dart';

class FoodAccScreen extends StatelessWidget {
  const FoodAccScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodAccController foodAccController = Get.put(FoodAccController());

    return Scaffold(
      appBar: AppBar(
        title: Text(foodAccController.title),
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
                height: 70,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const Gap(20),
                  itemCount: foodAccController.categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child:
                      Column(
                        children: [
                          const Gap(5),
                           Image(
                            image: AssetImage("assets/picture/${foodAccController.categoriesImgs[index]}"),
                             height: 40,
                             width: 50,
                          ),
                          Text(foodAccController.categories[index],style: TextStyle(fontSize: 12),),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const Gap(20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: StreamBuilder<QuerySnapshot>(
                  stream: foodAccController.getProductStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text("Error loading products"));
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text("No products available"));
                    }

                    final products = snapshot.data!.docs;

                    return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true, // Fit within SingleChildScrollView
                      itemBuilder: (context, index) {
                        final product = products[index].data() as Map<String, dynamic>;

                        return ProductTile(
                          product: product,
                        );
                      },
                      separatorBuilder: (context, index) => const Gap(12),
                      itemCount: products.length,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductTile extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
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
                image: DecorationImage(
                  image: NetworkImage(product['primaryImageUrl'] ?? 'assets/picture/petFood.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product['name'] ?? 'Unknown',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                Text("Weight: ${product['weight'] ?? 'N/A'}",style: TextStyle(fontSize: 12),),
                Text("Rating: ${product['rating'] ?? '0.0'}",style: TextStyle(fontSize: 12),),
                Text("Price: Rs.${product['price'] ?? 'N/A'}",style: TextStyle(fontSize: 12),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

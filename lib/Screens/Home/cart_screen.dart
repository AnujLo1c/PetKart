import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Models/cart_animal_item.dart';
import 'package:pet_kart/SControllers/cart_controller.dart';
//animal cart
class CartScreen extends StatelessWidget {

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final AnimalCartController cartController = Get.find<AnimalCartController>();
  Color primary=Get.theme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(
            () {
          final cartItems = cartController.cartItems.values.toList();

          return Column(
            children: [
              // Cart Items
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final CartAnimalItem item = cartItems[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      shadowColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Item Image
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    item.imageUrl,
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.error, size: 70),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Item Details
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${item.name} (${item.gender})",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text("Rs ${item.price}",
                                          style: const TextStyle(fontSize: 14)),
                                      Text("Age: ${item.age}",
                                          style: const TextStyle(fontSize: 14)),
                                      const SizedBox(height: 5),
                                      GestureDetector(
                                        onTap: () {
                                          cartController.removeFromCart(item.id);
                                        },
                                        child: const Text(
                                          "Remove",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                          Divider(),
                          Row(
                            children: [
                              Gap(10),
                              Text("Delivery Charge:"),Spacer(),
                              Text(item.deliveryPrice+" Rs"),
                              Gap(10),
                            ],
                            
                          ),
                          Gap(14)
                        ],
                      ),
                    );
                  },
                ),
              ),
              // Price Details Section
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Price Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Item", style: TextStyle(fontSize: 16)),
                        Text("Rs ${cartController.totalPrice}",
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text("Delivery", style: TextStyle(fontSize: 16)),
                        Text("Rs ${cartController.totalDeliveryPrice}", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Discount", style: TextStyle(fontSize: 16)),
                        Text("0", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Order Total",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Rs ${cartController.totalPrice +cartController.totalDeliveryPrice }",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Continue Button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
Get.toNamed('/address_screen',arguments: [cartController.totalPrice,cartController.totalDeliveryPrice,cartController.dicount]);
                    Get.snackbar("Order", "Proceeding to address...",backgroundColor: Get.theme.colorScheme.primary);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

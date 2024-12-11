import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/SControllers/HomeController/final_order_controller.dart';

class FinalOrderScreen extends StatelessWidget {


  const FinalOrderScreen({super.key}); // Replace with dynamic data

  @override
  Widget build(BuildContext context) {
    FinalOrderController finalOrderController=Get.put(FinalOrderController());
Color primary=Get.theme.colorScheme.primary;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please Confirm and Place your Order',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              'By Clicking Place your Order, You agree to PetKart\'s Terms and Policy',
              style: TextStyle(color: Colors.grey),
            ),
            const Divider(height: 32, color: Colors.grey),

            // Order Details Section
            const Text(
              'Order Details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Item'),
                Text('Rs ${finalOrderController.itemPrice.value}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery'),
                Text('Rs ${finalOrderController.deliveryPrice.value}'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Discount'),
                Text('0'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                 Text(
                  'Order Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rs ${finalOrderController.orderTotal}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // const Divider(height: 32, color: Colors.grey),
            //
            // // Payment Details Section
            // const Text(
            //   'Payment',
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            // ),
            // const SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(finalOrderController.paymentDetails),
            //     Text(finalOrderController.orderDate),
            //   ],
            // ),
            const Divider(height: 32, color: Colors.grey),

            // Delivery Address Section
            const Text(
              'Delivery Address',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: Get.width-20,
              child: Card(
                elevation: 2,

                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${finalOrderController.deliveryAddress['name']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('Address: ${finalOrderController.deliveryAddress['address']}'),
                      Text('Phone: ${finalOrderController.deliveryAddress['phone']}'),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Estimate Arrival Section
            Text(
              'Estimate Arriving ${finalOrderController.deliveryDate}',
              style:  TextStyle(
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
            const Spacer(),

            // Continue Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle Order Placement Logic\
                  Get.toNamed('/pay_confirm_screen',arguments: [Get.arguments[0],Get.arguments[1]]);
                  Get.snackbar('Order Placed', 'Your order has been successfully placed!',
                      snackPosition: SnackPosition.BOTTOM);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

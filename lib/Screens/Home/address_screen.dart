import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../SControllers/HomeController/address_controller.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController addressController = Get.put(AddressController());
    Color primary = Get.theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Placing"),
        backgroundColor: primary,
      ),
      body: Column(
        children: [
          // Add New Address Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                Get.dialog(AddAddressDialog());
              },
              child: Row(
                children: [
                  Icon(Icons.add, color: primary),
                  SizedBox(width: 8),
                  Text("ADD NEW ADDRESS", style: TextStyle(color: primary)),
                ],
              ),
            ),
          ),
          // List of Addresses
          Obx(() {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: addressController.deliveryAddresses.length,
              itemBuilder: (context, index) {
                Map<String, String> address = addressController.deliveryAddresses[index];

                return Obx(() => Card(
                  margin: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(address['name']!),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(address['address']!),
                            Text(address['phone']!),
                          ],
                        ),
                        trailing: Obx(() => Radio<int>(
                          value: index, // Set the index as the value for this radio button
                          groupValue: addressController.selectedAddressIndex.value, // Link to selected index
                          onChanged: (int? value) {
                            addressController.selectedAddressIndex.value = value!; // Update the selected index
                          },
                        )),
                      ),
                      if (addressController.selectedAddressIndex.value == index)
                        ElevatedButton(
                            onPressed: () {
                              // Navigate with the selected address
                              print(Get.arguments);
                              Get.toNamed("/final_order_screen", arguments: [
                                Get.arguments,
                                addressController.deliveryAddresses[addressController.selectedAddressIndex.value],
                              ]);
                            },
                            style: ElevatedButton.styleFrom(minimumSize: Size(Get.width - 60, 40)),
                            child: Text("Deliver to this Address")
                        ),
                      Gap(10)
                    ],
                  ),
                ));
              },
            );
          }),
        ],
      ),
    );
  }
}

// Add Address Dialog
class AddAddressDialog extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final AddressController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Add New Address"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: "Name"),
          ),
          Gap(5),
          TextField(
            controller: addressController,
            decoration: InputDecoration(labelText: "Address"),
          ),
          Gap(5),
          TextField(
            controller: phoneController,
            decoration: InputDecoration(labelText: "Phone"),
            keyboardType: TextInputType.phone,
          ),
          Gap(5),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            // Add new address
            Map<String, String> newAddress = {
              'name': nameController.text,
              'address': addressController.text,
              'phone': phoneController.text,
            };
            controller.addNewAddress(newAddress);
            Get.back();
          },
          style: ElevatedButton.styleFrom(minimumSize: Size(100, 40)),
          child: Text("Add", style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../SControllers/AdoptionPageController/adoption_confirmation_controller.dart';

class AdoptionConfirmationScreen extends StatelessWidget {
  const AdoptionConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdoptionConfirmationController controller = Get.put(AdoptionConfirmationController());
    Color primary = Get.theme.colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption Confirmation"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pet Exchange Location",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Gap(10),
 TextField(
                controller: controller.locationController,
                decoration:  InputDecoration(
                  filled: false,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary, width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primary, width: 2.0),
                  ),
                  hintText: "Owner's house",
                  hintStyle: TextStyle(color: Colors.grey.shade700),
                  contentPadding: EdgeInsets.all(10),
                ),

            ),
            const Gap(20),
            const Text(
              "Select Date",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Gap(10),
            Obx(
                  () => InkWell(
                onTap: () async {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    controller.updateSelectedDate(selectedDate);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: primary,width: 2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    controller.selectedDate.value.isEmpty
                        ? "Select Date"
                        : controller.selectedDate.value,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
            const Gap(20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                  controller.updateDataClearRequests();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

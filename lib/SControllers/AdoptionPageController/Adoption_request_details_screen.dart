import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../SControllers/AdoptionPageController/adoption_requests_controller.dart';

class AdoptionRequestDetailsScreen extends StatelessWidget {
  const AdoptionRequestDetailsScreen({super.key});


  @override
  Widget build(BuildContext context) {
  final AdoptionRequestsController controller =
  Get.put(AdoptionRequestsController());
  final RxString selectedStatus = 'Pending'.obs; // To store the selected value
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Details"),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.requests.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final request = controller.requests;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoTile("Full Name", request[0]['full_name']),
              _buildInfoTile("Email", request[0]['requester_email']),
              _buildInfoTile("Contact No", request[0]['contact_no']),
              _buildInfoTile("Address", request[0]['address']),
              _buildInfoTile("Caretaker", request[0]['caretaker']),
              _buildInfoTile("House Type", request[0]['house_type']),
              _buildInfoTile("Members", request[0]['members_in_family']),
              _buildInfoTile("Status", request[0]['status']),
              const Divider(indent: 5, endIndent: 5),
              _buildLongInfoTile("Currently Have Pet",
                  request[0]['currently_have_pet'] ? "Yes" : "No"),
              _buildLongInfoTile("Owned Pet Before",
                  request[0]['owned_pet_before'] ? "Yes" : "No"),
              _buildLongInfoTile(
                  "Financially Prepared", request[0]['financially_prepared']),
              _buildLongInfoTile(
                  "Reason for Adoption", request[0]['reason_for_adoption']),

              const SizedBox(height: 16.0),
              CustomDropdown(
                options: const ['Hold', 'Reject', 'Accept', 'Pending'],
                initialValue: controller.requests[Get.arguments[1]]['status'],
                onSelected: (value) {
                  selectedStatus.value = value; // Update the selected value
                },
              ),
              const Gap(10),
              ElevatedButton(
                onPressed: () {
                  // Pass the selected value to the function
                 controller.updateRequestStatus(Get.arguments[1], selectedStatus.value);
                 print('back');
Get.back();
                 },
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(Get.width - 10, 50)),
                child: const Text(
                  "Update Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              title + ':',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const Gap(5),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLongInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title:',
            style:
            const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final Function(String) onSelected;

  const CustomDropdown({
    super.key,
    required this.options,
    required this.initialValue,
    required this.onSelected,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final dropdownOptions = [...widget.options]; // Add placeholder option

    return Container(
      width: Get.width - 10, // Set width to Get.width - 10
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          isExpanded: true, // Make dropdown fit the container width
          items: dropdownOptions
              .map((option) => DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
              });
              widget.onSelected(value); // Trigger callback
            }
          },
          dropdownColor: Colors.white, // Background color for the dropdown
          icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
          style: const TextStyle(fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }
}

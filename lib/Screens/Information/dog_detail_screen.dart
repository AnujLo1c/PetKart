import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../SControllers/InfoController/dog_detail_controller.dart';

class DogDetailsScreen extends StatelessWidget {
  const DogDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String docId = Get.arguments as String; // Fetching document ID from Get.arguments
    final DogDetailsController controller = Get.put(DogDetailsController(docId));

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (controller.isLoading.value) {
            return const Text('Loading...');
          }
          return Text(controller.dogData.value?['name'] ?? 'Pet Details');
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.dogData.value == null) {
          return const Center(
            child: Text('No pet data found.'),
          );
        }

        final data = controller.dogData.value!;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Text(
              //     data['name'] ?? 'Unknown',
              //     style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              //   ),
              // ),
              const SizedBox(height: 16),
              buildInfoRow('Alternate Names', data['alternateNames']),
              buildInfoRow('Origin', data['origin']),
              buildInfoRow('Colors', data['colors']),
              buildInfoRow('Height', data['height']),
              buildInfoRow('Weight', data['weight']),
              buildInfoRow('Life Span', data['lifeSpan']),
              buildInfoRow('Exercise Needs', data['exerciseNeeds']),
              buildInfoRow('Training', data['training']),
              buildInfoRow('Grooming', data['grooming']),
              buildInfoRow('Health', data['health']),
              const SizedBox(height: 16),
              const Text(
                'Description:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                data['description'] ?? 'No description available.',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget buildInfoRow(String title, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value ?? 'Not available'),
          ),
        ],
      ),
    );
  }
}

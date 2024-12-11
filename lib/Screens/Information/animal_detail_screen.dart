import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../SControllers/InfoController/animal_detail_controller.dart';


class AnimalDetailsScreen extends StatelessWidget {
  const AnimalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fetching document ID from Get.arguments
    final AnimalDetailsController controller = Get.put(AnimalDetailsController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          if (controller.isLoading.value) {
            return const Text('Loading...');
          }
          return Text(controller.animalData.value?['name'] ?? 'Pet Details');
        }),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.animalData.value == null) {
          return const Center(
            child: Text('No pet data found.'),
          );
        }

        final data = controller.animalData.value!;
print(data);
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              // buildInfoRow('Name', data['name']),
              buildInfoRow('Alternate Names', data['alternateNames'].toString() ?? 'None'),
              buildInfoRow('Origin', data['origin']),
              buildInfoRow('Colors', data['colors'].toString() ?? ''),
              buildRangeRow('Height', data['heightMin'], data['heightMax'], 'inches'),
              buildRangeRow('Weight', data['weightMin'], data['weightMax'], 'kg'),
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

  Widget buildListRow(String title, List<dynamic> values) {
    final formattedValues = values.isNotEmpty
        ? values.join(', ')
        : 'Not available';

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
            child: Text(formattedValues),
          ),
        ],
      ),
    );
  }

  Widget buildRangeRow(String title, dynamic min, dynamic max, String unit) {
    final rangeText = (min != null && max != null)
        ? '$min - $max $unit'
        : 'Not available';

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
            child: Text(rangeText),
          ),
        ],
      ),
    );
  }
}

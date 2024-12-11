import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AnimalDetailsController extends GetxController {
  var isLoading = true.obs; // Observable for loading state
  var animalData = Rx<Map<String, dynamic>?>(null); // Observable for animal data


  final List docId = Get.arguments ;

  @override
  void onInit() {
    super.onInit();
    fetchanimalData();
  }

  Future<void> fetchanimalData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection(docId[1]).doc(docId[0]).get();
      if (doc.exists) {
        animalData.value = doc.data() as Map<String, dynamic>?;
// print(animalData.value);
// print("animalData.value");
      } else {
        print('heree');
        animalData.value = null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
      animalData.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}

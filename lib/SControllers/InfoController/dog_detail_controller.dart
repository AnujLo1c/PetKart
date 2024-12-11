import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DogDetailsController extends GetxController {
  var isLoading = true.obs; // Observable for loading state
  var dogData = Rx<Map<String, dynamic>?>(null); // Observable for dog data

  final String docId; // ID of the document to fetch

  DogDetailsController(this.docId);

  @override
  void onInit() {
    super.onInit();
    fetchDogData();
  }

  Future<void> fetchDogData() async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('info').doc(docId).get();
      if (doc.exists) {
        dogData.value = doc.data() as Map<String, dynamic>?;
      } else {
        dogData.value = null;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch data: $e');
      dogData.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}

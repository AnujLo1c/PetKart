
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class AdoptionPageController extends GetxController{
  List<String> petTypes = ['All','Dog', 'Cat', 'Bird', 'Rabbit', 'Hamster'];
  List<String> petCities = ['All','Indore', 'Bhopal', 'Ujjain'];
  RxString selectedPetType = 'All'.obs;
  RxString selectedCity = 'All'.obs;

  void navToPetDetails(String s) {
    Get.toNamed("/adopt_pet_details",arguments: s);
  }

   Stream<QuerySnapshot> getStream() {
    final collection = FirebaseFirestore.instance.collection('adopt_pets');
    Query query = collection;

    if (selectedPetType.value != 'All') {
      query = query.where("category", isEqualTo: selectedPetType.value);
    }

    if (selectedCity.value !='All') {
      query = query.where("city", isEqualTo: selectedCity.value);
    }

    return query.snapshots();
  }


}
import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_kart/SControllers/cart_controller.dart';


class PetBuyController extends GetxController {
  AnimalCartController animalCartController=Get.put(AnimalCartController(),permanent: true);
  var breedFilter = 'All Breeds'.obs; // Filter for breed
var doc=Get.arguments;
  Stream<QuerySnapshot> getPetsStream() {
    CollectionReference petsRef = FirebaseFirestore.instance.collection('pets').doc(doc).collection(doc);

    if (breedFilter.value == 'All Breeds') {
      return petsRef.where("ordered",isNotEqualTo: true).snapshots();
    } else {
      return petsRef.where('breed', isEqualTo: breedFilter.value).where("ordered",isNotEqualTo: true).snapshots();
    }
  }
}

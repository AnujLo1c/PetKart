
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';


class PetRehomeHomeController extends GetxController {
  var pets = <PetListItem>[].obs;
var isLoading=true.obs;

  Future<void> fetchPets() async {
      final firestore = FirebaseFirestore.instance;
    try {
    final String userEmail=EmailPassLoginAl().getEmail();
      // Reference to Firestore

      // Step 1: Fetch the user's AdoptpetsList from the 'users' collection
      final userDoc = await firestore.collection('users').doc(userEmail).get();

      if (userDoc.exists && userDoc.data() != null) {
        List<dynamic>? petDocIds = userDoc.data()?['AdoptpetsList'];

        if (petDocIds != null && petDocIds.isNotEmpty) {
          // Step 2: Fetch the pet details from 'adopt_pets' collection
          List<PetListItem> fetchedPets = [];

          for (String docId in petDocIds) {
            final petDoc =
            await firestore.collection('adopt_pets').doc(docId).get();

            if (petDoc.exists && petDoc.data() != null) {
              var petData = petDoc.data()!;
              fetchedPets.add(PetListItem(
                id: petDoc.id,
                createdAt: petData['createdAt'].toDate(),
                petName: petData['petName'],
                breed: petData['breed'],
                age: petData['age'].toString(),
                gender: petData['gender'],
                primaryImageUrl: petData['primaryImageUrl'],
              ));
            }
          }

          // Update the pets observable list
          pets.value = fetchedPets;
        } else {
          pets.clear(); // Clear pets list if AdoptpetsList is empty
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch pets: $e',backgroundColor: Colors.black);
    }
  }

  void addPet(PetListItem pet) {
    // Add a new pet to Firebase
  }

  void deletePet(String petId) {
    // Delete a pet from Firebase
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    fetchPets();
 switchLoading();
  }
  switchLoading()  {
     Future.delayed(const Duration(seconds: 2), () {
      isLoading.value = false;
    });
  }
}
class PetListItem {
  final String id;
  final DateTime createdAt;
  final String petName;
  final String breed;
  final String age;
  final String gender;
  final String primaryImageUrl;

  PetListItem({
    required this.id,
    required this.createdAt,
    required this.petName,
    required this.breed,
    required this.age,
    required this.gender,
    required this.primaryImageUrl,
  });
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
class AddressController extends GetxController {
  RxList<Map<String, String>> deliveryAddresses = <Map<String, String>>[].obs;
  String userId = EmailPassLoginAl().getEmail(); // Replace with dynamic user ID.
  RxInt selectedAddressIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  // Fetch addresses from Firestore
  Future<void> fetchAddresses() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // Ensure userDoc.data() is not null and safely access 'deliveryAddresses'
        Map<String, dynamic>? data = userDoc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey('deliveryAddresses')) {
          List<dynamic> addresses = data['deliveryAddresses'] ?? <dynamic>[];

          // Safely cast the dynamic list to a list of Map<String, String>
          deliveryAddresses.value = addresses.map((address) {
            return Map<String, String>.from(address as Map<String, dynamic>);
          }).toList();
        }
      }
    } catch (e) {
      print('Error fetching addresses: $e');
    }
  }

  // Add new address and update Firestore
  Future<void> addNewAddress(Map<String, String> newAddress) async {
    try {
      deliveryAddresses.add(newAddress); // Update local list

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .update({
        'deliveryAddresses': deliveryAddresses.toList(),
      });
      print('Address added successfully!');
    } catch (e) {
      print('Error adding address: $e');
    }
  }
}

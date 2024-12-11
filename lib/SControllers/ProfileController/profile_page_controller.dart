import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class ProfilePageController extends GetxController{
  RxString name="XYZ".obs;
  RxString profileurl="".obs;
  String uid='';
  void fetchUserData() async {
    uid=EmailPassLoginAl().getEmail();
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {

        name.value = userDoc['customerName'] ?? '';
        profileurl.value = userDoc['profileUrl'] ?? '';
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchUserData();
  }

}
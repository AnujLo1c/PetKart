import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Models/community_model.dart';

class CommunitySearchHomeController extends GetxController {
  CommunityModel community=Get.arguments;

RxList<String> members=<String>[].obs;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    members.value=community.members;
  }


  void joinCommunity() async {
    String email = EmailPassLoginAl().getEmail();
    if (!members.contains(email)) {
      members.add(email);
      await FirebaseFirestore.instance
          .collection('community')
          .doc(community.id)
          .update({'members': members});
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email) // Assuming the document ID is the user's email
          .set({
        'joinedCommunities': FieldValue.arrayUnion([community.id])
      }, SetOptions(merge: true));
      update(); // Not strictly necessary as you're updating the members list directly
      //TODO: add community posts to the new user
      showSuccessSnackbar("You have successfully joined the community.");
    } else {
      Get.snackbar("Already Joined", "You are already a member of this community.");
    }
  }
  String formatDateTime(DateTime dateTime) {
    String time = DateFormat('HH:mm').format(dateTime); // Format time as HH:mm
    String date = DateFormat('dd MMM').format(dateTime); // Format date as dd MMM
    return '$time $date';
  }
}

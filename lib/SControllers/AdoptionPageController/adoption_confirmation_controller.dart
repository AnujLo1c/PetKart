import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';

class AdoptionConfirmationController extends GetxController {
  var locationController = TextEditingController();
  var selectedDate = "".obs;
String docid=Get.arguments[0];
String room_name=Get.arguments[1];


  // String requester=Get.arguments[1];
  void updateSelectedDate(DateTime date) {
    selectedDate.value = DateFormat('dd-MM-yyyy').format(date);
  }

  Future<void> updateDataClearRequests() async {
    var ff=FirebaseFirestore.instance;
    String requester=room_name.replaceAll('_', '');
    requester=requester.replaceAll(EmailPassLoginAl().getEmail(), '');
    print(requester);
    try{
      var first_docref=ff.collection('adopt_pets').doc(docid);
      var colRef=first_docref.collection('requests');
      final snapshot = await colRef.get();

      for (final doc in snapshot.docs) {
        if (doc.id != requester) {

          await colRef.doc(doc.id).delete();
          print('Deleted document with ID: ${doc.id}');
        }
      }
      print('Deletion completed!');
first_docref.update({
  "status":'adopted',
"exchangeLocation":locationController.text,
"exchangeDate":selectedDate.value,
});
await Get.toNamed("/adopt_thankyou_screen",arguments: "");
Get.offAllNamed('/home');
    }
    catch(e){
print("deleted failed");
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Models/chatroom_model.dart';
import '../../Models/message_model.dart';
import 'package:uuid/uuid.dart';
class PetAdoptionChatRoomController extends GetxController
    with GetSingleTickerProviderStateMixin {

  var chatRoomData = Get.arguments;
  TextEditingController messageController = TextEditingController();
  var uuid = const Uuid();
    ChatroomModel? c;
    @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
     c= chatRoomData[2];
     // printva(c!.docid??'');
  }
  // printva(String ds)=>print(ds);
  void sendMessage() async {
    String msg = messageController.text.trim();
    messageController.clear();

    if(msg != "") {
      // Send Message
      MessageModel newMessage = MessageModel(
          messageid: uuid.v1(),
          sender: chatRoomData[1],
          createdon: DateTime.now(),
          text: msg,
          seen: false
      );

      FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomData[0]).collection("messages").doc(newMessage.messageid).set(newMessage.toMap());

      c?.lastMsg = msg;

      FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomData[0]).update({"lastMsg":c?.lastMsg});

      print("Message Sent!");
    }
  }




  @override
  void onClose() {
    // animationController.dispose();
    messageController.dispose();
    super.onClose();
  }



  void acceptRequester() {
    // Logic for accepting the requester
    print("Requester Accepted");
print(c?.docid);
Get.back();
print("object");
Get.toNamed("/adopt_confirm_screen",arguments: [c?.docid,chatRoomData[0]]);
  }

  void rejectRequester() {
    // Logic for rejecting the requester
    print("Requester Rejected");
Get.back();
    deleteRequestDocument();
//delete request

  }
  Future<void> deleteRequestDocument() async {
      print(chatRoomData);
String owneremail="";
String requesterName="";
    try {
      // Fetch the document
      final docSnapshot = await FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(chatRoomData[0])
          .get();

      if (docSnapshot.exists) {
        final data = docSnapshot.data();

        if (data != null) {
          // Retain only `roomName` and `participants`
          final roomName = data['roomName'];
          final participants = data['participants'];
          owneremail = data['owner_email'];
 requesterName=data['participantsName'][0];
          // Update the document
          await FirebaseFirestore.instance
              .collection("chatrooms")
              .doc(chatRoomData[0])
              .set({
            'roomName': roomName,
            'participants': participants,
            'status': 'Reject',
          });
          try {
            await FirebaseFirestore.instance
                .collection("chatrooms")
                .doc(chatRoomData[0])
                .update({"status":"Reject"});
            print("Document with ID: ${chatRoomData[0]} successfully deleted from chatrooms.");

          } catch (e) {
            print("Error deleting document: $e");
          }

          print("Document updated successfully.");
        } else {
          print("Document data is null.");
        }
      } else {
        print("Document with ID: docId does not exist.");
      }
    } catch (e) {
      print("Error updating document: $e");
    }
    print(chatRoomData);
    print(owneremail);

    owneremail=chatRoomData[0].replaceAll(owneremail, '');
    owneremail=owneremail.replaceAll('_', '');
    try {
      await FirebaseFirestore.instance
          .collection("adopt_pets")
          .doc(chatRoomData[2].docid).collection('requests').doc(owneremail)
          .set({"status":"Reject","full_name":requesterName});
      print("Document with ID: ${chatRoomData[0]} successfully deleted from chatrooms.");

    } catch (e) {
      print("Error Rejecting document: $e");
    }
    Get.back();
  }

  }



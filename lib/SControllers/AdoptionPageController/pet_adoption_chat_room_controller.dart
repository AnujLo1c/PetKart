import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../Models/chatroom_model.dart';
import '../../Models/message_model.dart';


class PetAdoptionChatRoomController extends GetxController{
  var chatRoomData = Get.arguments;
  TextEditingController messageController = TextEditingController();
  var uuid = const Uuid();
  void sendMessage() async {
    ChatroomModel c=ChatroomModel.fromMap(chatRoomData[2].data());
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

      c.lastMsg = msg;
      print(c);
      FirebaseFirestore.instance.collection("chatrooms").doc(chatRoomData[0]).set(c.toMap());

      print("Message Sent!");
    }
  }
}
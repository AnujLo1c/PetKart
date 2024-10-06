import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Firebase/FirebaseAuth/email_pass_login.dart';

class PetAdoptionChatHomeController extends GetxController {
  String cuName = "";
  String? currentUser = "";
  var len = 0.obs;
  final RxList<bool> selectedItems = <bool>[].obs;
  final RxList<String> selectedrooms = <String>[].obs;
  final RxList<String> allChatrooms = <String>[].obs;

  RxInt selected=0.obs;
  RxString searchQuery="".obs;
  @override
  void onInit() {
    super.onInit();
    setCuName();
    currentUser = EmailPassLoginAl().getEmail();
  }

  Future<void> setCuName() async {
    if (currentUser != null && currentUser!.isNotEmpty) {
      // cuName = await FirestoreFirebaseAL().checkUserExists(currentUser!);
    }
  }

  Future<void> addChatRoom(String user2) async {
    print("Creating chat room with user: $user2");
    // String check = await FirestoreFirebaseAL().checkUserExists(user2);
    // if (check.isNotEmpty) {
    //   String? user1 = EmailPassLoginAl().authUser.currentUser?.email;
    //   if (user1 != null && user1.isNotEmpty) {
    //     String user1NickName = await FirestoreFirebaseAL().checkUserExists(user1);
    //
    //     Chatroom c = Chatroom(
    //       roomName: chatRoomName(user1, user2),
    //       displayName: '$check#$user1NickName',
    //       lastMsg: "",
    //       participants: [user1, user2],
    //       dateTime: DateFormat('dd MMM').format(DateTime.now()),
    //     );
    //
    //     await FirestoreFirebaseAL().createChatRoom(c, user1, user2);
    //   } else {
    //     showErrorSnackbar("Some error occurred. Please re-login.");
    //   }
    // } else {
    //   showErrorSnackbar("No user found");
    // }
  }

  String chatRoomName(String email1, String email2) {
    return (email1.compareTo(email2) > 0) ? email2 + email1 : email1 + email2;
  }

  void showInputDialogChatRoom() {
    TextEditingController textFieldController = TextEditingController();
    Get.defaultDialog(
      title: 'Enter your input',
      content: TextField(
        controller: textFieldController,
        decoration: const InputDecoration(hintText: "Type something here"),
      ),
      textCancel: 'Cancel',
      textConfirm: 'OK',
      onCancel: () {},
      onConfirm: () {
        Get.back();
        addChatRoom(textFieldController.text.trim());
      },
    );
  }

  void setLen(int length) {
    len.value = length;
    selectedItems.clear();
    for (int i = 0; i < length; i++) {
      selectedItems.add(false);
    }
  }

  void toggleSelection(int index) {
    selectedItems[index]=!selectedItems[index];
  }
  selectAll(){
    selectedrooms.clear();
    selectedrooms.addAll(allChatrooms);
    selected.value=selectedrooms.length;
    for(int i=0;i<len.value;i++){
      selectedItems[i]=true;
    }
  }
  unSelectAll(){
    selectedrooms.clear();
    selected.value=0;
    for(int i=0;i<len.value;i++){
      selectedItems[i]=false;

    }
  }

  void setChatRoomNames(List<QueryDocumentSnapshot<Object?>> docs) {
    allChatrooms.clear();
    for(int i=0;i<len.value;i++){
      allChatrooms.add(docs[i]['roomName']);
    }
  }

  void clearRooms() {
    selectedrooms.clear();
    allChatrooms.clear();
    selected.value=0;
  }

  void updateSearchText(String val) {
    searchQuery.value = val.toLowerCase();
  }
}

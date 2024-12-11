import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pet_kart/Models/chatroom_model.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/pet_adoption_chat_home_controller.dart';

class PetAdoptionChatHome extends StatelessWidget {
  const PetAdoptionChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    final petAdoptionChatHomeController = Get.put(PetAdoptionChatHomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chats"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ChatSearchField(controller: petAdoptionChatHomeController),
          Expanded(
            child: ChatRoomList(controller: petAdoptionChatHomeController),
          ),
        ],
      ),
    );
  }
}

class ChatSearchField extends StatelessWidget {
  final PetAdoptionChatHomeController controller;

  const ChatSearchField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(Icons.search, color: Colors.grey.shade600, size: 20),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.all(8),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.grey.shade100),
        ),
      ),
      onChanged: controller.updateSearchText,
    );
  }
}

class ChatRoomList extends StatelessWidget {
  final PetAdoptionChatHomeController controller;

  const ChatRoomList({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: controller.searchQuery.value.isEmpty
          ? FirebaseFirestore.instance
          .collection("chatrooms")
          .where("participants", arrayContains: controller.currentUser)
          .snapshots()
          : FirebaseFirestore.instance
          .collection("chatrooms")
          .where("participants", arrayContainsAny: [
        controller.currentUser,
        controller.searchQuery.value,
      ])
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No chatrooms found.'));
        } else {
          controller.setLen(snapshot.data!.docs.length);
          controller.setChatRoomNames(snapshot.data!.docs);
var filteredDocs = snapshot.data!.docs.where((doc) {
            return doc['status'] != 'Reject';
          }).toList();
          return filteredDocs.length==0?
          const Center(child: Text('No chatrooms found.')):

        Obx(
                () => ListView.builder(
              itemCount: controller.len.value,
              itemBuilder: (context, index) {
                final chatroom = filteredDocs[index];
                final roomName = chatroom['displayName'].split('#')[0];

                return  ChatRoomTile(
                  chatroom: chatroom,
                  roomName: roomName,
                  index: index,
                  controller: controller,
                );
              },
            ),
          );
        }
      },
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final QueryDocumentSnapshot chatroom;
  final String roomName;
  final int index;
  final PetAdoptionChatHomeController controller;

  const ChatRoomTile({
    required this.chatroom,
    required this.roomName,
    required this.index,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = controller.selectedItems[index];
    final lastMsg = chatroom['status'] ? chatroom['lastMsg'] : "Requested";
DateTime dt=chatroom['dateTime'].toDate();
    // DateFormat.yMMMd().format(dt);
    return ListTile(
      title: Text(roomName),
      subtitle: Text(lastMsg, maxLines: 1),
      selected: isSelected,
      selectedTileColor: Colors.grey,
      trailing: Text(DateFormat.yMMMd().format(dt).toString()),
      onTap: () {
        if (isSelected) {
          controller.toggleSelection(index);
          controller.selected--;
          controller.selectedrooms.remove(chatroom['roomName']);
        } else if (controller.selected > 0) {
          controller.toggleSelection(index);
          controller.selected++;
          controller.selectedrooms.addIf(
            !controller.selectedrooms.contains(chatroom['roomName']),
            chatroom['roomName'],
          );
        } else {
          print(chatroom.data());
          Get.toNamed(
            "/adopt_chat_room",
            arguments: [
              chatroom['roomName'],
              controller.currentUser,
              ChatroomModel.fromMap(chatroom.data() as Map<String,dynamic>),
              chatroom['owner_email'],
              // roomName,
            ],
          );
        }
      },
      onLongPress: () {
        controller.selected++;
        controller.toggleSelection(index);
        controller.selectedrooms.addIf(
          !controller.selectedrooms.contains(chatroom['roomName']),
          chatroom['roomName'],
        );
      },
    );
  }
}

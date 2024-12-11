import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
import '../../Models/message_model.dart';
import '../../SControllers/AdoptionPageController/pet_adoption_chat_room_controller.dart';

class PetAdoptionChatRoomScreen extends StatelessWidget {
  const PetAdoptionChatRoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PetAdoptionChatRoomController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Chat Messages List
          Expanded(
            child: ChatMessagesList(controller: controller),
          ),
          // Chat Input Field
          ChatInputField(controller: controller),
        ],
      ),
      // Simple Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActionDialog(context, controller),
        child: Icon(Icons.menu),
        backgroundColor: Get.theme.colorScheme.primary,
      ),
    );
  }

  // Method to show a small, top-end dialog with the options
  void _showActionDialog(BuildContext context, PetAdoptionChatRoomController controller) {
    showDialog(
      context: context,
      barrierDismissible: true, // Allow tapping outside to dismiss
      builder: (context) {
        return Align(
          alignment: Alignment.topRight, // Position dialog at top-right
          child: Padding(
            padding: const EdgeInsets.only(top: 80, right: 20), // Adjust the top and right padding
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 120, // Set width of the dialog
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Accept Button
                    if(controller.chatRoomData[3]==EmailPassLoginAl().getEmail())
                      TextButton(
                      onPressed: () {
                        controller.acceptRequester();
print(controller.chatRoomData[3]);
                      },
                      child: Text("Accept",style: TextStyle(fontSize: 16),),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
                    ),
                    SizedBox(height: 3),
                    // Reject Button
                    TextButton(
                      onPressed: () {
                        controller.rejectRequester();
                      },
                      child: Text("Reject",style: TextStyle(fontSize: 16,color: Colors.red)),
                      style: ElevatedButton.styleFrom(foregroundColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ChatMessagesList extends StatelessWidget {
  final PetAdoptionChatRoomController controller;

  const ChatMessagesList({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("chatrooms")
            .doc(controller.chatRoomData[0])
            .collection("messages")
            .orderBy("createdon", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.active) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text("An error occurred! Please check your internet connection."),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Say Hello.."),
            );
          }

          final messages = snapshot.data!.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList();

          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isSender = message.sender == controller.chatRoomData[1];
              return MessageBubble(message: message, isSender: isSender);
            },
          );
        },
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  final bool isSender;

  const MessageBubble({required this.message, required this.isSender, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          constraints: const BoxConstraints(maxWidth: 250, maxHeight: 500),
          decoration: BoxDecoration(
            color: isSender ? Colors.grey : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            message.text ?? "Some Error",
            maxLines: 100,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ChatInputField extends StatelessWidget {
  final PetAdoptionChatRoomController controller;

  const ChatInputField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller.messageController,
              maxLines: null,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Enter message",
              ),
            ),
          ),
          IconButton(
            onPressed: controller.sendMessage,
            icon: Icon(
              Icons.send,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

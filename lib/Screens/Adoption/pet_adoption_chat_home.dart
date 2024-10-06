
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pet_kart/SControllers/AdoptionPageController/pet_adoption_chat_home_controller.dart';


class PetAdoptionChatHome extends StatelessWidget {
  const PetAdoptionChatHome({super.key});

  @override
  Widget build(BuildContext context) {
    PetAdoptionChatHomeController petAdoptionChatHomeController =
    Get.put(PetAdoptionChatHomeController());
    return Scaffold(
appBar: AppBar(title: Text("Chats"),
centerTitle: true,
),
      body: Column(
        children: [
      TextField(
        decoration: InputDecoration(
          hintText: "Search...",
          hintStyle: TextStyle(color: Colors.grey.shade600),
          prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: EdgeInsets.all(8),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: Colors.grey.shade100
              )
          ),
        ),
        onChanged: (val) {
            petAdoptionChatHomeController.updateSearchText(val);
        },
      ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: petAdoptionChatHomeController.searchQuery.value.isEmpty
                  ? FirebaseFirestore.instance
                  .collection("chatrooms")
                  .where("participants", arrayContains: petAdoptionChatHomeController.currentUser)
                  .snapshots()
                  : FirebaseFirestore.instance
                  .collection("chatrooms")
                  .where("participants", arrayContainsAny: [
                petAdoptionChatHomeController.currentUser,
                petAdoptionChatHomeController.searchQuery.value
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
                  petAdoptionChatHomeController.setLen(snapshot.data!.docs.length);
                  return  Obx(()=>
                    ListView.builder(
                      itemCount: petAdoptionChatHomeController.len.value,
                      itemBuilder: (context, index) {
                        var chatroom = snapshot.data!.docs[index];
                        var roomName = chatroom['displayName'].split('#')[0];
                        petAdoptionChatHomeController.setChatRoomNames(snapshot.data!.docs);
                        return Obx(
                              () => ListTile(
                            title: Text(roomName),
                            subtitle: Text(chatroom['status']?chatroom['lastMsg']:"Requested", maxLines: 1),
                            selected: petAdoptionChatHomeController.selectedItems[index],
                            selectedTileColor: Colors.grey,
                            onTap: () {
                              if(petAdoptionChatHomeController.selectedItems[index]==true ) {
                                petAdoptionChatHomeController.toggleSelection(index);
                                petAdoptionChatHomeController.selected--;
                                petAdoptionChatHomeController.selectedrooms.remove(chatroom['roomName']);
                              }
                              else if( petAdoptionChatHomeController.selected>0){
                                petAdoptionChatHomeController.toggleSelection(index);
                                petAdoptionChatHomeController.selected++;
                                petAdoptionChatHomeController.selectedrooms.addIf(
                                    !petAdoptionChatHomeController.selectedrooms.contains(chatroom['roomName']),chatroom['roomName']);
                              }
                              else {
                                Get.toNamed("/adopt_chat_room", arguments: [
                                  chatroom['roomName'],
                                  petAdoptionChatHomeController.currentUser,
                                  chatroom,
                                  roomName
                                ]);
                              }
                            },
                            onLongPress: () {
                              petAdoptionChatHomeController.selected++;
                              petAdoptionChatHomeController.toggleSelection(index);
                              petAdoptionChatHomeController.selectedrooms.addIf(
                                  !petAdoptionChatHomeController.selectedrooms.contains(chatroom['roomName']),chatroom['roomName']);
                            },
                            trailing: Text(chatroom['dateTime'].toString()),
                          ),
                        );
                      },

                    ),
                  );

                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            petAdoptionChatHomeController.showInputDialogChatRoom();
          }),
    );
  }
}

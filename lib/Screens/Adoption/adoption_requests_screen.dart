import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Models/chatroom_model.dart';

import '../../SControllers/AdoptionPageController/adoption_requests_controller.dart';

class AdoptionRequestsScreen extends StatelessWidget {
  const AdoptionRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AdoptionRequestsController controller =
        Get.put(AdoptionRequestsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(Get.arguments[1]),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15),
        child: Obx(() {
          if (controller.requests.isEmpty) {
            return const Center(child: Text('No requests available'));
          }

          return ListView.builder(
            itemCount: controller.requests.length,
            itemBuilder: (context, index) {
              final request = controller.requests[index];

              final status = request['status'] ?? "Pending";

              // Determine background color based on status
              Color tileColor;
              switch (status) {
                case 'Accept':
                  tileColor = Get.theme.colorScheme.primary.withOpacity(0.8);
                  break;
                case 'Reject':
                  tileColor = Colors.red[300]!;
                  break;

                default:
                  tileColor = Colors.grey[200]!;
                  break;
              }

              return GestureDetector(
                onTap: () {
                  if (status == 'Reject') {
                    Get.snackbar(
                        "Rejected", "You already rejected this request",
                        backgroundColor: Colors.black);
                  } else if (status == 'Accept') {
                    String owner = request['owner_email'];
                    String requester = request['requester_email'];
                    var room_name = requester.compareTo(owner) < 0
                        ? "$requester\_$owner"
                        : "$owner\_$requester";
                    ChatroomModel chatroomModel = ChatroomModel(
                       docid: request['docid'],
                        status: true,
                        roomName: room_name,
                        lastMsg: "",
                        participants: [],
                        dateTime: DateTime.now().toString(),
                        displayName: "temp");
                    Get.toNamed("/adopt_chat_room",
                        arguments: [room_name, owner, chatroomModel,owner,controller.docid]);
                  } else {
                    Get.toNamed('/adoption_requests_details_screen',
                        arguments: [Get.arguments[0], index]);
                  }
                },
                child: Card(
                  color: tileColor,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Requester: ${request['full_name']}'),
                    subtitle: Text('Status: $status'),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

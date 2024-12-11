import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';

class AdoptionRequestsController extends GetxController {
  var requests = <Map<String, dynamic>>[].obs;
  final List<String> options = ['Hold', 'Reject', 'Accept', 'Pending'];
String docid=Get.arguments[0];
  @override
  void onInit() {
    super.onInit();
    fetchRequests();
  }

  void fetchRequests() {
    FirebaseFirestore.instance
        .collection('adopt_pets')
        .doc(docid)
        .collection('requests')
        .snapshots()
        .listen((snapshot) {
      requests.value = snapshot.docs
          .map((doc) => {
        'id': doc.id,
        ...doc.data(),
      })
          .toList();
      sortRequests();
    });
  }



  void sortRequests() {
    requests.sort((a, b) {
      const priority = {'Accept': 1, 'Pending': 2, 'Hold': 3, 'Reject': 4};
      return priority[a['status']]!.compareTo(priority[b['status']]!);
    });
  }
  void updateRequestStatus(int index, String status) {
    requests[index]['status'] = status;
    requests.refresh();
    sortRequests();
    final docId = Get.arguments[0];
    final requestId = requests[index]['id'];

// print(docId);
// print(requestId);
    FirebaseFirestore.instance
        .collection('adopt_pets')
        .doc(docId)
        .collection('requests')
        .doc(requestId)
        .update({'status': status}).catchError((error) {
      Get.snackbar(
        "Error",
        "Failed to update status: $error",
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    //create chatroom if accept
    if(status=='Accept'){

      createChatRoom(requests[index]['requester_email'], requests[index]['owner_email'], requests[index]['full_name'],);
    }
  }

  Future<void> createChatRoom(String requester, String owner, firstName) async {
    var temp=await FirebaseFirestore.instance.collection('users').doc(owner).get();
   String ownerName=temp.data()?['customerName'];
    try {
      // Merge both strings in alphabetical order (smaller string in front)
      String mergedName = requester.compareTo(owner) < 0 ? "$requester\_$owner" : "$owner\_$requester";

      // Create a reference to the chatroom document in Firebase
      DocumentReference chatRoomDoc = FirebaseFirestore.instance.collection("chatrooms").doc(mergedName);

      // Create the chatroom data
      Map<String, dynamic> chatRoomData = {
        "dateTime": FieldValue.serverTimestamp(), // Current server timestamp
        "displayName": "$requester#$owner", // Display name combining both
        "owner_email": owner, // Display name combining both
        "lastMsg": "", // Initial last message as empty
        "participants": [requester, owner], // Participants in a list
        "participantsName": [firstName, ownerName], // Participants in a list
        "roomName": mergedName, // Room name as the merged name
        "status": false, // Initial status as false
        "docid": docid, // Initial status as false
      };

      // Set the document in Firestore
      await chatRoomDoc.set(chatRoomData);

      print("Chatroom $mergedName created successfully!");
    } catch (e) {
      print("Error creating chatroom: $e");
    }
  }

}

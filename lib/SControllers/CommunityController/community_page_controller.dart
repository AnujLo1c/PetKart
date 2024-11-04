  import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pet_kart/Firebase/FirebaseAuth/email_pass_login.dart';
import 'package:pet_kart/Models/post_model.dart';
import 'package:pet_kart/MyWidgets/snackbarAL.dart';
import 'package:pet_kart/SControllers/persistent_data_controller.dart';
import 'package:intl/intl.dart';
import '../../Models/community_model.dart';

class CommunityPageController extends GetxController {
  Rx<bool> postBoxBool = false.obs;
  TextEditingController postController = TextEditingController();
  Rx<bool> onMyFeed = true.obs;
  RxString communityName=''.obs ;
PersistentDataController persistentDataController=Get.find<PersistentDataController>();
  postingToggle() {
    postBoxBool.value = !postBoxBool.value;
    postController.clear();
  }

  myFeedToggle() {
    onMyFeed.value = !onMyFeed.value;
    postController.clear();
  }

  Rx<bool> tempLikeToggle = false.obs;
  likeToggle() {
    //TODO: MAKE IT FOR POST LIST
    tempLikeToggle.value = !tempLikeToggle.value;
  }

  //community
  var communities = <CommunityModel>[].obs;

  @override
  void onInit() {
    loadCommunities();

    super.onInit();
  }

  void loadCommunities() {
    var communityList = [
      // CommunityModel(name: "Pet Information", rating: 4.3, members: "1k+"),
      CommunityModel(name: "Dog Information", rating: 4.3, members: ["2k"], imagesCount: 0, owner: EmailPassLoginAl().getEmail(), ),
    ];

    communities.addAll(communityList);
  }


    Future<List<CommunityModel>> fetchCommunitiesByIds(List<String> communityIds) async {
      List<CommunityModel> communities = [];
      for (String id in communityIds) {
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection('community').doc(id).get();
        if (doc.exists) {
          communities.add(CommunityModel.fromFirestore(doc));
        }
      }
      return communities;

  }


  Future<bool> uploadPost() async {
    PostModel post=PostModel(owner: persistentDataController.userName.value, community: communityName.value, content: postController.text,
        chars: communityName.value.length, date: DateTime.timestamp());
    var communityId=communityName.replaceAll(' ', '');
    List<String> memberIds=await getCommunityMembers(communityId);

    if(postController.text.isEmpty || postController.text=='' ){
      showErrorSnackbar("Write some content..");
      return false;
    }
    else if(communityName.value=='' || communityName.value.isEmpty){
      showErrorSnackbar("Select a community..");
      return false;
    }
    try {

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentReference communityPostRef = await firestore
          .collection('community')
          .doc(communityId)
          .collection('posts')
          .add(post.toMap());

      // 2. Iterate through each member and add the post to their 'feed' subcollection
      for (String memberId in memberIds) {
        await firestore
            .collection('users')
            .doc(memberId)
            .collection('feed')
            .doc() // Use the same post ID to maintain consistency
            .set(post.toMap());
      }


      print('Post uploaded successfully to community and members\' feeds.');
return true;
    } catch (e) {
      print('Failed to upload post: $e');
   return false;
    }
  }

  Future<List<String>> getCommunityMembers(String communityId) async {
    try {
      DocumentSnapshot communitySnapshot = await FirebaseFirestore.instance
          .collection('community')
          .doc(communityId)
          .get();

      if (communitySnapshot.exists) {
        // Cast data() as a Map to access its properties
        Map<String, dynamic> data = communitySnapshot.data() as Map<String, dynamic>;
        List<dynamic> memberIdsDynamic = data['members'] ?? [];
        return memberIdsDynamic.cast<String>(); // Convert to List<String>
      } else {
        print("Community document does not exist.");
        return [];
      }
    } catch (e) {
      print("Error fetching community members: $e");
      return [];
    }
  }


  String formatDateTime(DateTime dateTime) {
    String time = DateFormat('HH:mm').format(dateTime); // Format time as HH:mm
    String date = DateFormat('dd MMM').format(dateTime); // Format date as dd MMM
    return '$time $date';
  }


}

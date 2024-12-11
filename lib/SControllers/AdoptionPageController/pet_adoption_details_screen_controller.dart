import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PetAdoptionDetailsScreenController extends GetxController {
  PageController pageController = PageController();
  List<ImageProvider> cachedImageProviders = [];
  String docid = Get.arguments;

  // Reactive Map and List
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  RxList<String> imageUrls = <String>[].obs;
RxString owner=''.obs;
RxString ownerUrl=''.obs;
String? ownerEmail;
  Future<void> fetchData() async {
    try {
      // Fetch document from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('adopt_pets')
          .doc(docid)
          .get();

      if (snapshot.exists) {
        // Cast snapshot data to a map
        Map<String, dynamic> fetchedData = snapshot.data() as Map<String, dynamic>;

        // Update the reactive map
        data.assignAll(fetchedData);

        // Extract image URLs
        List<dynamic> stringList = fetchedData['stringList'] ?? [];
        List<String> temp = stringList.cast<String>();
        temp.insert(0, fetchedData['primaryImageUrl']); // Add primary image URL at the beginning
        
        // Update reactive list
        imageUrls.value = temp;
        ownerEmail=fetchedData['owner'];
var tempOwner=await FirebaseFirestore.instance.collection('users').doc(fetchedData['owner']).get();
if(tempOwner.exists){
  Map<String, dynamic>? ownerData=tempOwner.data();
owner.value=ownerData?['customerName'];
ownerUrl.value=ownerData?['profileUrl'];
}
        // Precache images
        for (var url in imageUrls) {
          ImageProvider imageProvider = CachedNetworkImageProvider(url);
          cachedImageProviders.add(imageProvider);
          precacheImage(imageProvider, Get.context!);
        }
      } else {
        throw Exception('Document does not exist');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onClose() {
    // Dispose of cached images when the screen is closed
    for (var imageProvider in cachedImageProviders) {
      imageProvider.evict();
    }
    pageController.dispose();
    super.onClose();
  }
}

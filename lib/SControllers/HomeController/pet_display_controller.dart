import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pet_kart/Models/cart_animal_item.dart';
import 'package:pet_kart/SControllers/cart_controller.dart';

class PetDisplayController extends GetxController {
  AnimalCartController animalCartController=Get.find<AnimalCartController>();
  PageController pageController = PageController();
  List<ImageProvider> cachedImageProviders = [];
  var args= Get.arguments;
  RxBool deliveryBool=true.obs;
  // Reactive Map and List
  RxMap<String, dynamic> data = <String, dynamic>{}.obs;
  RxList<String> imageUrls = <String>[].obs;
  RxString owner=''.obs;
  RxString ownerUrl=''.obs;
  String? ownerEmail;
  List<String> address=[];
  String animalTag='';
  late Map<String, dynamic> fetchedData;
  String docid='';
  addTocart(){
    animalCartController.addToCart(CartAnimalItem.fromMap(docid, fetchedData));
    Get.snackbar("Item Added", "Pet added to the cart.");
  }
  Future<void> fetchData() async {
    try {
      // Fetch document from Firestore
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('pets')
          .doc(args[1]).collection(args[1]).doc(args[0]).get();
print(args[0]);
print(args[1]);

if (snapshot.exists) {
        // Cast snapshot data to a map
         fetchedData = snapshot.data() as Map<String, dynamic>;
        docid=snapshot.id;
        data.assignAll(fetchedData);
print(data);
        // Extract image URLs
        List<dynamic> stringList = fetchedData['stringList'] ?? [];
        List<String> temp = stringList.cast<String>();
        temp.insert(0, fetchedData['primaryImageUrl']); // Add primary image URL at the beginning
deliveryBool.value=(data['delivery']??false);
        // Update reactive list
        imageUrls.value = temp;
        ownerEmail=fetchedData['owner'];
        var tempOwner=await FirebaseFirestore.instance.collection('vendorusers').doc(fetchedData['owner']).get();
        if(tempOwner.exists){
          Map<String, dynamic>? ownerData=tempOwner.data();
          owner.value=ownerData?['businessName'];
          ownerUrl.value=ownerData?['profileUrl'];
          address.add(ownerData?['address']);
          address.add(ownerData?['city']);
          address.add(ownerData?['state']);
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

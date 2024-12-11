import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class FoodAccController extends GetxController {
String title=Get.arguments;
  var categories = ['Dog', 'Cat', 'Fish', 'Mammals','Birds'];
  var categoriesImgs = ['puppy.png', 'cat.png', 'fish.png', 'mammal.png','birds.png'];
  var itemCount = 0.obs; // This can be removed as we get real-time count from Firestore.
  Stream<QuerySnapshot> getProductStream() {
    return FirebaseFirestore.instance.collection('products').doc(title).collection(title).snapshots();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  assignCategories();
  }
  assignCategories(){
    if(title=='Accessories') {
      categories=['Toys', 'Belts', 'Clothes', 'bowls','Kit'];
      categoriesImgs=['cattoy.png','catbelt.png','catdresses.png','catbowls.png','kit.jpeg'];
    }
  }
}

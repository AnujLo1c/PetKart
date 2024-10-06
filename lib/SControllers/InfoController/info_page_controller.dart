import 'package:get/get.dart';

class InfoPageController extends GetxController{
  var petCategories = [
    {'name': 'Dog', 'image': 'assets/picture/puppy.png'}, // Replace with your image paths
    {'name': 'Cat', 'image': 'assets/picture/cat.png'},
    {'name': 'Bird', 'image': 'assets/picture/birds.png'},
    {'name': 'Fish', 'image': 'assets/picture/fish.png'},
    {'name': 'Mammal', 'image': 'assets/picture/mammal.png'},
  ].obs;
}
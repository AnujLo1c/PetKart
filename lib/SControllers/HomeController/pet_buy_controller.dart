import 'package:get/get.dart';

class PetBuyController extends GetxController {

  var dogsList = [
    {
      'name': 'Bella',
      'gender': 'Female',
      'age': '3 years',
      'location': 'Delhi',
      'price': '3000',
      'image': 'assets/picture/cat.png'
    },

  ].obs;

  var breedFilter = 'All Breeds'.obs;
}

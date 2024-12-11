import 'package:get/get.dart';

class InfoOptionsController extends GetxController {
  var list = <String>[].obs;  // Observable list for reactivity
  String animal = Get.arguments;

  String title=Get.arguments;

  @override
  void onInit() {
    super.onInit();
    _updateListBasedOnAnimal();
  }

  void _updateListBasedOnAnimal() {
    if (animal == 'Dog') {
      _setDogBreeds();
    }
    else if (animal == 'Cat') {
      _setCatBreeds();
    }
    else if (animal == 'Fish') {
      _setFishBreeds();
    }
    else if (animal == 'Small Mammals') {
      _setMammalsBreeds();
    }
    else if (animal == 'Birds') {
      _setBirdsBreeds();
    }

  }

  // Function to set the list with dog breeds
  void _setDogBreeds() {
    list.assignAll([
      'Beagle',
      'Boxer',
      'Bulldog',
      'Bully Kutta',
      'Cocker Spaniel',
      'French Bulldog',
      'Gaddi Kutta',
      'German Shepherd',
      'Golden Retriever',
      'Labrador',
      'Pomeranian',
      'Poodle',
      'Rottweiler',
      'Shih Tzu',
      'Siberian Husky',
    ]);
  }
 _setCatBreeds() {
   list.assignAll([
     'Abyssinian',
     'Bengal',
     'British Shorthair',
     'Maine Coon',
     'Norwegian Forest Cat',
     'Persian Cat',
     'Ragdoll',
     'Scottish Fold',
     'Siamese',
     'Sphynx'
   ]);
}
  _setFishBreeds() {
    list.assignAll([
      'Angelfish',
      'Betta Fish',
      'Clownfish',
      'Discus Fish',
      'Goldfish',
      'Guppy',
      'Koi Fish',
      'Neon Tetra',
      'Oscar Fish',
      'Pufferfish'
    ]);
  }
  _setMammalsBreeds() {
    list.assignAll([
      'Abyssinian Guinea Pig',
      'American Rabbit',
      'Dutch Rabbit',
      'Dwarf Winter White Russian Hamster',
      'Holland Lop',
      'Hybrid Dwarf Hamster',
      'New Zealand Rabbit',
      'Roborovski Dwarf Hamster',
      'Syrian Hamster',
      'Teddy Guinea Pig'
    ]);
  }
  _setBirdsBreeds() {
    list.assignAll([
      'African Grey Parrot',
      'Amazon Parrot',
      'Budgerigar (Budgie)',
      'Canary',
      'Cockatiel',
      'Eurasian Collared-Dove',
      'Finch',
      'Lovebird',
      'Macaw',
      'Pionus Parrot'
    ]);
  }
}


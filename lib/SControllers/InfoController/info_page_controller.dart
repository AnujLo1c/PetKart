import 'package:get/get.dart';

class InfoPageController extends GetxController{
  final List<PetCategory> petCategories = [
    PetCategory(
      title: 'Dog',
      description: 'Everything You Need to Know About Dogs, Right at Your Fingertips.',
      imageUrl: 'assets/picture/puppy.png',
    ),
    PetCategory(
      title: 'Cat',
      description: 'Unlock the Secrets to a Happy Cat – Tips and Fun Facts!',
      imageUrl: 'assets/picture/cat.png',
    ),
    PetCategory(
      title: 'Fish',
      description: 'Swimmingly Good Advice – Everything You Need to Know About Fish Care.',
      imageUrl: 'assets/picture/fish.png',
    ),
    PetCategory(
      title: 'Small Mammals',
      description: 'Big Love for Little Pets – Your Guide to Small Mammal Care!',
      imageUrl: 'assets/picture/mammal.png',
    ),
    PetCategory(
      title: 'Birds',
      description: 'Take Flight with the Best Bird Care Tips – From Parrots to Parakeets!',
      imageUrl: 'assets/picture/birds.png',
    ),
  ];

}

class PetCategory {
  final String title;
  final String description;
  final String imageUrl;

  PetCategory({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}
import 'package:get/get.dart';

class InfoPageController extends GetxController{
  final List<PetCategory> petCategories = [
    PetCategory(
      title: 'Dog',
      description: 'Everything You Need to Know About Dogs, Right at Your Fingertips.',
      imageUrl: 'assets/images/dog.png',
    ),
    PetCategory(
      title: 'Cat',
      description: 'Unlock the Secrets to a Happy Cat – Tips and Fun Facts!',
      imageUrl: 'assets/images/cat.png',
    ),
    PetCategory(
      title: 'Fish',
      description: 'Swimmingly Good Advice – Everything You Need to Know About Fish Care.',
      imageUrl: 'assets/images/fish.png',
    ),
    PetCategory(
      title: 'Small Mammals',
      description: 'Big Love for Little Pets – Your Guide to Small Mammal Care!',
      imageUrl: 'assets/images/small_mammals.png',
    ),
    PetCategory(
      title: 'Birds',
      description: 'Take Flight with the Best Bird Care Tips – From Parrots to Parakeets!',
      imageUrl: 'assets/images/birds.png',
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
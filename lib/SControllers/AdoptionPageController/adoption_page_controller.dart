
import 'package:get/get.dart';
class AdoptionPageController extends GetxController{
  List<String> petTypes = ['Dog', 'Cat', 'Bird', 'Rabbit', 'Hamster'];
  List<String> petSizes = ['Indore', 'Bhopal', 'Ujjain'];
  RxString selectedPetType = 'Dog'.obs;
  RxString selectedPetSize = 'Indore'.obs;

  void navToPetDetails(int i) {
    Get.toNamed("/adopt_pet_details");
  }

}
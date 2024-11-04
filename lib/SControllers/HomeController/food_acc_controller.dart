
import 'package:get/get.dart';

class FoodAccController extends GetxController {
  List<String> categories = <String>["Dog Food","Cat Food","Fish Food","Rabbit Food"];
var itemCount=5.obs;

  void setCategories(List<String> newCategories) {
    categories.assignAll(newCategories);
  }


}
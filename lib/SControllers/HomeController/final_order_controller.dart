
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FinalOrderController extends GetxController {
  final Map<String, String> deliveryAddress = Get.arguments[1];
var itemData=Get.arguments[0];
  // final paymentDetails = '81........414';
  // final orderDate = '10/10/24';
  final deliveryDate = '18 October';
  final itemPrice = 0.obs;
  final deliveryPrice = 0.obs;
  int get orderTotal => itemPrice.value + deliveryPrice.value;
@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    itemPrice.value=int.parse(itemData[2]);
    deliveryPrice.value=int.parse(itemData[3]);
  }
}

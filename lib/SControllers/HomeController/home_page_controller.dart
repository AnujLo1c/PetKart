import 'package:get/get.dart';

import '../BottomNavController/bottom_nav_controller.dart';

class HomePageController extends GetxController{
  final BottomNavController bottomNavController = Get.find<BottomNavController>();
  final List<String> imgList = [
    'https://picsum.photos/seed/1/700/250',
    'https://picsum.photos/seed/2/700/250',
    'https://picsum.photos/seed/3/700/250',
    'https://picsum.photos/seed/4/700/250',
    'https://picsum.photos/seed/5/700/250',
  ];
  var currentIndexCarou = 0.obs;

  void updateIndex(int index) {
    currentIndexCarou.value = index;
  }
  void navigate(int idx){
    bottomNavController.onBNavItemTap(idx);
  }
}
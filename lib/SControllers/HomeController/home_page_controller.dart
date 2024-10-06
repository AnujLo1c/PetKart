import 'package:get/get.dart';

class HomePageController extends GetxController{
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
}
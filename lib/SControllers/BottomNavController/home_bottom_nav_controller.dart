import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeBottomNavController extends GetxController{

  List<Widget> pages=[];
  Rx<int> currentPage=0.obs ;
  PageController pageController=PageController(initialPage: 0);

  onPageChage(int index) {
    currentPage.value=index;
  }

  onBNavItemTap(int index) {
    currentPage.value=index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }
}
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:pet_kart/Screens/Adoption/adoption_page.dart';
import 'package:pet_kart/Screens/Community/community_page.dart';
import 'package:pet_kart/Screens/Home/home_page.dart';
import 'package:pet_kart/Screens/Information/info_page.dart';
import 'package:pet_kart/Screens/Profile/profile_page.dart';

class BottomNavController extends GetxController{
  var scaffoldkey=GlobalKey<ScaffoldState>();
var appbarName=["Home","Pet Information","Pet Adoption","Community","Profile",];

  List<Widget> pages=[const HomePage(),const InfoPage(),const AdoptionPage(),const CommunityPage(),const ProfilePage()];
  Rx<int> currentPage=0.obs ;
  PageController pageController=PageController(initialPage: 0);
var lead=[];
  @override
  void onInit() {
     super.onInit();
lead=_initializeLead();
  }
  onPageChage(int index) {
    currentPage.value=index;
  }

  onBNavItemTap(int index) {
    currentPage.value=index;
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.linear);
  }

   void openDrawer() {
    scaffoldkey.currentState?.openDrawer();

  }
 _initializeLead() {

return [IconButton(icon: const Icon(Icons.menu,), onPressed: () { openDrawer(); },),const SizedBox(),const SizedBox(),const SizedBox(),const SizedBox()];
}
}


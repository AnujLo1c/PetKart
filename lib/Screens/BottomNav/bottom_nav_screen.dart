import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pet_kart/MyWidgets/my_drawer.dart';
import 'package:pet_kart/SControllers/BottomNavController/bottom_nav_controller.dart';
class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BottomNavController bottomNavController=Get.put(BottomNavController());
    return SafeArea(
        child:Scaffold(
          key: bottomNavController.scaffoldkey,
          drawer: MyDrawer(),
            appBar: AppBar(leading: Obx(()=>bottomNavController.lead[bottomNavController.currentPage.value]),
            title: Obx(()=>  Text(bottomNavController.appbarName[bottomNavController.currentPage.value]))),
            body: PageView(
              controller: bottomNavController.pageController,
              children: bottomNavController.pages,
              onPageChanged: (value) => bottomNavController.onPageChage(value),
            ),
            bottomNavigationBar:
            Obx(() {
              return
              CurvedNavigationBar(
                index: bottomNavController.currentPage.value,
backgroundColor: Colors.white,
color: Get.theme.colorScheme.primary,
buttonBackgroundColor: Get.theme.colorScheme.primary,

                items: const [
            CurvedNavigationBarItem(child: Icon(color: Colors.white,Icons.home,),label: "Home",labelStyle: TextStyle(color: Colors.white)),
            CurvedNavigationBarItem(child: Icon(Icons.info),label: "Info",labelStyle: TextStyle(color: Colors.white)),
            CurvedNavigationBarItem(child: Icon(Icons.pets),label: "Adopt",labelStyle: TextStyle(color: Colors.white)),
            CurvedNavigationBarItem(child: Icon(Icons.comment_outlined),label: "Community",labelStyle: TextStyle(color: Colors.white)),
            CurvedNavigationBarItem(child: Icon(Icons.person),label: "Profile",labelStyle: TextStyle(color: Colors.white)),
],
onTap: (index) =>bottomNavController.onBNavItemTap(index),
                  );
            })

        ) );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pet_kart/MyWidgets/custom_app_bar.dart';
import 'package:pet_kart/MyWidgets/my_drawer.dart';
import 'package:pet_kart/SControllers/BottomNavController/home_bottom_nav_controller.dart';
class HomeBottomNavScreen extends StatelessWidget {
  const HomeBottomNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeBottomNavController homeBottomNavController=Get.put(HomeBottomNavController());
    return SafeArea(
        child:Scaffold(
          drawer: MyDrawer(),
            appBar: CustomAppBar(title: "Home"),
            body: PageView(
              controller: homeBottomNavController.pageController,
              children: homeBottomNavController.pages,
              onPageChanged: (value) => homeBottomNavController.onPageChage(value),
            ),
            bottomNavigationBar:  Obx(() {
              return BottomNavigationBar(
                currentIndex: homeBottomNavController.currentPage.value,
                backgroundColor: Colors.black,
                // fixedColor: Colors.white,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,

                type: BottomNavigationBarType.fixed, // Add this line
                onTap: (value) => homeBottomNavController.onBNavItemTap(value),
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(AntDesign.home_outline, color: Colors.grey.shade50),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Bootstrap.info_square, color: Colors.grey.shade50),
                    label: "Pro",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Bootstrap.shop, color: Colors.grey.shade50),
                    label: "Prof",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Bootstrap.info_square, color: Colors.grey.shade50),
                    label: "Profile",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Bootstrap.info_square, color: Colors.grey.shade50),
                    label: "Profile",
                  ),
                ],
              );
            })

        ) );
  }
}


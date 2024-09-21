import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ThemeController extends GetxController {
  var isDarkMode = true.obs;

  ThemeMode get themeMode => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(themeMode);
  }
  @override
  void onInit() {
    super.onInit();
    isDarkMode.value=ThemeMode.system==ThemeMode.dark;
  }
}

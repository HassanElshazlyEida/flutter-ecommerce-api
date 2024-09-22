import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    CacheNetwork.setCache('theme', isDarkMode.value ? 'dark' : 'light');
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }
  static ThemeMode theme(){
    var theme = CacheNetwork.getCache('theme');
    if(theme == 'dark'){
      return ThemeMode.dark;
    }else if(theme == 'light'){
      return ThemeMode.light;
    }else {
      return ThemeMode.system;
    }
  }
}
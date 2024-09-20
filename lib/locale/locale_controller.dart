import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LocaleController extends GetxController {
   void changeLanguage(String langCode) {
    var locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}
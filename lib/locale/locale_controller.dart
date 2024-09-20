import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/shared/network/local_network.dart';
import 'package:get/get.dart';


class LocaleController extends GetxController {
   void changeLanguage(String langCode) {
    CacheNetwork.setCache('lang', langCode);
    var locale = Locale(langCode);
    Get.updateLocale(locale);
  }
}
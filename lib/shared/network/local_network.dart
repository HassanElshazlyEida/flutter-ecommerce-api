import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedPref;

  static Future init() async {
    SharedPreferences.setMockInitialValues({});
    sharedPref = await SharedPreferences.getInstance();
    return sharedPref;
  }

  static Future<bool> setCache(String key, String value) async {
    return await sharedPref.setString(key, value);
  }

  static String? getCache(String key) {
    return sharedPref.getString(key);
  }

  static Future<bool> removeCache(String key) async {
    return await sharedPref.remove(key);
  }

  static Future<bool> clearCache() async {
    return await sharedPref.clear();
  }
}
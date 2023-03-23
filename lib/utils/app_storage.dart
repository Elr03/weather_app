import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static late SharedPreferences prefs;

  static Future<void> configurePrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static const String cityListValue = 'cityList';

  static Future<void> saveCityList(List<String> cityList) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(cityListValue, cityList);
  }

  static Future<List<String>> recoverCityList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(cityListValue) ?? [];
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

import 'package:booking_app/configs/themes/app_dark_theme.dart';
import 'package:booking_app/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  @override
  void onInit() {
    initializedThemeData();
    super.onInit();

  }

  void saveLocale(Locale locale) async {
    Get.updateLocale(locale);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  Future<Locale> getSavedLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String locale = prefs.getString('locale') ?? 'en';
    return Locale(locale);
  }

  initializedThemeData() {
     _darkTheme = DarkTheme().buildDarkTheme();
     _lightTheme = LightTheme().buildLightTheme();
   }


  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;

}

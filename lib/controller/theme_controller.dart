import 'package:booking_app/configs/themes/app_dark_theme.dart';
import 'package:booking_app/configs/themes/app_light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  late ThemeData _darkTheme;
  late ThemeData _lightTheme;
  @override
  void onInit() {
    initializedThemeData();
    super.onInit();

  }

   initializedThemeData() {
     _darkTheme = DarkTheme().buildDarkTheme();
     _lightTheme = LightTheme().buildLightTheme();
   }

  ThemeData get lightTheme => _lightTheme;
  ThemeData get darkTheme => _darkTheme;
}

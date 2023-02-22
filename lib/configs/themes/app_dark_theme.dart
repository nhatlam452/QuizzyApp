import 'package:booking_app/configs/themes/sub_theme_data_mixin..dart';
import 'package:flutter/material.dart';

const Color primaryDarkColorDark = Color(0xFF2e3c62);
const Color primaryColorDark = Color(0xFF99ace1);
const Color mainTextColor = Colors.white;
const Color cardColor = Color.fromARGB(255, 254, 254, 255);

class DarkTheme with SubThemeData {
  ThemeData buildDarkTheme() {
    final ThemeData systemDarkTheme = ThemeData.dark();
    return systemDarkTheme.copyWith(
      primaryColor: primaryColorDark,
        iconTheme: getIconTheme(),
        cardColor: cardColor,
        textTheme: getTextThemes()
            .apply(bodyColor: mainTextColor, displayColor: mainTextColor));
  }
}

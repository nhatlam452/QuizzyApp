import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "app_colors.dart";

mixin SubThemeData{
  TextTheme getTextThemes(){
    return GoogleFonts.quicksandTextTheme(TextTheme(
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
      )
    ));
  }

  IconThemeData getIconTheme(){
    return const IconThemeData(color: onSurfaceTextColor,size: 16);

  }
}
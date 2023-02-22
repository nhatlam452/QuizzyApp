import 'package:booking_app/configs/themes/app_colors.dart';
import 'package:booking_app/configs/themes/ui_parameters.dart';
import 'package:flutter/material.dart';

TextStyle cartTitles(context) => TextStyle(
    color: UIParameters.isDarkMode()?Theme.of(context).textTheme.bodyLarge!.color
        : Theme.of(context).primaryColor,
    fontSize: 18,
    fontWeight: FontWeight.bold
);
const detailText  = TextStyle(fontSize: 12);
const questionTextStyle = TextStyle(fontSize: 16 , fontWeight: FontWeight.w800);
const headerText = TextStyle(fontSize: 22, fontWeight: FontWeight.w700,
color: onSurfaceTextColor
);

const appBarTS =  TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: onSurfaceTextColor);


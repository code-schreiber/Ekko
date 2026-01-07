import 'package:flutter/material.dart';

// From CSS variables on hume.ai
const Color white = Color.fromRGBO(255, 255, 255, 1);
const Color humeBlack900 = Color.fromRGBO(26, 26, 26, 1);
const Color humeTan400 = Color.fromRGBO(255, 244, 232, 1);
const Color accentOrange200 = Color.fromRGBO(255, 219, 176, 1);
const Color accentBlue200 = Color.fromRGBO(209, 226, 243, 1);

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: humeTan400,
  colorScheme: ColorScheme.light(
    primary: white,
    inversePrimary: accentOrange200,
    surface: humeBlack900,
    onSurface: white,
  ),
  dialogBackgroundColor: white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: humeBlack900),
    bodyMedium: TextStyle(color: humeBlack900),
  ),
  timePickerTheme: TimePickerThemeData(
    backgroundColor: humeBlack900,
    hourMinuteTextColor: Colors.blue,
    dialHandColor: Colors.blue,
    dialBackgroundColor: Colors.grey[800],
    entryModeIconColor: white,
    hourMinuteTextStyle: TextStyle(color: Colors.red),
    dayPeriodTextStyle: TextStyle(color: Colors.red),
    dialTextColor: Colors.red,
  ),
);

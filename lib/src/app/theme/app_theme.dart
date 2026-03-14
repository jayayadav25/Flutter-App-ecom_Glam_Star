import 'package:flutter/material.dart';

enum AppThemeType { light, dark, gold, purple, red }

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Colors.white,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
  );

  // static final ThemeData goldTheme = ThemeData(
  //   brightness: Brightness.light,
  //   primaryColor: const Color(0xFFD4AF37),
  //   useMaterial3: true,
  // );



  static ThemeData getTheme(AppThemeType type) {
    switch (type) {
      case AppThemeType.dark:
        return darkTheme;
      // case AppThemeType.gold:
      //   return goldTheme;
      case AppThemeType.light:
      default:
        return lightTheme;
    }
  }
}

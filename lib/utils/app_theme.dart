import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color primaryColorDark = Color(0xFF3D3D3D);
const Color primaryColor = Colors.white;
const Color accentColor = Color(0xFF3D3D3D);
const Color unselectedColor = Color(0xFFCCCCCC);

const Color bottomNavSelectedColor = Color(0xFFE0E0E0);
const Color bottomNavUnselectedColor = Color(0xFF6D6D6D);
const Color bottomNavColor = Color(0xFF2C2C2C);
const Color bottomNavDotColor = Colors.redAccent;

class AppTheme {
  AppTheme() {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent,
    //   statusBarBrightness: Brightness.light,
    //   systemNavigationBarColor: Colors.black,
    //   // navigation bar color
    //   statusBarIconBrightness: Brightness.light,
    //   // status bar icons' color
    //   systemNavigationBarIconBrightness: Brightness.dark, //navigation bar icons' color
    // ));
  }

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.white,
    primaryColorBrightness: Brightness.light,
    brightness: Brightness.light,
    primaryColorDark: Colors.black,
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
      elevation: 0,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: primaryColorDark,
    primaryColorBrightness: Brightness.dark,
    primaryColorLight: primaryColorDark,
    brightness: Brightness.dark,
    primaryColorDark: primaryColorDark,
    indicatorColor: Colors.white,
    canvasColor: primaryColorDark,
    backgroundColor: primaryColorDark,
    appBarTheme: AppBarTheme(
      color: primaryColorDark,
      brightness: Brightness.dark,
      elevation: 0,
    ),
  );
}

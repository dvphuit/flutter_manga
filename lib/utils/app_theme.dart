import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color primaryColor = Color(0xFF3D3D3D);
const Color accentColor = Color(0xFF3D3D3D);
const Color unselectedColor = Color(0xFFCCCCCC);

const Color bottomNavSelectedColor = Color(0xFFE0E0E0);
const Color bottomNavUnselectedColor = Color(0xFF6D6D6D);
const Color bottomNavColor = Color(0xFF2C2C2C);
const Color bottomNavDotColor = Colors.redAccent;

class AppTheme {
  AppTheme() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ));
  }

  void showStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  void hideStatusBar() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      elevation: 0,
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: primaryColor,
    backgroundColor: primaryColor,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
    ),
  );
}

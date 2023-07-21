import 'package:flutter/material.dart';

const appPurple = Color(0xFF431AA1);
const appPurpleDark = Color(0xFF1E0771);
const appPurpleDark2 = Color(0xFF010313);
const appDark = Color(0xFF52415B);
const appDark2 = Color(0xFFB79FD2);
const appPurpleLight1 = Color(0xFF9345F2);
const appPurpleLight2 = Color(0xFFB9A2DB);
const appWhite = Color(0xFFFAF8FC);
const appWhite1 = Color(0xFFFAF9FC);
const appWhite2 = Color(0xFFD2BEE8);
const appOrange = Color(0xFFF6704A);

ThemeData themeLight = ThemeData(
    brightness: Brightness.light,
    primaryColor: appPurple,
    scaffoldBackgroundColor: appWhite1,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: appWhite,
    ),
    textTheme: TextTheme(bodyMedium: TextStyle(color: appDark2)));

ThemeData themeDark = ThemeData(
  brightness: Brightness.dark,
  primaryColor: appPurpleLight2,
  scaffoldBackgroundColor: appPurpleDark2,
  appBarTheme: AppBarTheme(
    backgroundColor: appPurpleDark2,
  ),
  textTheme: const TextTheme(
    labelMedium: TextStyle(
      color: appWhite,
    ),
    bodyMedium: TextStyle(color: appWhite),
  ),
);

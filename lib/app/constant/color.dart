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
    foregroundColor: appPurple,
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(color: appPurpleDark),
  ),
  listTileTheme: ListTileThemeData(
    textColor: appPurpleDark,
  ),
  tabBarTheme: TabBarTheme(
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(width: 2, color: appPurple),
      ),
    ),
    labelColor: appPurple,
    unselectedLabelColor: appPurpleLight2,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: appPurpleDark,
    foregroundColor: appWhite,
  ),
);

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
    listTileTheme: ListTileThemeData(
      textColor: appWhite,
    ),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 2, color: appWhite),
        ),
      ),
      labelColor: appWhite,
      unselectedLabelColor: appWhite2,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appWhite,
      foregroundColor: appPurpleDark,
    ));

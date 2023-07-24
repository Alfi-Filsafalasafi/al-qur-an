import 'package:alquran/app/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  // Memastikan binding telah diinisialisasi sebelum pemanggilan fungsi lainnya
  WidgetsFlutterBinding.ensureInitialized();

  // Atur tema status bar sebelum runApp()
  setStatusBarTheme();

  runApp(
    GetMaterialApp(
      theme: themeDark,
      themeMode: ThemeMode.light,
      darkTheme: themeDark,
      debugShowCheckedModeBanner: false,
      title: "Application",
      // initialRoute: AppPages.INITIAL,
      initialRoute: Routes.INTRODUCTION,
      getPages: AppPages.routes,
    ),
  );
}

// Fungsi untuk mengatur tema status bar secara global
void setStatusBarTheme() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        Get.isDarkMode ? Brightness.dark : Brightness.light,
  ));
}

import 'dart:convert';
import 'dart:io';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

import '../../../constant/color.dart';

class HomeController extends GetxController {
  List<Surah> allSurah = [];

  void changeTheme() {
    Get.isDarkMode ? Get.changeTheme(themeLight) : Get.changeTheme(themeDark);

    final box = GetStorage();
    if (Get.isDarkMode) {
      box.remove("themeDark");
    } else {
      box.write("themeDark", true);
    }
  }

  Future<List<Surah>> getAllSurah() async {
    // Omit the 'new' keyword when instantiating HttpClient
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    // Use the IOClient class from the http package
    http.Client client = IOClient(httpClient);

    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var resp = await client.get(url);
    List? data = (json.decode(resp.body) as Map<String, dynamic>)["data"];

    if (data == null || data.isEmpty) {
      return [];
    } else {
      allSurah = data.map((e) => Surah.fromJson(e)).toList();
      return allSurah;
    }
  }

  // Future<List<Juz>> getAllJuz() async {
  //   List<Juz> allJuz = [];
  //   for (int i = 10; i <= 30; i++) {
  //     HttpClient httpClient = HttpClient();
  //     httpClient.badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => true);

  //     // Use the IOClient class from the http package
  //     http.Client client = IOClient(httpClient);

  //     Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");
  //     var resp = await client.get(url);
  //     Map<String, dynamic> data =
  //         (json.decode(resp.body) as Map<String, dynamic>)["data"];

  //     Juz juz = Juz.fromJson(data);
  //     allJuz.add(juz);
  //   }
  //   return allJuz;
  // }
  Future<List<Map<String, dynamic>>> getAllJuz() async {
    int juz = 1;

    List<Map<String, dynamic>> penampungAyat = [];
    List<Map<String, dynamic>> allJuz = [];

    for (var i = 1; i <= 30; i++) {
      // Omit the 'new' keyword when instantiating HttpClient
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      // Use the IOClient class from the http package
      http.Client client = IOClient(httpClient);

      Uri url = Uri.parse("https://api.quran.gading.dev/surah/$i");
      var resp = await client.get(url);
      Map<String, dynamic> rawData = json.decode(resp.body)["data"];
      DetailSurah data = DetailSurah.fromJson(rawData);

      data.verses.forEach((ayat) {
        if (ayat.meta.juz == juz) {
          penampungAyat.add({
            "surah": data,
            "ayat": ayat,
          });
        } else {
          allJuz.add({
            "juz": juz,
            "start": penampungAyat[0],
            "end": penampungAyat[0],
            "verses": penampungAyat,
          });
          juz++;
          penampungAyat = [];
          penampungAyat.add({
            "surah": data,
            "ayat": ayat,
          });
        }
      });
    }
    allJuz.add({
      "juz": juz,
      "start": penampungAyat[0],
      "end": penampungAyat[penampungAyat.length - 1],
      "verses": penampungAyat,
    });
    return allJuz;
  }
}

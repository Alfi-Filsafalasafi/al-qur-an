import 'dart:convert';
import 'dart:io';

import 'package:alquran/app/data/models/juz.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HomeController extends GetxController {
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
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<List<Juz>> getAllJuz() async {
    List<Juz> allJuz = [];
    for (int i = 10; i <= 30; i++) {
      HttpClient httpClient = HttpClient();
      httpClient.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

      // Use the IOClient class from the http package
      http.Client client = IOClient(httpClient);

      Uri url = Uri.parse("https://api.quran.gading.dev/juz/$i");
      var resp = await client.get(url);
      Map<String, dynamic> data =
          (json.decode(resp.body) as Map<String, dynamic>)["data"];

      Juz juz = Juz.fromJson(data);
      allJuz.add(juz);
    }
    return allJuz;
  }
}

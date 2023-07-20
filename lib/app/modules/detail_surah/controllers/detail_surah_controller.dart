import 'dart:convert';
import 'dart:io';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;

class DetailSurahController extends GetxController {
  Future<DetailSurah> getDetailSurah(String id) async {
    // Omit the 'new' keyword when instantiating HttpClient
    HttpClient httpClient = HttpClient();
    httpClient.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);

    // Use the IOClient class from the http package
    http.Client client = IOClient(httpClient);

    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var resp = await client.get(url);
    Map<String, dynamic> data =
        (json.decode(resp.body) as Map<String, dynamic>)["data"];

    return DetailSurah.fromJson(data);
  }
}

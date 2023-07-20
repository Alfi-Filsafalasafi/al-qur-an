import 'dart:convert';
import 'dart:io';
// import 'package:alquran/app/data/models/detailSurah.dart';
// import 'package:alquran/app/data/models/surah.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

void main() async {
  // Omit the 'new' keyword when instantiating HttpClient
  HttpClient httpClient = HttpClient();
  httpClient.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);

  // Use the IOClient class from the http package
  http.Client client = IOClient(httpClient);

  // Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  // var resp = await client.get(url);
  // List data = (json.decode(resp.body) as Map<String, dynamic>)["data"];

//0-113
  // print(data[0]);

  // Surah surahAnnas = Surah.fromJson(data[113]);
  // print(surahAnnas.number);
  //ini data dari nested
  // print(surahAnnas.name.long);

  // Uri urlAnnas =
  //     Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  // var respAnnas = await client.get(urlAnnas);
  // Map<String, dynamic> dataAnnas =
  //     (json.decode(respAnnas.body) as Map<String, dynamic>)["data"];

  // DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);
  // print(detailSurahAnnas.verses[0].text.arab);

  Uri urlAnnas = Uri.parse("https://api.quran.gading.dev/surah/102/1");
  var respAnnas = await client.get(urlAnnas);
  Map<String, dynamic> dataAnnas =
      (json.decode(respAnnas.body) as Map<String, dynamic>)["data"];
  print(dataAnnas);

  // DetailSurah detailSurahAnnas = DetailSurah.fromJson(dataAnnas);
  // print(detailSurahAnnas.verses[0].text.arab);
}

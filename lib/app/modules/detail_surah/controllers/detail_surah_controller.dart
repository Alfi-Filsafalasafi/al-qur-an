import 'dart:convert';
import 'dart:io';

import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  Verse? lastVerse;

  void playAudio(Verse ayat) async {
    if (ayat.audio.primary != null) {
      // Catching errors at load time
      try {
        //mengecek apakah ada ayat yg sebelumnya diputar
        if (lastVerse == null) {
          lastVerse = ayat;
        }
        lastVerse!.kondisiAudio = "stop";
        // mengubah ayat yg terakhir di ubah menjadi yang sedang di putar
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();
        await player.stop();
        await player.setUrl(ayat.audio.primary);
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        await player.stop();
        update();
      } on PlayerException catch (e) {
        Get.defaultDialog(
          title: "terjadi Kesalahan",
          middleText: "Tidak dapat dijalankan karena ${e.code}",
        );
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
          title: "terjadi Kesalahan",
          middleText: "Tidak dapat dijalankan karena ${e.message}",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "terjadi Kesalahan",
          middleText: "Tidak dapat dijalankan karena $e",
        );
      }
    } else {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "URL audio tidak tersedia",
      );
    }
  }

  void pauseAudio(Verse ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat pause karena ${e.code}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat pause karena ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat pause karena $e",
      );
    }
  }

  void resumeAudio(Verse ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat resume karena ${e.code}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat resume karena ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat resume karena $e",
      );
    }
  }

  void stopAudio(Verse ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat stop karena ${e.code}",
      );
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat stop karena ${e.message}",
      );
    } catch (e) {
      Get.defaultDialog(
        title: "terjadi Kesalahan",
        middleText: "Tidak dapat stop karena $e",
      );
    }
  }

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

  @override
  void onClose() {
    // TODO: implement onClose
    player.dispose();
    super.onClose();
  }
}

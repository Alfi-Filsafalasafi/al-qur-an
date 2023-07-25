import 'dart:convert';
import 'dart:io';

import 'package:alquran/app/data/db/bookmark.dart';
import 'package:alquran/app/data/models/detailSurah.dart';
import 'package:alquran/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/io_client.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';

class DetailSurahController extends GetxController {
  final player = AudioPlayer();

  Verse? lastVerse;

  DatabaseManager database = DatabaseManager.instance;

  Future<void> addBookmark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;

    bool flagExist = false;

    if (lastRead == true) {
      await db.delete("bookmark", where: "last_read = 1");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.name.transliteration.id.replaceAll("'", "@")}' and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 0 ");
      if (checkData.length != 0) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name.transliteration.id.replaceAll("'", "@")}",
        "ayat": ayat.number.inSurah,
        "juz": ayat.meta.juz,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back(); //tutup getDialog\
      Get.snackbar("Berhasil", "Berhasil menambahkan bookmark");
    } else {
      Get.back(); //tutup getDialog
      Get.snackbar("Terjadi Kesalhan", "Bookmark sudah tersedia");
    }
    var data = await db.query("bookmark"); //test select * bookmark
    print(data);
  }

  void playAudio(Verse ayat) async {
    // ignore: unnecessary_null_comparison
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

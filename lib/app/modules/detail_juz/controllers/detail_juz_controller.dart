import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/db/bookmark.dart';
import '../../../data/models/detailSurah.dart';

class DetailJuzController extends GetxController {
  AutoScrollController scrollC = AutoScrollController();
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
              "surah = '${surah.name.transliteration.id.replaceAll("'", "@")}' and number_surah = ${surah.number} and ayat = ${ayat.number.inSurah} and juz = ${ayat.meta.juz} and via = 'juz' and index_ayat = $indexAyat and last_read = 0 ");
      if (checkData.length != 0) {
        flagExist = true;
      }
    }

    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name.transliteration.id.replaceAll("'", "@")}",
        "ayat": ayat.number.inSurah,
        "number_surah": surah.number,
        "juz": ayat.meta.juz,
        "via": "juz",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0,
      });

      Get.back(); //tutup getDialog
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

  @override
  void onClose() {
    // TODO: implement onClose
    player.dispose();
    super.onClose();
  }
}

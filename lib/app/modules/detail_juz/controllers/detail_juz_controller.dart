import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

import '../../../data/models/detailSurah.dart';

class DetailJuzController extends GetxController {
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

  @override
  void onClose() {
    // TODO: implement onClose
    player.dispose();
    super.onClose();
  }
}

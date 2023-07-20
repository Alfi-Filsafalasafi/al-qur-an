import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: Get.width * 0.7,
              height: Get.width * 0.7,
              child: Lottie.asset("assets/lottie/introduction.json")),
          Text(
            "Al-Qur'an",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Sudahkah anda membaca Al-qur'an hari ini ?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () => Get.offAllNamed(Routes.HOME),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Text("Mulai"),
            ),
          ),
        ],
      )),
    );
  }
}

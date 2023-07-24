import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final juz.Juz detailJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz ${detailJuz.juz}'),
          centerTitle: true,
        ),
        body: ListView.builder(
            itemCount: detailJuz.verses?.length ?? 0,
            itemBuilder: (context, index) {
              if (detailJuz.verses == null || detailJuz.verses?.length == 0) {
                return Center(
                  child: Text("Tidak ada data"),
                );
              }
              juz.Verses ayat = detailJuz.verses![index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: appPurpleLight2.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: appPurple,
                              ),
                              child: Center(
                                  child: Text(
                                "${ayat.number!.inSurah}",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.bookmark_add_outlined)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.play_arrow))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${ayat.text!.arab}",
                      textAlign: TextAlign.end,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width,
                      child: Text(
                        "${ayat.translation!.id}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              );
            }));
  }
}

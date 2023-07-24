import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/detailSurah.dart' as detail;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/surah.dart';
import '../controllers/detail_surah_controller.dart';

class DetailSurahView extends GetView<DetailSurahController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Surah ${surah.name.transliteration.id}"),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            GestureDetector(
              onTap: () => Get.defaultDialog(
                titlePadding: EdgeInsets.symmetric(vertical: 15),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                title: "Tafsir ${surah.name.transliteration.id}",
                content: Text(
                  "${surah.tafsir.id}",
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(colors: [
                      appPurpleLight2,
                      appPurpleLight1,
                    ])),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        "${surah.name.transliteration.id}",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: appWhite),
                      ),
                      Text(
                        "(${surah.name.translation.id})",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: appWhite),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${surah.numberOfVerses} ayat | ${surah.revelation.id}",
                        style: TextStyle(color: appWhite),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Tidak ada data"),
                    );
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: surah.numberOfVerses,
                      itemBuilder: (context, index) {
                        if (snapshot.data?.verses.length == 0) {
                          return SizedBox();
                        }
                        detail.Verse? ayat = snapshot.data?.verses[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: appPurpleLight2.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        "${index + 1}",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.bookmark_add_outlined)),
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
                              "${ayat!.text.arab}",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width: Get.width,
                              child: Text(
                                "${ayat.translation.id}",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        );
                      });
                })
          ],
        ));
  }
}

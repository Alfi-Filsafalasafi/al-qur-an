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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      "${surah.name.transliteration.id}",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "(${surah.name.translation.id})",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                        "${surah.numberOfVerses} ayat | ${surah.revelation.id}")
                  ],
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
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CircleAvatar(
                                      child: Text("${index + 1}"),
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
                            Text(
                              "${ayat!.text.arab}",
                              textAlign: TextAlign.end,
                              style: TextStyle(fontSize: 25),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${ayat!.translation.id}",
                              style: TextStyle(fontSize: 16),
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

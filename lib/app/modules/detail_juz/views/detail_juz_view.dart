// import 'package:alquran/app/data/models/ayat.dart' as surah;
// import 'package:alquran/app/data/models/juz.dart' as juz;
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../constant/color.dart';
import '../../../data/models/detailSurah.dart' as detail;
import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final Map<String, dynamic> dataMapPerJuz = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz ${dataMapPerJuz["juz"]}'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: (dataMapPerJuz["verses"] as List).length,
                itemBuilder: (context, index) {
                  if (dataMapPerJuz["verses"] as List == 0) {
                    return Center(
                      child: Text("Tidak ada data"),
                    );
                  }
                  Map<String, dynamic> ayat = dataMapPerJuz["verses"][index];
                  detail.DetailSurah surah = ayat["surah"];
                  detail.Verse verse = ayat['ayat'];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (verse.number.inSurah == 1)
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () => Get.defaultDialog(
                                  titlePadding:
                                      EdgeInsets.symmetric(vertical: 15),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  title:
                                      "Tafsir ${surah.name.transliteration.id}",
                                  content: Text(
                                    "${surah.tafsir.id}",
                                    style: TextStyle(fontSize: 14),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                child: Container(
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      appPurpleLight2,
                                      appPurpleLight1,
                                    ]),
                                  ),
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
                                              fontWeight: FontWeight.w500,
                                              color: appWhite),
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
                            ],
                          ),
                        Container(
                          decoration: BoxDecoration(
                              color: appPurpleLight2.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
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
                                          "${verse.number.inSurah}",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text("${surah.name.transliteration.id}")
                                  ],
                                ),
                                GetBuilder<DetailJuzController>(
                                  builder: (c) => Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Bookmark",
                                              middleText:
                                                  "Pilih Jenis Bookmark",
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.addBookmark(true, surah,
                                                        verse, index);
                                                  },
                                                  child: Text(
                                                    "Terakhir dibaca",
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appPurple,
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    c.addBookmark(false, surah,
                                                        verse, index);
                                                  },
                                                  child: Text("Bookmark"),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: appPurple,
                                                  ),
                                                ),
                                              ]);
                                        },
                                        icon: Icon(Icons.bookmark_add_outlined),
                                      ),
                                      (verse.kondisiAudio == "stop")
                                          ? IconButton(
                                              onPressed: () {
                                                c.playAudio(verse);
                                              },
                                              icon: Icon(Icons.play_arrow),
                                            )
                                          : Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                (verse.kondisiAudio ==
                                                        "playing")
                                                    ? IconButton(
                                                        onPressed: () {
                                                          c.pauseAudio(verse);
                                                        },
                                                        icon: Icon(Icons.pause),
                                                      )
                                                    : IconButton(
                                                        onPressed: () {
                                                          c.resumeAudio(verse);
                                                        },
                                                        icon: Icon(
                                                            Icons.play_arrow),
                                                      ),
                                                IconButton(
                                                  onPressed: () {
                                                    c.stopAudio(verse);
                                                  },
                                                  icon: Icon(Icons.stop),
                                                )
                                              ],
                                            )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${(ayat['ayat'] as detail.Verse).text.arab}",
                          textAlign: TextAlign.end,
                          style: TextStyle(fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: Get.width,
                          child: Text(
                            "${(ayat['ayat'] as detail.Verse).translation.id}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ));
  }
}

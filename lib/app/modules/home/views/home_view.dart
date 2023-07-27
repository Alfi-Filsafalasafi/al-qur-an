import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Al Quran',
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        // centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.SEARCH),
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Assalamu'alaikum",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              GetBuilder<HomeController>(
                builder: (c) => FutureBuilder<Map<String, dynamic>?>(
                  future: c.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              appPurpleLight2,
                              appPurpleLight1,
                            ],
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: -50,
                              right: 0,
                              child: Opacity(
                                opacity: 0.8,
                                child: Container(
                                    width: 160,
                                    height: 160,
                                    child: Image.asset(
                                        "assets/image/alquran.png")),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.menu_book_rounded,
                                        color: appWhite1,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Terakhir di baca",
                                        style: TextStyle(color: appWhite1),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    "Loading",
                                    style: TextStyle(
                                        color: appWhite1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "",
                                    style: TextStyle(
                                        color: appWhite1,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    Map<String, dynamic>? lastRead = snapshot.data;

                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            appPurpleLight2,
                            appPurpleLight1,
                          ],
                        ),
                      ),
                      child: Material(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onLongPress: () {
                            if (lastRead != null) {
                              Get.defaultDialog(
                                  title: "Menghapus Data Last Read",
                                  middleText: "Apakah anda akan menghapus ?",
                                  actions: [
                                    OutlinedButton(
                                      onPressed: () => Get.back(),
                                      child: Text("Cancel"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        c.deleteLastRead(lastRead["id"]);
                                      },
                                      child: Text("Delete"),
                                    ),
                                  ]);
                            }
                          },
                          onTap: () {
                            if (lastRead != null) {
                              switch (lastRead["via"]) {
                                case "juz":
                                  Map<String, dynamic> dataMapPerJuz =
                                      controller.allJuz[lastRead["juz"] - 1];
                                  Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                                    "juz": dataMapPerJuz,
                                    "bookmark": lastRead
                                  });
                                default:
                                  Get.toNamed(Routes.DETAIL_SURAH, arguments: {
                                    "name": lastRead["surah"]
                                        .toString()
                                        .replaceAll("@", "'"),
                                    "number": lastRead["number_surah"],
                                    "bookmark": lastRead,
                                  });
                              }
                              // Get.toNamed(Routes.LAST_READ);
                            }
                          },
                          child: Container(
                            width: Get.width,
                            child: Stack(
                              children: [
                                Positioned(
                                  bottom: -50,
                                  right: 0,
                                  child: Opacity(
                                    opacity: 0.8,
                                    child: Container(
                                        width: 160,
                                        height: 160,
                                        child: Image.asset(
                                            "assets/image/alquran.png")),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.menu_book_rounded,
                                            color: appWhite1,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Terakhir di baca",
                                            style: TextStyle(color: appWhite1),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        lastRead == null
                                            ? "Belum ada"
                                            : "${lastRead["surah"].toString().replaceAll("@", "'")}",
                                        style: TextStyle(
                                            color: appWhite1,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        lastRead == null
                                            ? "-"
                                            : "Juz ${lastRead["juz"]} | Ayat ${lastRead["ayat"]}",
                                        style: TextStyle(
                                            color: appWhite1,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                tabs: [
                  Tab(text: "Surah"),
                  Tab(text: "Juz"),
                  Tab(text: "Bookmark"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    FutureBuilder<List<Surah>>(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Surah surah = snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(Routes.DETAIL_SURAH,
                                    arguments: {
                                      "name": surah.name.transliteration.id,
                                      "number": surah.number,
                                    }),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/listnumber.png"),
                                    ),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${surah.number}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )),
                                ),
                                title: Text(
                                  "${surah.name.transliteration.id}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  "${surah.numberOfVerses} ayat | ${surah.revelation.id}",
                                  style: TextStyle(
                                      color: appWhite2,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Text(
                                  "${surah.name.short}",
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? appPurpleLight1
                                          : appPurple,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            });
                      },
                    ),
                    //ini merupakan page 2
                    FutureBuilder<List<Map<String, dynamic>>>(
                        future: controller.getAllJuz(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            controller.dataAllJuz.value = false;
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (!snapshot.hasData) {
                            return Center(
                              child: Text("Tidak ada data"),
                            );
                          }

                          controller.dataAllJuz.value = true;

                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> dataMapPerJuz =
                                  snapshot.data![index];
                              return ListTile(
                                onTap: () => Get.toNamed(Routes.DETAIL_JUZ,
                                    arguments: {"juz": dataMapPerJuz}),
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/icon/listnumber.png"),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  "Juz ${index + 1}",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                              );
                            },
                          );
                        }),
                    // FutureBuilder<List<juz.Juz>>(
                    //   future: controller.getAllJuz(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Center(
                    //         child: CircularProgressIndicator(),
                    //       );
                    //     }
                    //     if (!snapshot.hasData) {
                    //       return Center(
                    //         child: Text("Tidak ada data"),
                    //       );
                    //     }
                    //     return ListView.builder(
                    //       itemCount: snapshot.data!.length,
                    //       itemBuilder: (context, index) {
                    //         juz.Juz detailJuz = snapshot.data![index];
                    //         String nameStart =
                    //             detailJuz.juzStartInfo?.split(" - ").first ??
                    //                 "";
                    //         String nameEnd =
                    //             detailJuz.juzEndInfo?.split(" - ").first ?? "";

                    //         List<Surah> rawAllSurahInJuz = [];
                    //         List<Surah> allSurahInJuz = [];

                    //         for (Surah item in controller.allSurah) {
                    //           rawAllSurahInJuz.add(item);
                    //           if (item.name.transliteration.id == nameEnd) {
                    //             break;
                    //           }
                    //         }
                    //         for (Surah item
                    //             in rawAllSurahInJuz.reversed.toList()) {
                    //           allSurahInJuz.add(item);
                    //           if (item.name.transliteration.id == nameStart) {
                    //             break;
                    //           }
                    //         }
                    //         return ListTile(
                    //           onTap: () =>
                    //               Get.toNamed(Routes.DETAIL_JUZ, arguments: {
                    //             "juz": detailJuz,
                    //             "surah": allSurahInJuz.reversed.toList(),
                    //           }),
                    //           leading: Container(
                    //             width: 40,
                    //             height: 40,
                    //             decoration: BoxDecoration(
                    //               image: DecorationImage(
                    //                 image: AssetImage(
                    //                     "assets/icon/listnumber.png"),
                    //               ),
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 "${index + 1}",
                    //                 style:
                    //                     TextStyle(fontWeight: FontWeight.w600),
                    //               ),
                    //             ),
                    //           ),
                    //           title: Text("Juz ${index + 1}"),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),

                    //merupakan page ketiga
                    GetBuilder<HomeController>(
                      builder: (c) {
                        if (c.dataAllJuz.isFalse) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 20),
                                Text("Menunggu data di juz ..."),
                              ],
                            ),
                          );
                        } else {
                          return FutureBuilder<List<Map<String, dynamic>>>(
                            future: c.getBookmark(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.data!.length == 0) {
                                return Center(
                                  child: Text("Bookmark belum ada"),
                                );
                              }

                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> data =
                                      snapshot.data![index];
                                  return ListTile(
                                    onTap: () {
                                      switch (data["via"]) {
                                        case "juz":
                                          print("Go to Detail Juz");
                                          print(data);
                                          Map<String, dynamic> dataMapPerJuz =
                                              controller
                                                  .allJuz[data["juz"] - 1];
                                          Get.toNamed(Routes.DETAIL_JUZ,
                                              arguments: {
                                                "juz": dataMapPerJuz,
                                                "bookmark": data
                                              });
                                        default:
                                          Get.toNamed(Routes.DETAIL_SURAH,
                                              arguments: {
                                                "name": data["surah"]
                                                    .toString()
                                                    .replaceAll("@", "'"),
                                                "number": data["number_surah"],
                                                "bookmark": data,
                                              });
                                      }
                                    },
                                    leading: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/icon/listnumber.png"),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      "${data["surah"].toString().replaceAll("@", "'")}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      "Ayat ${data['ayat']} | via ${data['via']}",
                                      style: TextStyle(
                                          color: appWhite2,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          c.deleteBookmark(data["id"]);
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                          color: appPurple,
                                        )),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.changeTheme(),
        child: Icon(
          Icons.color_lens,
        ),
      ),
    );
  }
}

import 'package:alquran/app/constant/color.dart';
import 'package:alquran/app/data/models/surah.dart';
import 'package:alquran/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '../../../data/models/juz.dart' as juz;
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
              Container(
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
                    onTap: () => Get.toNamed(Routes.LAST_READ),
                    child: Container(
                      height: 150,
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
                                  child:
                                      Image.asset("assets/image/alquran.png")),
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
                                  "Al-Fatihah",
                                  style: TextStyle(
                                      color: appWhite1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Juz 1 | Ayat 5",
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
                                    arguments: surah),
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
                                  "${surah.name?.transliteration.id ?? "Error"}",
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
                    FutureBuilder<List<juz.Juz>>(
                      future: controller.getAllJuz(),
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
                            juz.Juz detailJuz = snapshot.data![index];
                            return ListTile(
                              onTap: () => Get.toNamed(Routes.DETAIL_JUZ,
                                  arguments: detailJuz),
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
                                    "${index + 10}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              title: Text("Juz ${index + 10}"),
                            );
                          },
                        );
                      },
                    ),
                    Center(
                      child: Text("Page 3"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.isDarkMode
              ? Get.changeTheme(themeLight)
              : Get.changeTheme(themeDark);
        },
        child: Icon(
          Icons.color_lens,
        ),
      ),
    );
  }
}

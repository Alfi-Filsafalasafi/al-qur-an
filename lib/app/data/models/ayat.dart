// To parse this JSON data, do
//
//     final ayat = ayatFromJson(jsonString);
//  api url https://api.quran.gading.dev/surah/12/3
//  Get seluruh surah dalam alqur'an

import 'dart:convert';

Ayat ayatFromJson(String str) => Ayat.fromJson(json.decode(str));

String ayatToJson(Ayat data) => json.encode(data.toJson());

class Ayat {
  Number number;
  Meta meta;
  Text text;
  Translation translation;
  Audio audio;
  AyatTafsir tafsir;
  Surah surah;

  Ayat({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
    required this.tafsir,
    required this.surah,
  });

  factory Ayat.fromJson(Map<String, dynamic> json) => Ayat(
        number: Number.fromJson(json["number"]),
        meta: Meta.fromJson(json["meta"]),
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
        audio: Audio.fromJson(json["audio"]),
        tafsir: AyatTafsir.fromJson(json["tafsir"]),
        surah: Surah.fromJson(json["surah"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "meta": meta.toJson(),
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
        "tafsir": tafsir.toJson(),
        "surah": surah.toJson(),
      };
}

class Audio {
  String primary;
  List<String> secondary;

  Audio({
    required this.primary,
    required this.secondary,
  });

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": List<dynamic>.from(secondary.map((x) => x)),
      };
}

class Meta {
  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;
  Sajda sajda;

  Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: Sajda.fromJson(json["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda.toJson(),
      };
}

class Sajda {
  bool recommended;
  bool obligatory;

  Sajda({
    required this.recommended,
    required this.obligatory,
  });

  factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Number {
  int inQuran;
  int inSurah;

  Number({
    required this.inQuran,
    required this.inSurah,
  });

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Surah {
  int number;
  int sequence;
  int numberOfVerses;
  Name name;
  Revelation revelation;
  SurahTafsir tafsir;
  dynamic preBismillah;

  Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    this.preBismillah,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        name: Name.fromJson(json["name"]),
        revelation: Revelation.fromJson(json["revelation"]),
        tafsir: SurahTafsir.fromJson(json["tafsir"]),
        preBismillah: json["preBismillah"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name.toJson(),
        "revelation": revelation.toJson(),
        "tafsir": tafsir.toJson(),
        "preBismillah": preBismillah,
      };
}

class Name {
  String short;
  String long;
  Translation transliteration;
  Translation translation;

  Name({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        short: json["short"],
        long: json["long"],
        transliteration: Translation.fromJson(json["transliteration"]),
        translation: Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration.toJson(),
        "translation": translation.toJson(),
      };
}

class Translation {
  String en;
  String id;

  Translation({
    required this.en,
    required this.id,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class Revelation {
  String arab;
  String en;
  String id;

  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
}

class SurahTafsir {
  String id;

  SurahTafsir({
    required this.id,
  });

  factory SurahTafsir.fromJson(Map<String, dynamic> json) => SurahTafsir(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class AyatTafsir {
  Id id;

  AyatTafsir({
    required this.id,
  });

  factory AyatTafsir.fromJson(Map<String, dynamic> json) => AyatTafsir(
        id: Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
      };
}

class Id {
  String short;
  String long;

  Id({
    required this.short,
    required this.long,
  });

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}

class Text {
  String arab;
  Transliteration transliteration;

  Text({
    required this.arab,
    required this.transliteration,
  });

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration.toJson(),
      };
}

class Transliteration {
  String en;

  Transliteration({
    required this.en,
  });

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

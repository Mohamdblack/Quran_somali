// To parse this JSON data, do
//
//     final surahTransaltionModel = surahTransaltionModelFromJson(jsonString);

import 'dart:convert';

SurahTransaltionModel surahTransaltionModelFromJson(String str) =>
    SurahTransaltionModel.fromJson(json.decode(str));

String surahTransaltionModelToJson(SurahTransaltionModel data) =>
    json.encode(data.toJson());

class SurahTransaltionModel {
  List<Result> result;

  SurahTransaltionModel({
    required this.result,
  });

  factory SurahTransaltionModel.fromJson(Map<String, dynamic> json) =>
      SurahTransaltionModel(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  String id;
  String sura;
  String aya;
  String arabicText;
  String translation;
  String footnotes;

  Result({
    required this.id,
    required this.sura,
    required this.aya,
    required this.arabicText,
    required this.translation,
    required this.footnotes,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        sura: json["sura"],
        aya: json["aya"],
        arabicText: json["arabic_text"],
        translation: json["translation"],
        footnotes: json["footnotes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sura": sura,
        "aya": aya,
        "arabic_text": arabicText,
        "translation": translation,
        "footnotes": footnotes,
      };
}

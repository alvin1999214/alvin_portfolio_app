// To parse this JSON data, do
//
//     final languageSkillModel = languageSkillModelFromJson(jsonString);

import 'dart:convert';

List<LanguageSkillModel> languageSkillModelFromJson(String str) => List<LanguageSkillModel>.from(json.decode(str).map((x) => LanguageSkillModel.fromJson(x)));

String languageSkillModelToJson(List<LanguageSkillModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageSkillModel {
  LanguageSkillModel({
    required this.language,
    required this.rating,
  });

  String language;
  String rating;

  factory LanguageSkillModel.fromJson(Map<String, dynamic> json) => LanguageSkillModel(
    language: json["language"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "rating": rating,
  };
}

// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Welcome> welcomeFromJson(String str) => List<Welcome>.from(json.decode(str).map((x) => Welcome.fromJson(x)));

String welcomeToJson(List<Welcome> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Welcome {
  Welcome({
    required this.language,
    required this.rating,
  });

  String language;
  String rating;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
    language: json["language"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "rating": rating,
  };
}

// To parse this JSON data, do
//
//     final personalInfoModel = personalInfoModelFromJson(jsonString);

import 'dart:convert';

PersonalInfoModel personalInfoModelFromJson(String str) => PersonalInfoModel.fromJson(json.decode(str));

String personalInfoModelToJson(PersonalInfoModel data) => json.encode(data.toJson());

class PersonalInfoModel {
  PersonalInfoModel({
    required this.info,
    required this.careerObjective,
  });

  Info info;
  String careerObjective;

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json) => PersonalInfoModel(
    info: Info.fromJson(json["info"]),
    careerObjective: json["career_objective"],
  );

  Map<String, dynamic> toJson() => {
    "info": info.toJson(),
    "career_objective": careerObjective,
  };
}

class Info {
  Info({
    required this.name,
    required this.phone,
    required this.address,
    required this.github,
    required this.title,
  });

  String name;
  String phone;
  String address;
  String github;
  String title;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    github: json["github"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "address": address,
    "github": github,
    "title": title,
  };
}

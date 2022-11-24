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
    required this.nickName,
    required this.fullName,
    required this.name,
    required this.phone,
    required this.address,
    required this.github,
    required this.title,
    required this.email,
  });

  String nickName;
  String fullName;
  String name;
  String phone;
  String address;
  String github;
  String title;
  String email;

  factory Info.fromJson(Map<String, dynamic> json) => Info(
    nickName: json["nickName"],
    fullName: json["fullName"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"],
    github: json["github"],
    title: json["title"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "nickName": nickName,
    "fullName": fullName,
    "phone": phone,
    "address": address,
    "github": github,
    "title": title,
    "email": email,
  };
}

// To parse this JSON data, do
//
//     final personalExperienceModel = personalExperienceModelFromJson(jsonString);

import 'dart:convert';

List<PersonalExperienceModel> personalExperienceModelFromJson(String str) => List<PersonalExperienceModel>.from(json.decode(str).map((x) => PersonalExperienceModel.fromJson(x)));

String personalExperienceModelToJson(List<PersonalExperienceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonalExperienceModel {
  PersonalExperienceModel({
    required this.companyName,
    required this.position,
    required this.from,
    required this.to,
    required this.responsibility,
    required this.programLauguage,
    required this.software,
  });

  String companyName;
  String position;
  String from;
  String to;
  String responsibility;
  String programLauguage;
  String software;

  factory PersonalExperienceModel.fromJson(Map<String, dynamic> json) => PersonalExperienceModel(
    companyName: json["company_name"],
    position: json["position"],
    from: json["from"],
    to: json["to"],
    responsibility: json["responsibility"],
    programLauguage: json["program_lauguage"],
    software: json["software"],
  );

  Map<String, dynamic> toJson() => {
    "company_name": companyName,
    "position": position,
    "from": from,
    "to": to,
    "responsibility": responsibility,
    "program_lauguage": programLauguage,
    "software": software,
  };
}

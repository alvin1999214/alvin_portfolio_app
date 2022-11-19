// To parse this JSON data, do
//
//     final personalEducationModel = personalEducationModelFromJson(jsonString);

import 'dart:convert';

List<PersonalEducationModel> personalEducationModelFromJson(String str) => List<PersonalEducationModel>.from(json.decode(str).map((x) => PersonalEducationModel.fromJson(x)));

String personalEducationModelToJson(List<PersonalEducationModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PersonalEducationModel {
  PersonalEducationModel({
    required this.program,
    required this.school,
    required this.from,
    required this.to,
    required this.action,
    required this.image
  });

  String program;
  String school;
  String from;
  String to;
  String action;
  String image;

  factory PersonalEducationModel.fromJson(Map<String, dynamic> json) => PersonalEducationModel(
    program: json["program"],
    school: json["school"],
    from: json["from"],
    to: json["to"],
    action: json["action"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "program": program,
    "school": school,
    "from": from,
    "to": to,
    "action": action,
    "image": image,
  };
}

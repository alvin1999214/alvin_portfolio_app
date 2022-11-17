class PersonalEducationModel {
  Education education;

  PersonalEducationModel({
    required this.education
  });

  factory PersonalEducationModel.fromJson(Map<String, dynamic> json){
    return PersonalEducationModel(
      education: Education.fromJson(json['education']),
    );
  }
}

class Education {
  String program;
  String school;
  String from;
  String to;

  Education({
    required this.program,
    required this.school,
    required this.from,
    required this.to
  });

  factory Education.fromJson(Map<String, dynamic> json){
    return Education(
      program: json['program'],
      school: json['school'],
      from: json['from'],
      to: json['to']
    );
  }
}
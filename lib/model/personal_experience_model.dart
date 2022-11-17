class PersonalExperienceModel {
  WorkExperience workExperience;

  PersonalExperienceModel({
    required this.workExperience
  });

  factory PersonalExperienceModel.fromJson(Map<String, dynamic> json){
    return PersonalExperienceModel(
        workExperience: WorkExperience.fromJson(json['workExperience']),
    );
  }
}

class WorkExperience {
  String company_name;
  String position;
  String from;
  String to;
  String responsibility;
  String program_lauguage;
  String software;

  WorkExperience({
    required this.company_name,
    required this.position,
    required this.from,
    required this.to,
    required this.responsibility,
    required this.program_lauguage,
    required this.software
  });

  factory WorkExperience.fromJson(Map<String, dynamic> json){
    return WorkExperience(
      company_name: json['company_name'],
      position: json['position'],
      from: json['from'],
      to: json['to'],
      responsibility: json['responsibility'],
      program_lauguage: json['program_lauguage'],
      software: json['software'],
    );
  }
}
class PersonalInfoModel{
  Info info;
  Language language;
  String objective;

  PersonalInfoModel({
    required this.info,
    required this.language,
    required this.objective

  });

  factory PersonalInfoModel.fromJson(Map<String, dynamic> json){
    return PersonalInfoModel(
      info: Info.fromJson(json['info']),
        language: Language.fromJson(json['language']),
        objective: json['career_objective']
    );
  }
}

class Info{
  String name;
  String phone;
  String address;
  String github;

  Info({
    required this.name,
    required this.phone,
    required this.address,
    required this.github
  });

  factory Info.fromJson(Map<String, dynamic> json){
    return Info(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      github: json['github'],
    );
  }
}

class Language{
  Skill skill;
  
  Language({
    required this.skill
  });
  
  factory Language.fromJson(Map<String, dynamic> json){
    return Language(skill: json['skill']);
  }
}

class Skill{
  String name;
  String rating;

  Skill({
    required this.name,
    required this.rating
  });
  
  factory Skill.fromJson(Map<String, dynamic> json){
    return Skill(
      name: json['name'],
      rating: json['rating'],
    );
  }
}
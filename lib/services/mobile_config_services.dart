import 'dart:convert';
import 'dart:async';

import 'package:alvin_portfolio_app/model/language_skill_model.dart';
import 'package:alvin_portfolio_app/model/mobile_config_model.dart';
import 'package:alvin_portfolio_app/model/personal_education_model.dart';
import 'package:alvin_portfolio_app/model/personal_experience_model.dart';
import 'package:alvin_portfolio_app/screens/home_page.dart';
import 'package:alvin_portfolio_app/values/configure.dart';
import 'package:alvin_portfolio_app/widget/pop_up_dialog.dart';
import 'package:alvin_portfolio_app/widget/rsa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/personal_info_model.dart';

const mobileConfigUrl = Configure.mobileConfigApi;
const personalInfoUrl = Configure.personalInfoApi;
const experienceUrl = Configure.experienceApi;
const educationUrl = Configure.educationApi;
const profileBgImg = Configure.profileBgImg;
const profileImg = Configure.profileImg;
const languageSkillUrl = Configure.languageSkillApi;

late String accessToken;
late var headers;
late var imgHeaders;

Future<MobileConfig> fetchMobileConfig(
    String mToken, BuildContext context) async {

  String decryptedToken = await rsaDecrypt(mToken);
  accessToken=decryptedToken;

  headers = {
    "Content-Type": "application/json",
    "Accept": "application/vnd.github.v3.raw",
    "Authorization": "Bearer $decryptedToken",
  };

  var response = await http.get(Uri.parse(mobileConfigUrl), headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ));
    return MobileConfig.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    showAccessFailDialog(context);
    throw Exception('Failed to load');
  }
}

Future<PersonalInfoModel> fetchPersonalInfoModel() async{

  var response = await http.get(Uri.parse(personalInfoUrl),headers: headers);

  if(response.statusCode == 200) {
    return PersonalInfoModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<PersonalExperienceModel>> fetchPersonalExperienceModel() async{

  var response = await http.get(Uri.parse(experienceUrl),headers: headers);

  if(response.statusCode == 200) {
    final List<PersonalExperienceModel> listWork = personalExperienceModelFromJson(response.body);
    return listWork;
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<PersonalEducationModel>> fetchPersonalEducationModel() async{

  var response = await http.get(Uri.parse(educationUrl),headers: headers);

  if(response.statusCode == 200) {
    final List<PersonalEducationModel> listEdu = personalEducationModelFromJson(response.body);
    return listEdu;
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<LanguageSkillModel>> fetchLanguageSkillModel() async{

  var response = await http.get(Uri.parse(languageSkillUrl),headers: headers);

  if(response.statusCode == 200) {
    final List<LanguageSkillModel> listLanguageSkill = languageSkillModelFromJson(response.body);
    return listLanguageSkill;
  } else {
    throw Exception('Failed to load');
  }
}

getTokenHeaders(){
  return headers;
}

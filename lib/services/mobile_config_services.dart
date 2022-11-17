import 'dart:convert';
import 'dart:async';

import 'package:alvin_portfolio_app/model/mobile_config_model.dart';
import 'package:alvin_portfolio_app/screens/home_page.dart';
import 'package:alvin_portfolio_app/values/configure.dart';
import 'package:alvin_portfolio_app/widget/pop_up_dialog.dart';
import 'package:alvin_portfolio_app/widget/rsa.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const mobileConfigUrl = StringValue.mobileConfigApi;
const personalInfoUrl = StringValue.personalInfoApi;
const experienceUrl = StringValue.experienceApi;
const educationUrl = StringValue.educationApi;

late String accessToken;

Future<MobileConfig> fetchMobileConfig(
    String mToken, BuildContext context) async {

  String decryptedToken = await rsaDecrypt(mToken);
  accessToken=decryptedToken;

  var headers = {
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

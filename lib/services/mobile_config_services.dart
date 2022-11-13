import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:alvin_portfolio_app/model/mobile_config.dart';
import 'package:http/http.dart' as http;

// class MobileConfigService {
const token = "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";
const API =
    'https://api.github.com/repos/alvin1999214/personal_profile/contents/mobile_config.json';
const headers = {
  "Content-Type": "application/json",
  "Accept": "application/vnd.github.v3.raw",
  "Authorization": "Bearer $token",
};

Future<MobileConfig> fetchMobileConfig() async {
  final response = await http.get(Uri.parse(API), headers: headers);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return MobileConfig.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}
//}

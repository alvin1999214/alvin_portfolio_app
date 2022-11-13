import 'dart:convert';
import 'dart:async';

import 'package:alvin_portfolio_app/model/mobile_config.dart';
import 'package:http/http.dart' as http;

// class MobileConfigService {
const API =
    'https://api.github.com/repos/alvin1999214/personal_profile/contents/my_mobile_config.json';
const headers = {
  'apiKey': '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',
  'Content-Type': 'application/vnd.github.v3.raw'
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

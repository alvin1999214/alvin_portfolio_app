import 'package:json_annotation/json_annotation.dart';

class MobileConfig {
  final String message;

  const MobileConfig({
    required this.message,
  });

  factory MobileConfig.fromJson(Map<String, dynamic> json) {
    return MobileConfig(
      message: json['message'],
    );
  }
}

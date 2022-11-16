import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/export.dart';
import 'dart:convert';

/// RSA decrypt by public key
/// PKCS1

Future<String> rsaDecrypt(String content) async {
  final publicPem = await rootBundle.loadString('assets/private.pem');
  final publicKey = RSAKeyParser().parse(publicPem) as RSAPrivateKey;
  RSAKeyParser parser = RSAKeyParser();
  AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
  cipher..init(false, PrivateKeyParameter<RSAPrivateKey>(publicKey));
  var data = utf8.decode(cipher.process(Encrypted.fromBase64(content).bytes));

  return data;
}

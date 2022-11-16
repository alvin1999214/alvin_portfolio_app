import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/export.dart';
import 'dart:convert';

/// RSA decrypt by public key
/// PKCS1

Future<String> rsaDecrypt(String content, String public) async {
  RSAKeyParser parser = RSAKeyParser();
  RSAPublicKey publicKey = parser.parse(public) as RSAPublicKey;
  AsymmetricBlockCipher cipher = PKCS1Encoding(RSAEngine());
  cipher..init(false, PublicKeyParameter<RSAPublicKey>(publicKey));
  var data = utf8.decode(cipher.process(Encrypted.fromBase64(content).bytes));

  return data;
}

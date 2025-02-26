import 'dart:convert';
import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:math';

import 'package:hive/hive.dart';


Sha1 computeSha1Hash(Uint8List bytes) => Sha1(sha1.convert(bytes).toString());


String generateRandomAlphanumeric(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}


Future<HiveAesCipher> getHiveAesCipher(String keyName) async {
  const storage = FlutterSecureStorage();

  // Check if the key exists in secure storage
  String? encodedKey = await storage.read(key: keyName);

  if (encodedKey == null) {
    // Generate a new 32-byte key
    final key = List<int>.generate(32, (i) => Random.secure().nextInt(256));

    // Store the key securely
    await storage.write(key: keyName, value: base64UrlEncode(key));

    return HiveAesCipher(key);
  } else {
    // Retrieve the stored key
    final key = base64Url.decode(encodedKey);
    return HiveAesCipher(key);
  }
}
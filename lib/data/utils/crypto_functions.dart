import 'dart:typed_data';

import 'package:akropolis/data/models/dto_models/dto_models.dart';
import 'package:crypto/crypto.dart';
import 'dart:math';


Sha1 computeSha1Hash(Uint8List bytes) => Sha1(sha1.convert(bytes).toString());


String generateRandomAlphanumeric(int length) {
  const String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final Random random = Random();

  return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
}

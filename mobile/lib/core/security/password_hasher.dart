import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';

/// Local salted multi-round SHA-256 password hasher for offline demo authentication.
abstract final class PasswordHasher {
  static final Random _random = Random.secure();

  static String generateSalt([int length = 16]) {
    final bytes = List<int>.generate(length, (_) => _random.nextInt(256));
    return base64UrlEncode(bytes);
  }

  static String hashPassword(String password, String salt) {
    List<int> digest = utf8.encode('$salt:$password');
    for (var i = 0; i < 1000; i++) {
      digest = sha256.convert(digest).bytes;
    }
    return base64UrlEncode(digest);
  }

  static bool verify(String password, String salt, String expectedHash) {
    final actual = hashPassword(password, salt);
    if (actual.length != expectedHash.length) return false;
    var diff = 0;
    for (var i = 0; i < actual.length; i++) {
      diff |= actual.codeUnitAt(i) ^ expectedHash.codeUnitAt(i);
    }
    return diff == 0;
  }
}

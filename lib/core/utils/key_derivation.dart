import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';

/// PBKDF2-HMAC-SHA256 for PINs and backup passwords. Runs in a background
/// isolate unless [inBackground] is false (tests under fake time, where a
/// spawned isolate can't finish).
Future<List<int>> pbkdf2Sha256({
  required String password,
  required List<int> salt,
  required int iterations,
  int bits = 256,
  bool inBackground = true,
}) {
  Future<List<int>> derive() async {
    final key = await Pbkdf2.hmacSha256(
      iterations: iterations,
      bits: bits,
    ).deriveKeyFromPassword(password: password, nonce: salt);
    return key.extractBytes();
  }

  return inBackground ? Isolate.run(derive) : derive();
}

/// [length] bytes from a cryptographically secure source.
List<int> secureRandomBytes(int length) {
  final random = Random.secure();
  return [for (var i = 0; i < length; i++) random.nextInt(256)];
}

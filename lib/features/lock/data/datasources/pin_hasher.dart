import 'dart:convert';
import 'dart:isolate';
import 'dart:math';

import 'package:cryptography/cryptography.dart';
import 'package:expense_tracker/features/lock/data/models/pin_hash_model.dart';

/// Hashes and checks PINs (PRD §6.4: salted hash). Key derivation runs in a
/// background isolate so the unlock animation doesn't stutter.
class PinHasher {
  const PinHasher({
    this.iterations = defaultIterations,
    this.inBackground = true,
  });

  /// PBKDF2 rounds for new PINs. Stored per hash, so it can change later.
  static const defaultIterations = 100000;
  static const _saltBytes = 16;
  static const _bits = 256;

  final int iterations;

  /// False in tests, where a spawned isolate can't finish under fake time.
  final bool inBackground;

  Future<PinHashModel> hash(String pin) async {
    final random = Random.secure();
    final salt = [for (var i = 0; i < _saltBytes; i++) random.nextInt(256)];
    return PinHashModel(
      iterations: iterations,
      salt: base64Encode(salt),
      hash: base64Encode(await _derive(pin, salt, iterations)),
    );
  }

  Future<bool> verify(String pin, PinHashModel stored) async {
    if (stored.algorithm != PinHashModel.pbkdf2Sha256) return false;
    final expected = base64Decode(stored.hash);
    final actual = await _derive(
      pin,
      base64Decode(stored.salt),
      stored.iterations,
    );
    return _constantTimeEquals(expected, actual);
  }

  Future<List<int>> _derive(String pin, List<int> salt, int iterations) {
    Future<List<int>> derive() async {
      final key = await Pbkdf2.hmacSha256(
        iterations: iterations,
        bits: _bits,
      ).deriveKeyFromPassword(password: pin, nonce: salt);
      return key.extractBytes();
    }

    return inBackground ? Isolate.run(derive) : derive();
  }

  /// Compares every byte, so timing doesn't reveal how much matched.
  static bool _constantTimeEquals(List<int> a, List<int> b) {
    if (a.length != b.length) return false;
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}

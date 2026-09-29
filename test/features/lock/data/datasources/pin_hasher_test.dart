import 'dart:convert';

import 'package:expense_tracker/features/lock/data/datasources/pin_hasher.dart';
import 'package:expense_tracker/features/lock/data/models/pin_hash_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const hasher = PinHasher(iterations: 1000, inBackground: false);

  test('the right PIN verifies, a wrong one does not', () async {
    final stored = await hasher.hash('2468');
    expect(await hasher.verify('2468', stored), isTrue);
    expect(await hasher.verify('2469', stored), isFalse);
    expect(await hasher.verify('24680', stored), isFalse);
    expect(await hasher.verify('', stored), isFalse);
  });

  test('salted: the same PIN never hashes the same twice', () async {
    final a = await hasher.hash('1234');
    final b = await hasher.hash('1234');
    expect(a.salt, isNot(b.salt));
    expect(a.hash, isNot(b.hash));
    expect(base64Decode(a.salt), hasLength(16));
    expect(base64Decode(a.hash), hasLength(32));
  });

  test('the stored iteration count is used, not the current one', () async {
    final old = await hasher.hash('1234');
    const stronger = PinHasher(iterations: 5000, inBackground: false);
    expect(old.iterations, 1000);
    expect(await stronger.verify('1234', old), isTrue);
  });

  test('an unknown algorithm never verifies', () async {
    final stored = await hasher.hash('1234');
    expect(
      await hasher.verify('1234', stored.copyWith(algorithm: 'md5')),
      isFalse,
    );
  });

  test('the PIN itself appears nowhere in the stored record', () async {
    final json = jsonEncode((await hasher.hash('135790')).toJson());
    expect(json, isNot(contains('135790')));
  });

  test('default strength and background derivation', () async {
    expect(PinHasher.defaultIterations, greaterThanOrEqualTo(100000));
    const real = PinHasher(iterations: 1000);
    final stored = await real.hash('1234');
    expect(await real.verify('1234', stored), isTrue, reason: 'in an isolate');
  });

  test('PinHashModel payload', () {
    const model = PinHashModel(
      iterations: 100000,
      salt: 'c2FsdA==',
      hash: 'aGFzaA==',
    );
    expect(model.toJson(), {
      'algorithm': 'pbkdf2-hmac-sha256',
      'iterations': 100000,
      'salt': 'c2FsdA==',
      'hash': 'aGFzaA==',
    });
    expect(PinHashModel.fromJson(model.toJson()), model);
  });
}

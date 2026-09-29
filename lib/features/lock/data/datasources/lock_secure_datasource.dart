import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Lock settings in Android's encrypted storage (Keystore-backed), outside
/// the database and its backups.
class LockSecureDataSource {
  const LockSecureDataSource(this._storage);

  final FlutterSecureStorage _storage;

  static const pinHash = 'lock.pin_hash';
  static const pinLength = 'lock.pin_length';
  static const biometric = 'lock.biometric';
  static const timeout = 'lock.timeout';
  static const failures = 'lock.failures';
  static const lastFailure = 'lock.last_failure';

  static const all = [
    pinHash,
    pinLength,
    biometric,
    timeout,
    failures,
    lastFailure,
  ];

  Future<String?> read(String key) => _storage.read(key: key);

  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  Future<void> delete(String key) => _storage.delete(key: key);
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// The backup password in Android's encrypted storage (Keystore-backed),
/// outside the database and its backups.
class BackupSecretDataSource {
  const BackupSecretDataSource(this._storage);

  final FlutterSecureStorage _storage;

  static const _password = 'backup.password';

  Future<String?> readPassword() => _storage.read(key: _password);

  Future<void> writePassword(String? password) => password == null
      ? _storage.delete(key: _password)
      : _storage.write(key: _password, value: password);
}

import 'dart:convert';
import 'dart:isolate';

import 'package:cryptography/cryptography.dart';
import 'package:expense_tracker/core/utils/key_derivation.dart';
import 'package:expense_tracker/features/backup/backup/data/models/encrypted_backup_dto.dart';

/// Encrypts and decrypts backup files (PRD BAK-03). Throws
/// [SecretBoxAuthenticationError] when the password is wrong or the file
/// was changed.
class BackupCipher {
  const BackupCipher({
    this.iterations = defaultIterations,
    this.inBackground = true,
  });

  /// PBKDF2 rounds for new files; stored per file.
  static const defaultIterations = 200000;
  static const _saltBytes = 16;

  final int iterations;

  /// False in tests, where a spawned isolate can't finish under fake time.
  final bool inBackground;

  static final _aes = AesGcm.with256bits();

  Future<SecretKey> _key(
    String password,
    List<int> salt,
    int iterations,
  ) async => SecretKey(
    await pbkdf2Sha256(
      password: password,
      salt: salt,
      iterations: iterations,
      inBackground: inBackground,
    ),
  );

  Future<T> _run<T>(Future<T> Function() body) =>
      inBackground ? Isolate.run(body) : body();

  Future<EncryptedBackupDto> encrypt(String plain, String password) async {
    final salt = secureRandomBytes(_saltBytes);
    final key = await _key(password, salt, iterations);
    final keyBytes = await key.extractBytes();
    final header = EncryptedBackupDto(
      iterations: iterations,
      salt: base64Encode(salt),
      nonce: '',
      ciphertext: '',
      mac: '',
    );
    final aad = utf8.encode(header.associatedData);
    final box = await _run(
      () => _aes.encrypt(
        utf8.encode(plain),
        secretKey: SecretKey(keyBytes),
        aad: aad,
      ),
    );
    return header.copyWith(
      nonce: base64Encode(box.nonce),
      ciphertext: base64Encode(box.cipherText),
      mac: base64Encode(box.mac.bytes),
    );
  }

  Future<String> decrypt(EncryptedBackupDto file, String password) async {
    final key = await _key(password, base64Decode(file.salt), file.iterations);
    final keyBytes = await key.extractBytes();
    final box = SecretBox(
      base64Decode(file.ciphertext),
      nonce: base64Decode(file.nonce),
      mac: Mac(base64Decode(file.mac)),
    );
    final aad = utf8.encode(file.associatedData);
    final plain = await _run(
      () => _aes.decrypt(box, secretKey: SecretKey(keyBytes), aad: aad),
    );
    return utf8.decode(plain);
  }
}

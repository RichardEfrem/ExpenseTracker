import 'dart:convert';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_cipher.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/models/encrypted_backup_dto.dart';
import 'package:expense_tracker/features/backup/backup/data/repositories/backup_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  late AppDatabase db;
  late BackupRepositoryImpl repo;
  const password = 'correct horse';
  // Few rounds and no isolate: fast and deterministic under test.
  const cipher = BackupCipher(iterations: 1000, inBackground: false);

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = BackupRepositoryImpl(
      BackupLocalDataSource(db),
      const BackupFileDataSource(),
      FixedClock(DateTime.utc(2026, 9, 29)),
      cipher: cipher,
    );
  });
  tearDown(() => db.close());

  Future<String> plainBackup() async {
    final file = (await repo.snapshot(
      appVersion: '1.0.0 (1)',
    )).getOrElse((f) => fail('$f'));
    return repo.encode(file).getOrElse((f) => fail('$f'));
  }

  Future<String> encrypted(String plain) async =>
      (await repo.encrypt(plain, password)).getOrElse((f) => fail('$f'));

  Failure? decryptFailure(Either<Failure, String> result) =>
      result.getLeft().toNullable();

  /// Changes one field of an encrypted file's envelope.
  String tamper(String contents, String key, Object? Function(Object?) edit) {
    final json = jsonDecode(contents) as Map<String, dynamic>;
    json[key] = edit(json[key]);
    return jsonEncode(json);
  }

  /// Flips the first byte of a base64 field.
  String flipFirstByte(Object? base64) {
    final bytes = base64Decode(base64! as String);
    bytes[0] ^= 0x01;
    return base64Encode(bytes);
  }

  test('round-trip: decrypts to exactly the plain backup', () async {
    final plain = await plainBackup();
    final locked = await encrypted(plain);
    expect(locked, isNot(contains('Cash')), reason: 'no plaintext inside');
    expect(repo.isEncrypted(locked), isTrue);
    expect(repo.isEncrypted(plain), isFalse);
    expect(
      (await repo.decrypt(locked, password)).getOrElse((f) => fail('$f')),
      plain,
    );
  });

  test('each export uses a fresh salt and nonce', () async {
    final plain = await plainBackup();
    final a = jsonDecode(await encrypted(plain)) as Map<String, dynamic>;
    final b = jsonDecode(await encrypted(plain)) as Map<String, dynamic>;
    expect(a['salt'], isNot(b['salt']));
    expect(a['nonce'], isNot(b['nonce']));
  });

  test('wrong password → BackupFailure(wrongPassword)', () async {
    final locked = await encrypted(await plainBackup());
    expect(
      decryptFailure(await repo.decrypt(locked, 'wrong password')),
      const Failure.backup(BackupProblem.wrongPassword),
    );
  });

  group('a changed file is detected', () {
    for (final (field, edit) in <(String, Object? Function(Object?))>[
      ('ciphertext', (v) => flipFirstByte(v)),
      ('mac', (v) => flipFirstByte(v)),
      ('nonce', (v) => flipFirstByte(v)),
      // Header fields are authenticated too (GCM associated data).
      ('salt', (v) => flipFirstByte(v)),
    ]) {
      test(field, () async {
        final locked = await encrypted(await plainBackup());
        final result = await repo.decrypt(
          tamper(locked, field, edit),
          password,
        );
        expect(
          decryptFailure(result),
          const Failure.backup(BackupProblem.wrongPassword),
        );
      });
    }

    test('iterations (derives another key)', () async {
      final locked = await encrypted(await plainBackup());
      final result = await repo.decrypt(
        tamper(locked, 'iterations', (v) => (v! as int) + 1),
        password,
      );
      expect(
        decryptFailure(result),
        const Failure.backup(BackupProblem.wrongPassword),
      );
    });
  });

  test('broken envelope → corrupt file', () async {
    final locked = await encrypted(await plainBackup());
    for (final broken in [
      tamper(locked, 'ciphertext', (_) => '%%% not base64'),
      tamper(locked, 'salt', (_) => null),
      tamper(locked, 'kdf', (_) => 'argon2id'),
    ]) {
      final failure = decryptFailure(await repo.decrypt(broken, password));
      expect(failure, isA<BackupFailure>());
      expect(
        (failure! as BackupFailure).problem,
        BackupProblem.corruptFile,
        reason: broken,
      );
    }
  });

  test('a newer envelope version is unsupported', () async {
    final locked = await encrypted(await plainBackup());
    final failure = decryptFailure(
      await repo.decrypt(
        tamper(locked, 'version', (_) => EncryptedBackupDto.currentVersion + 1),
        password,
      ),
    );
    expect(
      (failure! as BackupFailure).problem,
      BackupProblem.unsupportedVersion,
    );
  });

  test('decoding an encrypted file directly is rejected', () async {
    final locked = await encrypted(await plainBackup());
    expect(repo.decode(locked).isLeft(), isTrue);
  });
}

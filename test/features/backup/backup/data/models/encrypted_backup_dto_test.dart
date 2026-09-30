import 'package:expense_tracker/features/backup/backup/data/models/encrypted_backup_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const dto = EncryptedBackupDto(
    iterations: 200000,
    salt: 'c2FsdA==',
    nonce: 'bm9uY2U=',
    ciphertext: 'Y2lwaGVy',
    mac: 'bWFj',
  );

  test('payload: every field written, snake_case, defaults pinned', () {
    expect(dto.toJson(), {
      'format': 'expense_tracker_backup_encrypted',
      'version': 1,
      'kdf': 'pbkdf2-hmac-sha256',
      'iterations': 200000,
      'salt': 'c2FsdA==',
      'cipher': 'aes-256-gcm',
      'nonce': 'bm9uY2U=',
      'ciphertext': 'Y2lwaGVy',
      'mac': 'bWFj',
    });
  });

  test('round-trips through JSON', () {
    expect(EncryptedBackupDto.fromJson(dto.toJson()), dto);
  });

  test('associated data covers the header, not the sealed parts', () {
    expect(
      dto.associatedData,
      'expense_tracker_backup_encrypted|1|pbkdf2-hmac-sha256|200000|'
      'c2FsdA==|aes-256-gcm',
    );
  });
}

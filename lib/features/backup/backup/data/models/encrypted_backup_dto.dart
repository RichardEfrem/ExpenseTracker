import 'package:freezed_annotation/freezed_annotation.dart';

part 'encrypted_backup_dto.freezed.dart';
part 'encrypted_backup_dto.g.dart';

/// Marks a file as an encrypted backup of ours (PRD BAK-03).
const encryptedBackupFormat = 'expense_tracker_backup_encrypted';

/// An encrypted backup file: the plain backup JSON sealed with AES-256-GCM
/// under a key derived from the password with PBKDF2-HMAC-SHA256. The KDF
/// parameters travel with the file so they can change later. The header
/// fields are authenticated too (GCM associated data), so changing any of
/// them is detected like a changed ciphertext.
@freezed
abstract class EncryptedBackupDto with _$EncryptedBackupDto {
  const factory EncryptedBackupDto({
    @Default(encryptedBackupFormat) String format,
    @Default(EncryptedBackupDto.currentVersion) int version,
    @Default(EncryptedBackupDto.pbkdf2Sha256) String kdf,
    required int iterations,

    /// Base64.
    required String salt,
    @Default(EncryptedBackupDto.aes256Gcm) String cipher,

    /// Base64, 12 bytes.
    required String nonce,

    /// Base64.
    required String ciphertext,

    /// Base64, the 16-byte GCM tag.
    required String mac,
  }) = _EncryptedBackupDto;

  const EncryptedBackupDto._();

  factory EncryptedBackupDto.fromJson(Map<String, dynamic> json) =>
      _$EncryptedBackupDtoFromJson(json);

  static const currentVersion = 1;
  static const pbkdf2Sha256 = 'pbkdf2-hmac-sha256';
  static const aes256Gcm = 'aes-256-gcm';

  /// What the tag also covers, besides the ciphertext.
  String get associatedData =>
      '$format|$version|$kdf|$iterations|$salt|$cipher';
}

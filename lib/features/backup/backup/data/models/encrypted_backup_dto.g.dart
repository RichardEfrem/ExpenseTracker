// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encrypted_backup_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_EncryptedBackupDto _$EncryptedBackupDtoFromJson(Map<String, dynamic> json) =>
    _EncryptedBackupDto(
      format: json['format'] as String? ?? encryptedBackupFormat,
      version:
          (json['version'] as num?)?.toInt() ??
          EncryptedBackupDto.currentVersion,
      kdf: json['kdf'] as String? ?? EncryptedBackupDto.pbkdf2Sha256,
      iterations: (json['iterations'] as num).toInt(),
      salt: json['salt'] as String,
      cipher: json['cipher'] as String? ?? EncryptedBackupDto.aes256Gcm,
      nonce: json['nonce'] as String,
      ciphertext: json['ciphertext'] as String,
      mac: json['mac'] as String,
    );

Map<String, dynamic> _$EncryptedBackupDtoToJson(_EncryptedBackupDto instance) =>
    <String, dynamic>{
      'format': instance.format,
      'version': instance.version,
      'kdf': instance.kdf,
      'iterations': instance.iterations,
      'salt': instance.salt,
      'cipher': instance.cipher,
      'nonce': instance.nonce,
      'ciphertext': instance.ciphertext,
      'mac': instance.mac,
    };

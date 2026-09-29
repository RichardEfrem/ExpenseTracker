// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_hash_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PinHashModel _$PinHashModelFromJson(Map<String, dynamic> json) =>
    _PinHashModel(
      algorithm: json['algorithm'] as String? ?? PinHashModel.pbkdf2Sha256,
      iterations: (json['iterations'] as num).toInt(),
      salt: json['salt'] as String,
      hash: json['hash'] as String,
    );

Map<String, dynamic> _$PinHashModelToJson(_PinHashModel instance) =>
    <String, dynamic>{
      'algorithm': instance.algorithm,
      'iterations': instance.iterations,
      'salt': instance.salt,
      'hash': instance.hash,
    };

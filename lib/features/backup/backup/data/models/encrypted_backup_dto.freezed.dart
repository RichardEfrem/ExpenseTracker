// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'encrypted_backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EncryptedBackupDto {

 String get format; int get version; String get kdf; int get iterations;/// Base64.
 String get salt; String get cipher;/// Base64, 12 bytes.
 String get nonce;/// Base64.
 String get ciphertext;/// Base64, the 16-byte GCM tag.
 String get mac;
/// Create a copy of EncryptedBackupDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EncryptedBackupDtoCopyWith<EncryptedBackupDto> get copyWith => _$EncryptedBackupDtoCopyWithImpl<EncryptedBackupDto>(this as EncryptedBackupDto, _$identity);

  /// Serializes this EncryptedBackupDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EncryptedBackupDto&&(identical(other.format, format) || other.format == format)&&(identical(other.version, version) || other.version == version)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.cipher, cipher) || other.cipher == cipher)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.mac, mac) || other.mac == mac));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,version,kdf,iterations,salt,cipher,nonce,ciphertext,mac);

@override
String toString() {
  return 'EncryptedBackupDto(format: $format, version: $version, kdf: $kdf, iterations: $iterations, salt: $salt, cipher: $cipher, nonce: $nonce, ciphertext: $ciphertext, mac: $mac)';
}


}

/// @nodoc
abstract mixin class $EncryptedBackupDtoCopyWith<$Res>  {
  factory $EncryptedBackupDtoCopyWith(EncryptedBackupDto value, $Res Function(EncryptedBackupDto) _then) = _$EncryptedBackupDtoCopyWithImpl;
@useResult
$Res call({
 String format, int version, String kdf, int iterations, String salt, String cipher, String nonce, String ciphertext, String mac
});




}
/// @nodoc
class _$EncryptedBackupDtoCopyWithImpl<$Res>
    implements $EncryptedBackupDtoCopyWith<$Res> {
  _$EncryptedBackupDtoCopyWithImpl(this._self, this._then);

  final EncryptedBackupDto _self;
  final $Res Function(EncryptedBackupDto) _then;

/// Create a copy of EncryptedBackupDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? version = null,Object? kdf = null,Object? iterations = null,Object? salt = null,Object? cipher = null,Object? nonce = null,Object? ciphertext = null,Object? mac = null,}) {
  return _then(EncryptedBackupDto(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as String,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,cipher: null == cipher ? _self.cipher : cipher // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EncryptedBackupDto].
extension EncryptedBackupDtoPatterns on EncryptedBackupDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EncryptedBackupDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EncryptedBackupDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EncryptedBackupDto value)  $default,){
final _that = this;
switch (_that) {
case _EncryptedBackupDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EncryptedBackupDto value)?  $default,){
final _that = this;
switch (_that) {
case _EncryptedBackupDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String format,  int version,  String kdf,  int iterations,  String salt,  String cipher,  String nonce,  String ciphertext,  String mac)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EncryptedBackupDto() when $default != null:
return $default(_that.format,_that.version,_that.kdf,_that.iterations,_that.salt,_that.cipher,_that.nonce,_that.ciphertext,_that.mac);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String format,  int version,  String kdf,  int iterations,  String salt,  String cipher,  String nonce,  String ciphertext,  String mac)  $default,) {final _that = this;
switch (_that) {
case _EncryptedBackupDto():
return $default(_that.format,_that.version,_that.kdf,_that.iterations,_that.salt,_that.cipher,_that.nonce,_that.ciphertext,_that.mac);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String format,  int version,  String kdf,  int iterations,  String salt,  String cipher,  String nonce,  String ciphertext,  String mac)?  $default,) {final _that = this;
switch (_that) {
case _EncryptedBackupDto() when $default != null:
return $default(_that.format,_that.version,_that.kdf,_that.iterations,_that.salt,_that.cipher,_that.nonce,_that.ciphertext,_that.mac);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EncryptedBackupDto extends EncryptedBackupDto {
  const _EncryptedBackupDto({this.format = encryptedBackupFormat, this.version = EncryptedBackupDto.currentVersion, this.kdf = EncryptedBackupDto.pbkdf2Sha256, required this.iterations, required this.salt, this.cipher = EncryptedBackupDto.aes256Gcm, required this.nonce, required this.ciphertext, required this.mac}): super._();
  factory _EncryptedBackupDto.fromJson(Map<String, dynamic> json) => _$EncryptedBackupDtoFromJson(json);

@override@JsonKey() final  String format;
@override@JsonKey() final  int version;
@override@JsonKey() final  String kdf;
@override final  int iterations;
/// Base64.
@override final  String salt;
@override@JsonKey() final  String cipher;
/// Base64, 12 bytes.
@override final  String nonce;
/// Base64.
@override final  String ciphertext;
/// Base64, the 16-byte GCM tag.
@override final  String mac;

/// Create a copy of EncryptedBackupDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EncryptedBackupDtoCopyWith<_EncryptedBackupDto> get copyWith => __$EncryptedBackupDtoCopyWithImpl<_EncryptedBackupDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EncryptedBackupDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EncryptedBackupDto&&(identical(other.format, format) || other.format == format)&&(identical(other.version, version) || other.version == version)&&(identical(other.kdf, kdf) || other.kdf == kdf)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.cipher, cipher) || other.cipher == cipher)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.mac, mac) || other.mac == mac));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,version,kdf,iterations,salt,cipher,nonce,ciphertext,mac);

@override
String toString() {
  return 'EncryptedBackupDto(format: $format, version: $version, kdf: $kdf, iterations: $iterations, salt: $salt, cipher: $cipher, nonce: $nonce, ciphertext: $ciphertext, mac: $mac)';
}


}

/// @nodoc
abstract mixin class _$EncryptedBackupDtoCopyWith<$Res> implements $EncryptedBackupDtoCopyWith<$Res> {
  factory _$EncryptedBackupDtoCopyWith(_EncryptedBackupDto value, $Res Function(_EncryptedBackupDto) _then) = __$EncryptedBackupDtoCopyWithImpl;
@override @useResult
$Res call({
 String format, int version, String kdf, int iterations, String salt, String cipher, String nonce, String ciphertext, String mac
});




}
/// @nodoc
class __$EncryptedBackupDtoCopyWithImpl<$Res>
    implements _$EncryptedBackupDtoCopyWith<$Res> {
  __$EncryptedBackupDtoCopyWithImpl(this._self, this._then);

  final _EncryptedBackupDto _self;
  final $Res Function(_EncryptedBackupDto) _then;

/// Create a copy of EncryptedBackupDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? version = null,Object? kdf = null,Object? iterations = null,Object? salt = null,Object? cipher = null,Object? nonce = null,Object? ciphertext = null,Object? mac = null,}) {
  return _then(_EncryptedBackupDto(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as int,kdf: null == kdf ? _self.kdf : kdf // ignore: cast_nullable_to_non_nullable
as String,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,cipher: null == cipher ? _self.cipher : cipher // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,mac: null == mac ? _self.mac : mac // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

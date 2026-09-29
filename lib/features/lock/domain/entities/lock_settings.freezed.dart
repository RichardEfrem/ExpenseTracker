// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lock_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LockSettings {

/// A PIN is set, so the app locks.
 bool get enabled;/// Digits in the PIN (4–6), for the dots; 0 while off.
 int get pinLength;/// Fingerprint/face may unlock instead of the PIN.
 bool get biometric; LockTimeout get timeout;
/// Create a copy of LockSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockSettingsCopyWith<LockSettings> get copyWith => _$LockSettingsCopyWithImpl<LockSettings>(this as LockSettings, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.pinLength, pinLength) || other.pinLength == pinLength)&&(identical(other.biometric, biometric) || other.biometric == biometric)&&(identical(other.timeout, timeout) || other.timeout == timeout));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,pinLength,biometric,timeout);

@override
String toString() {
  return 'LockSettings(enabled: $enabled, pinLength: $pinLength, biometric: $biometric, timeout: $timeout)';
}


}

/// @nodoc
abstract mixin class $LockSettingsCopyWith<$Res>  {
  factory $LockSettingsCopyWith(LockSettings value, $Res Function(LockSettings) _then) = _$LockSettingsCopyWithImpl;
@useResult
$Res call({
 bool enabled, int pinLength, bool biometric, LockTimeout timeout
});




}
/// @nodoc
class _$LockSettingsCopyWithImpl<$Res>
    implements $LockSettingsCopyWith<$Res> {
  _$LockSettingsCopyWithImpl(this._self, this._then);

  final LockSettings _self;
  final $Res Function(LockSettings) _then;

/// Create a copy of LockSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? enabled = null,Object? pinLength = null,Object? biometric = null,Object? timeout = null,}) {
  return _then(LockSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,pinLength: null == pinLength ? _self.pinLength : pinLength // ignore: cast_nullable_to_non_nullable
as int,biometric: null == biometric ? _self.biometric : biometric // ignore: cast_nullable_to_non_nullable
as bool,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as LockTimeout,
  ));
}

}


/// Adds pattern-matching-related methods to [LockSettings].
extension LockSettingsPatterns on LockSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LockSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LockSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LockSettings value)  $default,){
final _that = this;
switch (_that) {
case _LockSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LockSettings value)?  $default,){
final _that = this;
switch (_that) {
case _LockSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool enabled,  int pinLength,  bool biometric,  LockTimeout timeout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LockSettings() when $default != null:
return $default(_that.enabled,_that.pinLength,_that.biometric,_that.timeout);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool enabled,  int pinLength,  bool biometric,  LockTimeout timeout)  $default,) {final _that = this;
switch (_that) {
case _LockSettings():
return $default(_that.enabled,_that.pinLength,_that.biometric,_that.timeout);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool enabled,  int pinLength,  bool biometric,  LockTimeout timeout)?  $default,) {final _that = this;
switch (_that) {
case _LockSettings() when $default != null:
return $default(_that.enabled,_that.pinLength,_that.biometric,_that.timeout);case _:
  return null;

}
}

}

/// @nodoc


class _LockSettings extends LockSettings {
  const _LockSettings({this.enabled = false, this.pinLength = 0, this.biometric = false, this.timeout = LockTimeout.minute1}): super._();
  

/// A PIN is set, so the app locks.
@override@JsonKey() final  bool enabled;
/// Digits in the PIN (4–6), for the dots; 0 while off.
@override@JsonKey() final  int pinLength;
/// Fingerprint/face may unlock instead of the PIN.
@override@JsonKey() final  bool biometric;
@override@JsonKey() final  LockTimeout timeout;

/// Create a copy of LockSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockSettingsCopyWith<_LockSettings> get copyWith => __$LockSettingsCopyWithImpl<_LockSettings>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockSettings&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.pinLength, pinLength) || other.pinLength == pinLength)&&(identical(other.biometric, biometric) || other.biometric == biometric)&&(identical(other.timeout, timeout) || other.timeout == timeout));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,pinLength,biometric,timeout);

@override
String toString() {
  return 'LockSettings(enabled: $enabled, pinLength: $pinLength, biometric: $biometric, timeout: $timeout)';
}


}

/// @nodoc
abstract mixin class _$LockSettingsCopyWith<$Res> implements $LockSettingsCopyWith<$Res> {
  factory _$LockSettingsCopyWith(_LockSettings value, $Res Function(_LockSettings) _then) = __$LockSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool enabled, int pinLength, bool biometric, LockTimeout timeout
});




}
/// @nodoc
class __$LockSettingsCopyWithImpl<$Res>
    implements _$LockSettingsCopyWith<$Res> {
  __$LockSettingsCopyWithImpl(this._self, this._then);

  final _LockSettings _self;
  final $Res Function(_LockSettings) _then;

/// Create a copy of LockSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? pinLength = null,Object? biometric = null,Object? timeout = null,}) {
  return _then(_LockSettings(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,pinLength: null == pinLength ? _self.pinLength : pinLength // ignore: cast_nullable_to_non_nullable
as int,biometric: null == biometric ? _self.biometric : biometric // ignore: cast_nullable_to_non_nullable
as bool,timeout: null == timeout ? _self.timeout : timeout // ignore: cast_nullable_to_non_nullable
as LockTimeout,
  ));
}


}

// dart format on

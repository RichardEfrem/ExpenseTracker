// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountInput {

 String get name; AccountType get type; String get icon; PaletteColor get color;/// Balance before the first recorded transaction; may be negative.
 int get openingBalance;
/// Create a copy of AccountInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountInputCopyWith<AccountInput> get copyWith => _$AccountInputCopyWithImpl<AccountInput>(this as AccountInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountInput&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,icon,color,openingBalance);

@override
String toString() {
  return 'AccountInput(name: $name, type: $type, icon: $icon, color: $color, openingBalance: $openingBalance)';
}


}

/// @nodoc
abstract mixin class $AccountInputCopyWith<$Res>  {
  factory $AccountInputCopyWith(AccountInput value, $Res Function(AccountInput) _then) = _$AccountInputCopyWithImpl;
@useResult
$Res call({
 String name, AccountType type, String icon, PaletteColor color, int openingBalance
});




}
/// @nodoc
class _$AccountInputCopyWithImpl<$Res>
    implements $AccountInputCopyWith<$Res> {
  _$AccountInputCopyWithImpl(this._self, this._then);

  final AccountInput _self;
  final $Res Function(AccountInput) _then;

/// Create a copy of AccountInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? openingBalance = null,}) {
  return _then(AccountInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as PaletteColor,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountInput].
extension AccountInputPatterns on AccountInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountInput value)  $default,){
final _that = this;
switch (_that) {
case _AccountInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountInput value)?  $default,){
final _that = this;
switch (_that) {
case _AccountInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  AccountType type,  String icon,  PaletteColor color,  int openingBalance)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountInput() when $default != null:
return $default(_that.name,_that.type,_that.icon,_that.color,_that.openingBalance);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  AccountType type,  String icon,  PaletteColor color,  int openingBalance)  $default,) {final _that = this;
switch (_that) {
case _AccountInput():
return $default(_that.name,_that.type,_that.icon,_that.color,_that.openingBalance);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  AccountType type,  String icon,  PaletteColor color,  int openingBalance)?  $default,) {final _that = this;
switch (_that) {
case _AccountInput() when $default != null:
return $default(_that.name,_that.type,_that.icon,_that.color,_that.openingBalance);case _:
  return null;

}
}

}

/// @nodoc


class _AccountInput extends AccountInput {
  const _AccountInput({required this.name, required this.type, required this.icon, required this.color, this.openingBalance = 0}): super._();
  

@override final  String name;
@override final  AccountType type;
@override final  String icon;
@override final  PaletteColor color;
/// Balance before the first recorded transaction; may be negative.
@override@JsonKey() final  int openingBalance;

/// Create a copy of AccountInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountInputCopyWith<_AccountInput> get copyWith => __$AccountInputCopyWithImpl<_AccountInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountInput&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance));
}


@override
int get hashCode => Object.hash(runtimeType,name,type,icon,color,openingBalance);

@override
String toString() {
  return 'AccountInput(name: $name, type: $type, icon: $icon, color: $color, openingBalance: $openingBalance)';
}


}

/// @nodoc
abstract mixin class _$AccountInputCopyWith<$Res> implements $AccountInputCopyWith<$Res> {
  factory _$AccountInputCopyWith(_AccountInput value, $Res Function(_AccountInput) _then) = __$AccountInputCopyWithImpl;
@override @useResult
$Res call({
 String name, AccountType type, String icon, PaletteColor color, int openingBalance
});




}
/// @nodoc
class __$AccountInputCopyWithImpl<$Res>
    implements _$AccountInputCopyWith<$Res> {
  __$AccountInputCopyWithImpl(this._self, this._then);

  final _AccountInput _self;
  final $Res Function(_AccountInput) _then;

/// Create a copy of AccountInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? openingBalance = null,}) {
  return _then(_AccountInput(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as AccountType,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as PaletteColor,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

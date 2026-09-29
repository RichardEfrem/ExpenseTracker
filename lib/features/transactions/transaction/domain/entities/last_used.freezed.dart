// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_used.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LastUsed {

 String? get categoryId; String? get accountId;
/// Create a copy of LastUsed
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LastUsedCopyWith<LastUsed> get copyWith => _$LastUsedCopyWithImpl<LastUsed>(this as LastUsed, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LastUsed&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,accountId);

@override
String toString() {
  return 'LastUsed(categoryId: $categoryId, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class $LastUsedCopyWith<$Res>  {
  factory $LastUsedCopyWith(LastUsed value, $Res Function(LastUsed) _then) = _$LastUsedCopyWithImpl;
@useResult
$Res call({
 String? categoryId, String? accountId
});




}
/// @nodoc
class _$LastUsedCopyWithImpl<$Res>
    implements $LastUsedCopyWith<$Res> {
  _$LastUsedCopyWithImpl(this._self, this._then);

  final LastUsed _self;
  final $Res Function(LastUsed) _then;

/// Create a copy of LastUsed
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? categoryId = freezed,Object? accountId = freezed,}) {
  return _then(LastUsed(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LastUsed].
extension LastUsedPatterns on LastUsed {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LastUsed value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LastUsed() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LastUsed value)  $default,){
final _that = this;
switch (_that) {
case _LastUsed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LastUsed value)?  $default,){
final _that = this;
switch (_that) {
case _LastUsed() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? categoryId,  String? accountId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LastUsed() when $default != null:
return $default(_that.categoryId,_that.accountId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? categoryId,  String? accountId)  $default,) {final _that = this;
switch (_that) {
case _LastUsed():
return $default(_that.categoryId,_that.accountId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? categoryId,  String? accountId)?  $default,) {final _that = this;
switch (_that) {
case _LastUsed() when $default != null:
return $default(_that.categoryId,_that.accountId);case _:
  return null;

}
}

}

/// @nodoc


class _LastUsed implements LastUsed {
  const _LastUsed({this.categoryId, this.accountId});
  

@override final  String? categoryId;
@override final  String? accountId;

/// Create a copy of LastUsed
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LastUsedCopyWith<_LastUsed> get copyWith => __$LastUsedCopyWithImpl<_LastUsed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LastUsed&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId));
}


@override
int get hashCode => Object.hash(runtimeType,categoryId,accountId);

@override
String toString() {
  return 'LastUsed(categoryId: $categoryId, accountId: $accountId)';
}


}

/// @nodoc
abstract mixin class _$LastUsedCopyWith<$Res> implements $LastUsedCopyWith<$Res> {
  factory _$LastUsedCopyWith(_LastUsed value, $Res Function(_LastUsed) _then) = __$LastUsedCopyWithImpl;
@override @useResult
$Res call({
 String? categoryId, String? accountId
});




}
/// @nodoc
class __$LastUsedCopyWithImpl<$Res>
    implements _$LastUsedCopyWith<$Res> {
  __$LastUsedCopyWithImpl(this._self, this._then);

  final _LastUsed _self;
  final $Res Function(_LastUsed) _then;

/// Create a copy of LastUsed
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? categoryId = freezed,Object? accountId = freezed,}) {
  return _then(_LastUsed(
categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: freezed == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

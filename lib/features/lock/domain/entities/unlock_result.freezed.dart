// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'unlock_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UnlockResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UnlockResult()';
}


}

/// @nodoc
class $UnlockResultCopyWith<$Res>  {
$UnlockResultCopyWith(UnlockResult _, $Res Function(UnlockResult) __);
}


/// Adds pattern-matching-related methods to [UnlockResult].
extension UnlockResultPatterns on UnlockResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( UnlockSuccess value)?  success,TResult Function( UnlockWrongPin value)?  wrongPin,TResult Function( UnlockThrottled value)?  throttled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case UnlockSuccess() when success != null:
return success(_that);case UnlockWrongPin() when wrongPin != null:
return wrongPin(_that);case UnlockThrottled() when throttled != null:
return throttled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( UnlockSuccess value)  success,required TResult Function( UnlockWrongPin value)  wrongPin,required TResult Function( UnlockThrottled value)  throttled,}){
final _that = this;
switch (_that) {
case UnlockSuccess():
return success(_that);case UnlockWrongPin():
return wrongPin(_that);case UnlockThrottled():
return throttled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( UnlockSuccess value)?  success,TResult? Function( UnlockWrongPin value)?  wrongPin,TResult? Function( UnlockThrottled value)?  throttled,}){
final _that = this;
switch (_that) {
case UnlockSuccess() when success != null:
return success(_that);case UnlockWrongPin() when wrongPin != null:
return wrongPin(_that);case UnlockThrottled() when throttled != null:
return throttled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  success,TResult Function( int triesLeft)?  wrongPin,TResult Function( DateTime retryAt)?  throttled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case UnlockSuccess() when success != null:
return success();case UnlockWrongPin() when wrongPin != null:
return wrongPin(_that.triesLeft);case UnlockThrottled() when throttled != null:
return throttled(_that.retryAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  success,required TResult Function( int triesLeft)  wrongPin,required TResult Function( DateTime retryAt)  throttled,}) {final _that = this;
switch (_that) {
case UnlockSuccess():
return success();case UnlockWrongPin():
return wrongPin(_that.triesLeft);case UnlockThrottled():
return throttled(_that.retryAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  success,TResult? Function( int triesLeft)?  wrongPin,TResult? Function( DateTime retryAt)?  throttled,}) {final _that = this;
switch (_that) {
case UnlockSuccess() when success != null:
return success();case UnlockWrongPin() when wrongPin != null:
return wrongPin(_that.triesLeft);case UnlockThrottled() when throttled != null:
return throttled(_that.retryAt);case _:
  return null;

}
}

}

/// @nodoc


class UnlockSuccess implements UnlockResult {
  const UnlockSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UnlockResult.success()';
}


}




/// @nodoc


class UnlockWrongPin implements UnlockResult {
  const UnlockWrongPin({required this.triesLeft});
  

 final  int triesLeft;

/// Create a copy of UnlockResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockWrongPinCopyWith<UnlockWrongPin> get copyWith => _$UnlockWrongPinCopyWithImpl<UnlockWrongPin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockWrongPin&&(identical(other.triesLeft, triesLeft) || other.triesLeft == triesLeft));
}


@override
int get hashCode => Object.hash(runtimeType,triesLeft);

@override
String toString() {
  return 'UnlockResult.wrongPin(triesLeft: $triesLeft)';
}


}

/// @nodoc
abstract mixin class $UnlockWrongPinCopyWith<$Res> implements $UnlockResultCopyWith<$Res> {
  factory $UnlockWrongPinCopyWith(UnlockWrongPin value, $Res Function(UnlockWrongPin) _then) = _$UnlockWrongPinCopyWithImpl;
@useResult
$Res call({
 int triesLeft
});




}
/// @nodoc
class _$UnlockWrongPinCopyWithImpl<$Res>
    implements $UnlockWrongPinCopyWith<$Res> {
  _$UnlockWrongPinCopyWithImpl(this._self, this._then);

  final UnlockWrongPin _self;
  final $Res Function(UnlockWrongPin) _then;

/// Create a copy of UnlockResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? triesLeft = null,}) {
  return _then(UnlockWrongPin(
triesLeft: null == triesLeft ? _self.triesLeft : triesLeft // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class UnlockThrottled implements UnlockResult {
  const UnlockThrottled({required this.retryAt});
  

 final  DateTime retryAt;

/// Create a copy of UnlockResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnlockThrottledCopyWith<UnlockThrottled> get copyWith => _$UnlockThrottledCopyWithImpl<UnlockThrottled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnlockThrottled&&(identical(other.retryAt, retryAt) || other.retryAt == retryAt));
}


@override
int get hashCode => Object.hash(runtimeType,retryAt);

@override
String toString() {
  return 'UnlockResult.throttled(retryAt: $retryAt)';
}


}

/// @nodoc
abstract mixin class $UnlockThrottledCopyWith<$Res> implements $UnlockResultCopyWith<$Res> {
  factory $UnlockThrottledCopyWith(UnlockThrottled value, $Res Function(UnlockThrottled) _then) = _$UnlockThrottledCopyWithImpl;
@useResult
$Res call({
 DateTime retryAt
});




}
/// @nodoc
class _$UnlockThrottledCopyWithImpl<$Res>
    implements $UnlockThrottledCopyWith<$Res> {
  _$UnlockThrottledCopyWithImpl(this._self, this._then);

  final UnlockThrottled _self;
  final $Res Function(UnlockThrottled) _then;

/// Create a copy of UnlockResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? retryAt = null,}) {
  return _then(UnlockThrottled(
retryAt: null == retryAt ? _self.retryAt : retryAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingInput {

/// Default categories to remove. Unused ones are deleted; any already in
/// use are archived instead.
 Set<String> get removedCategoryIds;/// Opening balance of the Cash account, in rupiah.
 int get openingCash;
/// Create a copy of OnboardingInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingInputCopyWith<OnboardingInput> get copyWith => _$OnboardingInputCopyWithImpl<OnboardingInput>(this as OnboardingInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingInput&&const DeepCollectionEquality().equals(other.removedCategoryIds, removedCategoryIds)&&(identical(other.openingCash, openingCash) || other.openingCash == openingCash));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(removedCategoryIds),openingCash);

@override
String toString() {
  return 'OnboardingInput(removedCategoryIds: $removedCategoryIds, openingCash: $openingCash)';
}


}

/// @nodoc
abstract mixin class $OnboardingInputCopyWith<$Res>  {
  factory $OnboardingInputCopyWith(OnboardingInput value, $Res Function(OnboardingInput) _then) = _$OnboardingInputCopyWithImpl;
@useResult
$Res call({
 Set<String> removedCategoryIds, int openingCash
});




}
/// @nodoc
class _$OnboardingInputCopyWithImpl<$Res>
    implements $OnboardingInputCopyWith<$Res> {
  _$OnboardingInputCopyWithImpl(this._self, this._then);

  final OnboardingInput _self;
  final $Res Function(OnboardingInput) _then;

/// Create a copy of OnboardingInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? removedCategoryIds = null,Object? openingCash = null,}) {
  return _then(OnboardingInput(
removedCategoryIds: null == removedCategoryIds ? _self.removedCategoryIds : removedCategoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,openingCash: null == openingCash ? _self.openingCash : openingCash // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingInput].
extension OnboardingInputPatterns on OnboardingInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingInput value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingInput value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Set<String> removedCategoryIds,  int openingCash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingInput() when $default != null:
return $default(_that.removedCategoryIds,_that.openingCash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Set<String> removedCategoryIds,  int openingCash)  $default,) {final _that = this;
switch (_that) {
case _OnboardingInput():
return $default(_that.removedCategoryIds,_that.openingCash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Set<String> removedCategoryIds,  int openingCash)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingInput() when $default != null:
return $default(_that.removedCategoryIds,_that.openingCash);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingInput extends OnboardingInput {
  const _OnboardingInput({ Set<String> removedCategoryIds = const <String>{}, this.openingCash = 0}): _removedCategoryIds = removedCategoryIds,super._();
  

/// Default categories to remove. Unused ones are deleted; any already in
/// use are archived instead.
 final  Set<String> _removedCategoryIds;
/// Default categories to remove. Unused ones are deleted; any already in
/// use are archived instead.
@override@JsonKey() Set<String> get removedCategoryIds {
  if (_removedCategoryIds is EqualUnmodifiableSetView) return _removedCategoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_removedCategoryIds);
}

/// Opening balance of the Cash account, in rupiah.
@override@JsonKey() final  int openingCash;

/// Create a copy of OnboardingInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingInputCopyWith<_OnboardingInput> get copyWith => __$OnboardingInputCopyWithImpl<_OnboardingInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingInput&&const DeepCollectionEquality().equals(other._removedCategoryIds, _removedCategoryIds)&&(identical(other.openingCash, openingCash) || other.openingCash == openingCash));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_removedCategoryIds),openingCash);

@override
String toString() {
  return 'OnboardingInput(removedCategoryIds: $removedCategoryIds, openingCash: $openingCash)';
}


}

/// @nodoc
abstract mixin class _$OnboardingInputCopyWith<$Res> implements $OnboardingInputCopyWith<$Res> {
  factory _$OnboardingInputCopyWith(_OnboardingInput value, $Res Function(_OnboardingInput) _then) = __$OnboardingInputCopyWithImpl;
@override @useResult
$Res call({
 Set<String> removedCategoryIds, int openingCash
});




}
/// @nodoc
class __$OnboardingInputCopyWithImpl<$Res>
    implements _$OnboardingInputCopyWith<$Res> {
  __$OnboardingInputCopyWithImpl(this._self, this._then);

  final _OnboardingInput _self;
  final $Res Function(_OnboardingInput) _then;

/// Create a copy of OnboardingInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? removedCategoryIds = null,Object? openingCash = null,}) {
  return _then(_OnboardingInput(
removedCategoryIds: null == removedCategoryIds ? _self._removedCategoryIds : removedCategoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,openingCash: null == openingCash ? _self.openingCash : openingCash // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

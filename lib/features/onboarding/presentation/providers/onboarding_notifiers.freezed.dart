// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_notifiers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingForm {

 int get page; Set<String> get removedCategoryIds;/// Keypad text for the starting cash, e.g. `250000+50000`.
 String get expression;/// Its value; null while the expression is invalid.
 int? get openingCash;
/// Create a copy of OnboardingForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingFormCopyWith<OnboardingForm> get copyWith => _$OnboardingFormCopyWithImpl<OnboardingForm>(this as OnboardingForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingForm&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.removedCategoryIds, removedCategoryIds)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.openingCash, openingCash) || other.openingCash == openingCash));
}


@override
int get hashCode => Object.hash(runtimeType,page,const DeepCollectionEquality().hash(removedCategoryIds),expression,openingCash);

@override
String toString() {
  return 'OnboardingForm(page: $page, removedCategoryIds: $removedCategoryIds, expression: $expression, openingCash: $openingCash)';
}


}

/// @nodoc
abstract mixin class $OnboardingFormCopyWith<$Res>  {
  factory $OnboardingFormCopyWith(OnboardingForm value, $Res Function(OnboardingForm) _then) = _$OnboardingFormCopyWithImpl;
@useResult
$Res call({
 int page, Set<String> removedCategoryIds, String expression, int? openingCash
});




}
/// @nodoc
class _$OnboardingFormCopyWithImpl<$Res>
    implements $OnboardingFormCopyWith<$Res> {
  _$OnboardingFormCopyWithImpl(this._self, this._then);

  final OnboardingForm _self;
  final $Res Function(OnboardingForm) _then;

/// Create a copy of OnboardingForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? removedCategoryIds = null,Object? expression = null,Object? openingCash = freezed,}) {
  return _then(OnboardingForm(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,removedCategoryIds: null == removedCategoryIds ? _self.removedCategoryIds : removedCategoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,openingCash: freezed == openingCash ? _self.openingCash : openingCash // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingForm].
extension OnboardingFormPatterns on OnboardingForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingForm value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingForm value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page,  Set<String> removedCategoryIds,  String expression,  int? openingCash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingForm() when $default != null:
return $default(_that.page,_that.removedCategoryIds,_that.expression,_that.openingCash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page,  Set<String> removedCategoryIds,  String expression,  int? openingCash)  $default,) {final _that = this;
switch (_that) {
case _OnboardingForm():
return $default(_that.page,_that.removedCategoryIds,_that.expression,_that.openingCash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page,  Set<String> removedCategoryIds,  String expression,  int? openingCash)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingForm() when $default != null:
return $default(_that.page,_that.removedCategoryIds,_that.expression,_that.openingCash);case _:
  return null;

}
}

}

/// @nodoc


class _OnboardingForm extends OnboardingForm {
  const _OnboardingForm({this.page = 0,  Set<String> removedCategoryIds = const <String>{}, this.expression = '', this.openingCash = 0}): _removedCategoryIds = removedCategoryIds,super._();
  

@override@JsonKey() final  int page;
 final  Set<String> _removedCategoryIds;
@override@JsonKey() Set<String> get removedCategoryIds {
  if (_removedCategoryIds is EqualUnmodifiableSetView) return _removedCategoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_removedCategoryIds);
}

/// Keypad text for the starting cash, e.g. `250000+50000`.
@override@JsonKey() final  String expression;
/// Its value; null while the expression is invalid.
@override@JsonKey() final  int? openingCash;

/// Create a copy of OnboardingForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingFormCopyWith<_OnboardingForm> get copyWith => __$OnboardingFormCopyWithImpl<_OnboardingForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingForm&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._removedCategoryIds, _removedCategoryIds)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.openingCash, openingCash) || other.openingCash == openingCash));
}


@override
int get hashCode => Object.hash(runtimeType,page,const DeepCollectionEquality().hash(_removedCategoryIds),expression,openingCash);

@override
String toString() {
  return 'OnboardingForm(page: $page, removedCategoryIds: $removedCategoryIds, expression: $expression, openingCash: $openingCash)';
}


}

/// @nodoc
abstract mixin class _$OnboardingFormCopyWith<$Res> implements $OnboardingFormCopyWith<$Res> {
  factory _$OnboardingFormCopyWith(_OnboardingForm value, $Res Function(_OnboardingForm) _then) = __$OnboardingFormCopyWithImpl;
@override @useResult
$Res call({
 int page, Set<String> removedCategoryIds, String expression, int? openingCash
});




}
/// @nodoc
class __$OnboardingFormCopyWithImpl<$Res>
    implements _$OnboardingFormCopyWith<$Res> {
  __$OnboardingFormCopyWithImpl(this._self, this._then);

  final _OnboardingForm _self;
  final $Res Function(_OnboardingForm) _then;

/// Create a copy of OnboardingForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? removedCategoryIds = null,Object? expression = null,Object? openingCash = freezed,}) {
  return _then(_OnboardingForm(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,removedCategoryIds: null == removedCategoryIds ? _self._removedCategoryIds : removedCategoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,openingCash: freezed == openingCash ? _self.openingCash : openingCash // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

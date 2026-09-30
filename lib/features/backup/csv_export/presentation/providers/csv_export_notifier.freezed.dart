// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csv_export_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CsvExportForm {

 CsvRangePreset get preset;/// The picked range while [preset] is custom.
 Period? get custom;
/// Create a copy of CsvExportForm
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsvExportFormCopyWith<CsvExportForm> get copyWith => _$CsvExportFormCopyWithImpl<CsvExportForm>(this as CsvExportForm, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsvExportForm&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.custom, custom) || other.custom == custom));
}


@override
int get hashCode => Object.hash(runtimeType,preset,custom);

@override
String toString() {
  return 'CsvExportForm(preset: $preset, custom: $custom)';
}


}

/// @nodoc
abstract mixin class $CsvExportFormCopyWith<$Res>  {
  factory $CsvExportFormCopyWith(CsvExportForm value, $Res Function(CsvExportForm) _then) = _$CsvExportFormCopyWithImpl;
@useResult
$Res call({
 CsvRangePreset preset, Period? custom
});




}
/// @nodoc
class _$CsvExportFormCopyWithImpl<$Res>
    implements $CsvExportFormCopyWith<$Res> {
  _$CsvExportFormCopyWithImpl(this._self, this._then);

  final CsvExportForm _self;
  final $Res Function(CsvExportForm) _then;

/// Create a copy of CsvExportForm
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? preset = null,Object? custom = freezed,}) {
  return _then(CsvExportForm(
preset: null == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as CsvRangePreset,custom: freezed == custom ? _self.custom : custom // ignore: cast_nullable_to_non_nullable
as Period?,
  ));
}

}


/// Adds pattern-matching-related methods to [CsvExportForm].
extension CsvExportFormPatterns on CsvExportForm {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsvExportForm value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsvExportForm() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsvExportForm value)  $default,){
final _that = this;
switch (_that) {
case _CsvExportForm():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsvExportForm value)?  $default,){
final _that = this;
switch (_that) {
case _CsvExportForm() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CsvRangePreset preset,  Period? custom)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsvExportForm() when $default != null:
return $default(_that.preset,_that.custom);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CsvRangePreset preset,  Period? custom)  $default,) {final _that = this;
switch (_that) {
case _CsvExportForm():
return $default(_that.preset,_that.custom);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CsvRangePreset preset,  Period? custom)?  $default,) {final _that = this;
switch (_that) {
case _CsvExportForm() when $default != null:
return $default(_that.preset,_that.custom);case _:
  return null;

}
}

}

/// @nodoc


class _CsvExportForm extends CsvExportForm {
  const _CsvExportForm({this.preset = CsvRangePreset.thisYear, this.custom}): super._();
  

@override@JsonKey() final  CsvRangePreset preset;
/// The picked range while [preset] is custom.
@override final  Period? custom;

/// Create a copy of CsvExportForm
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvExportFormCopyWith<_CsvExportForm> get copyWith => __$CsvExportFormCopyWithImpl<_CsvExportForm>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvExportForm&&(identical(other.preset, preset) || other.preset == preset)&&(identical(other.custom, custom) || other.custom == custom));
}


@override
int get hashCode => Object.hash(runtimeType,preset,custom);

@override
String toString() {
  return 'CsvExportForm(preset: $preset, custom: $custom)';
}


}

/// @nodoc
abstract mixin class _$CsvExportFormCopyWith<$Res> implements $CsvExportFormCopyWith<$Res> {
  factory _$CsvExportFormCopyWith(_CsvExportForm value, $Res Function(_CsvExportForm) _then) = __$CsvExportFormCopyWithImpl;
@override @useResult
$Res call({
 CsvRangePreset preset, Period? custom
});




}
/// @nodoc
class __$CsvExportFormCopyWithImpl<$Res>
    implements _$CsvExportFormCopyWith<$Res> {
  __$CsvExportFormCopyWithImpl(this._self, this._then);

  final _CsvExportForm _self;
  final $Res Function(_CsvExportForm) _then;

/// Create a copy of CsvExportForm
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? preset = null,Object? custom = freezed,}) {
  return _then(_CsvExportForm(
preset: null == preset ? _self.preset : preset // ignore: cast_nullable_to_non_nullable
as CsvRangePreset,custom: freezed == custom ? _self.custom : custom // ignore: cast_nullable_to_non_nullable
as Period?,
  ));
}


}

// dart format on

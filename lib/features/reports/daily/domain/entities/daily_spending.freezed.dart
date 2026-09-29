// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_spending.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailySpending {

 Period get period; LocalDate get today;/// Days with spending; others are zero.
 Map<LocalDate, int> get byDay;
/// Create a copy of DailySpending
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailySpendingCopyWith<DailySpending> get copyWith => _$DailySpendingCopyWithImpl<DailySpending>(this as DailySpending, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailySpending&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.byDay, byDay));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,const DeepCollectionEquality().hash(byDay));

@override
String toString() {
  return 'DailySpending(period: $period, today: $today, byDay: $byDay)';
}


}

/// @nodoc
abstract mixin class $DailySpendingCopyWith<$Res>  {
  factory $DailySpendingCopyWith(DailySpending value, $Res Function(DailySpending) _then) = _$DailySpendingCopyWithImpl;
@useResult
$Res call({
 Period period, LocalDate today, Map<LocalDate, int> byDay
});




}
/// @nodoc
class _$DailySpendingCopyWithImpl<$Res>
    implements $DailySpendingCopyWith<$Res> {
  _$DailySpendingCopyWithImpl(this._self, this._then);

  final DailySpending _self;
  final $Res Function(DailySpending) _then;

/// Create a copy of DailySpending
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? today = null,Object? byDay = null,}) {
  return _then(DailySpending(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate,byDay: null == byDay ? _self.byDay : byDay // ignore: cast_nullable_to_non_nullable
as Map<LocalDate, int>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailySpending].
extension DailySpendingPatterns on DailySpending {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailySpending value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailySpending() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailySpending value)  $default,){
final _that = this;
switch (_that) {
case _DailySpending():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailySpending value)?  $default,){
final _that = this;
switch (_that) {
case _DailySpending() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  Map<LocalDate, int> byDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailySpending() when $default != null:
return $default(_that.period,_that.today,_that.byDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  Map<LocalDate, int> byDay)  $default,) {final _that = this;
switch (_that) {
case _DailySpending():
return $default(_that.period,_that.today,_that.byDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Period period,  LocalDate today,  Map<LocalDate, int> byDay)?  $default,) {final _that = this;
switch (_that) {
case _DailySpending() when $default != null:
return $default(_that.period,_that.today,_that.byDay);case _:
  return null;

}
}

}

/// @nodoc


class _DailySpending extends DailySpending {
  const _DailySpending({required this.period, required this.today, required  Map<LocalDate, int> byDay}): _byDay = byDay,super._();
  

@override final  Period period;
@override final  LocalDate today;
/// Days with spending; others are zero.
 final  Map<LocalDate, int> _byDay;
/// Days with spending; others are zero.
@override Map<LocalDate, int> get byDay {
  if (_byDay is EqualUnmodifiableMapView) return _byDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_byDay);
}


/// Create a copy of DailySpending
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailySpendingCopyWith<_DailySpending> get copyWith => __$DailySpendingCopyWithImpl<_DailySpending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailySpending&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other._byDay, _byDay));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,const DeepCollectionEquality().hash(_byDay));

@override
String toString() {
  return 'DailySpending(period: $period, today: $today, byDay: $byDay)';
}


}

/// @nodoc
abstract mixin class _$DailySpendingCopyWith<$Res> implements $DailySpendingCopyWith<$Res> {
  factory _$DailySpendingCopyWith(_DailySpending value, $Res Function(_DailySpending) _then) = __$DailySpendingCopyWithImpl;
@override @useResult
$Res call({
 Period period, LocalDate today, Map<LocalDate, int> byDay
});




}
/// @nodoc
class __$DailySpendingCopyWithImpl<$Res>
    implements _$DailySpendingCopyWith<$Res> {
  __$DailySpendingCopyWithImpl(this._self, this._then);

  final _DailySpending _self;
  final $Res Function(_DailySpending) _then;

/// Create a copy of DailySpending
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? today = null,Object? byDay = null,}) {
  return _then(_DailySpending(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as LocalDate,byDay: null == byDay ? _self._byDay : byDay // ignore: cast_nullable_to_non_nullable
as Map<LocalDate, int>,
  ));
}


}

// dart format on

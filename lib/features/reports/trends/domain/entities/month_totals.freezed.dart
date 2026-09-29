// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'month_totals.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MonthTotals {

 Period get period; int get income; int get expense;
/// Create a copy of MonthTotals
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MonthTotalsCopyWith<MonthTotals> get copyWith => _$MonthTotalsCopyWithImpl<MonthTotals>(this as MonthTotals, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MonthTotals&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expense);

@override
String toString() {
  return 'MonthTotals(period: $period, income: $income, expense: $expense)';
}


}

/// @nodoc
abstract mixin class $MonthTotalsCopyWith<$Res>  {
  factory $MonthTotalsCopyWith(MonthTotals value, $Res Function(MonthTotals) _then) = _$MonthTotalsCopyWithImpl;
@useResult
$Res call({
 Period period, int income, int expense
});




}
/// @nodoc
class _$MonthTotalsCopyWithImpl<$Res>
    implements $MonthTotalsCopyWith<$Res> {
  _$MonthTotalsCopyWithImpl(this._self, this._then);

  final MonthTotals _self;
  final $Res Function(MonthTotals) _then;

/// Create a copy of MonthTotals
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? income = null,Object? expense = null,}) {
  return _then(MonthTotals(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MonthTotals].
extension MonthTotalsPatterns on MonthTotals {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MonthTotals value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MonthTotals() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MonthTotals value)  $default,){
final _that = this;
switch (_that) {
case _MonthTotals():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MonthTotals value)?  $default,){
final _that = this;
switch (_that) {
case _MonthTotals() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Period period,  int income,  int expense)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MonthTotals() when $default != null:
return $default(_that.period,_that.income,_that.expense);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Period period,  int income,  int expense)  $default,) {final _that = this;
switch (_that) {
case _MonthTotals():
return $default(_that.period,_that.income,_that.expense);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Period period,  int income,  int expense)?  $default,) {final _that = this;
switch (_that) {
case _MonthTotals() when $default != null:
return $default(_that.period,_that.income,_that.expense);case _:
  return null;

}
}

}

/// @nodoc


class _MonthTotals extends MonthTotals {
  const _MonthTotals({required this.period, required this.income, required this.expense}): super._();
  

@override final  Period period;
@override final  int income;
@override final  int expense;

/// Create a copy of MonthTotals
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MonthTotalsCopyWith<_MonthTotals> get copyWith => __$MonthTotalsCopyWithImpl<_MonthTotals>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MonthTotals&&(identical(other.period, period) || other.period == period)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,period,income,expense);

@override
String toString() {
  return 'MonthTotals(period: $period, income: $income, expense: $expense)';
}


}

/// @nodoc
abstract mixin class _$MonthTotalsCopyWith<$Res> implements $MonthTotalsCopyWith<$Res> {
  factory _$MonthTotalsCopyWith(_MonthTotals value, $Res Function(_MonthTotals) _then) = __$MonthTotalsCopyWithImpl;
@override @useResult
$Res call({
 Period period, int income, int expense
});




}
/// @nodoc
class __$MonthTotalsCopyWithImpl<$Res>
    implements _$MonthTotalsCopyWith<$Res> {
  __$MonthTotalsCopyWithImpl(this._self, this._then);

  final _MonthTotals _self;
  final $Res Function(_MonthTotals) _then;

/// Create a copy of MonthTotals
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? income = null,Object? expense = null,}) {
  return _then(_MonthTotals(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

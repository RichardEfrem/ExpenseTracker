// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FilterSummary {

 int get count; int get income; int get expense;
/// Create a copy of FilterSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterSummaryCopyWith<FilterSummary> get copyWith => _$FilterSummaryCopyWithImpl<FilterSummary>(this as FilterSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterSummary&&(identical(other.count, count) || other.count == count)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,count,income,expense);

@override
String toString() {
  return 'FilterSummary(count: $count, income: $income, expense: $expense)';
}


}

/// @nodoc
abstract mixin class $FilterSummaryCopyWith<$Res>  {
  factory $FilterSummaryCopyWith(FilterSummary value, $Res Function(FilterSummary) _then) = _$FilterSummaryCopyWithImpl;
@useResult
$Res call({
 int count, int income, int expense
});




}
/// @nodoc
class _$FilterSummaryCopyWithImpl<$Res>
    implements $FilterSummaryCopyWith<$Res> {
  _$FilterSummaryCopyWithImpl(this._self, this._then);

  final FilterSummary _self;
  final $Res Function(FilterSummary) _then;

/// Create a copy of FilterSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? income = null,Object? expense = null,}) {
  return _then(FilterSummary(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [FilterSummary].
extension FilterSummaryPatterns on FilterSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilterSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilterSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilterSummary value)  $default,){
final _that = this;
switch (_that) {
case _FilterSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilterSummary value)?  $default,){
final _that = this;
switch (_that) {
case _FilterSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  int income,  int expense)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilterSummary() when $default != null:
return $default(_that.count,_that.income,_that.expense);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  int income,  int expense)  $default,) {final _that = this;
switch (_that) {
case _FilterSummary():
return $default(_that.count,_that.income,_that.expense);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  int income,  int expense)?  $default,) {final _that = this;
switch (_that) {
case _FilterSummary() when $default != null:
return $default(_that.count,_that.income,_that.expense);case _:
  return null;

}
}

}

/// @nodoc


class _FilterSummary extends FilterSummary {
  const _FilterSummary({required this.count, required this.income, required this.expense}): super._();
  

@override final  int count;
@override final  int income;
@override final  int expense;

/// Create a copy of FilterSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilterSummaryCopyWith<_FilterSummary> get copyWith => __$FilterSummaryCopyWithImpl<_FilterSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilterSummary&&(identical(other.count, count) || other.count == count)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense));
}


@override
int get hashCode => Object.hash(runtimeType,count,income,expense);

@override
String toString() {
  return 'FilterSummary(count: $count, income: $income, expense: $expense)';
}


}

/// @nodoc
abstract mixin class _$FilterSummaryCopyWith<$Res> implements $FilterSummaryCopyWith<$Res> {
  factory _$FilterSummaryCopyWith(_FilterSummary value, $Res Function(_FilterSummary) _then) = __$FilterSummaryCopyWithImpl;
@override @useResult
$Res call({
 int count, int income, int expense
});




}
/// @nodoc
class __$FilterSummaryCopyWithImpl<$Res>
    implements _$FilterSummaryCopyWith<$Res> {
  __$FilterSummaryCopyWithImpl(this._self, this._then);

  final _FilterSummary _self;
  final $Res Function(_FilterSummary) _then;

/// Create a copy of FilterSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? income = null,Object? expense = null,}) {
  return _then(_FilterSummary(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,income: null == income ? _self.income : income // ignore: cast_nullable_to_non_nullable
as int,expense: null == expense ? _self.expense : expense // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_trend.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategorySeries {

 Category get category;/// One per month, oldest first; 0 for months without data.
 List<int> get amounts;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySeries&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.amounts, amounts));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(amounts));

@override
String toString() {
  return 'CategorySeries(category: $category, amounts: $amounts)';
}


}




/// Adds pattern-matching-related methods to [CategorySeries].
extension CategorySeriesPatterns on CategorySeries {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategorySeries value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategorySeries() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategorySeries value)  $default,){
final _that = this;
switch (_that) {
case _CategorySeries():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategorySeries value)?  $default,){
final _that = this;
switch (_that) {
case _CategorySeries() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category category,  List<int> amounts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategorySeries() when $default != null:
return $default(_that.category,_that.amounts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category category,  List<int> amounts)  $default,) {final _that = this;
switch (_that) {
case _CategorySeries():
return $default(_that.category,_that.amounts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category category,  List<int> amounts)?  $default,) {final _that = this;
switch (_that) {
case _CategorySeries() when $default != null:
return $default(_that.category,_that.amounts);case _:
  return null;

}
}

}

/// @nodoc


class _CategorySeries extends CategorySeries {
  const _CategorySeries({required this.category, required  List<int> amounts}): _amounts = amounts,super._();
  

@override final  Category category;
/// One per month, oldest first; 0 for months without data.
 final  List<int> _amounts;
/// One per month, oldest first; 0 for months without data.
@override List<int> get amounts {
  if (_amounts is EqualUnmodifiableListView) return _amounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_amounts);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategorySeries&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._amounts, _amounts));
}


@override
int get hashCode => Object.hash(runtimeType,category,const DeepCollectionEquality().hash(_amounts));

@override
String toString() {
  return 'CategorySeries(category: $category, amounts: $amounts)';
}


}




/// @nodoc
mixin _$CategoryTrend {

 List<Period> get months;/// Every category with data: expense first, then income; each largest
/// total first.
 List<CategorySeries> get series;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryTrend&&const DeepCollectionEquality().equals(other.months, months)&&const DeepCollectionEquality().equals(other.series, series));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(months),const DeepCollectionEquality().hash(series));

@override
String toString() {
  return 'CategoryTrend(months: $months, series: $series)';
}


}




/// Adds pattern-matching-related methods to [CategoryTrend].
extension CategoryTrendPatterns on CategoryTrend {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryTrend value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryTrend() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryTrend value)  $default,){
final _that = this;
switch (_that) {
case _CategoryTrend():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryTrend value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryTrend() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Period> months,  List<CategorySeries> series)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryTrend() when $default != null:
return $default(_that.months,_that.series);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Period> months,  List<CategorySeries> series)  $default,) {final _that = this;
switch (_that) {
case _CategoryTrend():
return $default(_that.months,_that.series);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Period> months,  List<CategorySeries> series)?  $default,) {final _that = this;
switch (_that) {
case _CategoryTrend() when $default != null:
return $default(_that.months,_that.series);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryTrend extends CategoryTrend {
  const _CategoryTrend({required  List<Period> months, required  List<CategorySeries> series}): _months = months,_series = series,super._();
  

 final  List<Period> _months;
@override List<Period> get months {
  if (_months is EqualUnmodifiableListView) return _months;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_months);
}

/// Every category with data: expense first, then income; each largest
/// total first.
 final  List<CategorySeries> _series;
/// Every category with data: expense first, then income; each largest
/// total first.
@override List<CategorySeries> get series {
  if (_series is EqualUnmodifiableListView) return _series;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_series);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryTrend&&const DeepCollectionEquality().equals(other._months, _months)&&const DeepCollectionEquality().equals(other._series, _series));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_months),const DeepCollectionEquality().hash(_series));

@override
String toString() {
  return 'CategoryTrend(months: $months, series: $series)';
}


}




// dart format on

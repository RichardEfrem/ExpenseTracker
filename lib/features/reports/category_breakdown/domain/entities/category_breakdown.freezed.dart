// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_breakdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DonutSlice {

/// Null for "Other".
 Category? get category; int get amount; double get share;/// Categories behind the slice, for drill-down.
 Set<String> get categoryIds;/// How many categories "Other" groups (0 for a single category).
 int get otherCount;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DonutSlice&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.share, share) || other.share == share)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&(identical(other.otherCount, otherCount) || other.otherCount == otherCount));
}


@override
int get hashCode => Object.hash(runtimeType,category,amount,share,const DeepCollectionEquality().hash(categoryIds),otherCount);

@override
String toString() {
  return 'DonutSlice(category: $category, amount: $amount, share: $share, categoryIds: $categoryIds, otherCount: $otherCount)';
}


}




/// Adds pattern-matching-related methods to [DonutSlice].
extension DonutSlicePatterns on DonutSlice {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DonutSlice value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DonutSlice() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DonutSlice value)  $default,){
final _that = this;
switch (_that) {
case _DonutSlice():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DonutSlice value)?  $default,){
final _that = this;
switch (_that) {
case _DonutSlice() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category? category,  int amount,  double share,  Set<String> categoryIds,  int otherCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DonutSlice() when $default != null:
return $default(_that.category,_that.amount,_that.share,_that.categoryIds,_that.otherCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category? category,  int amount,  double share,  Set<String> categoryIds,  int otherCount)  $default,) {final _that = this;
switch (_that) {
case _DonutSlice():
return $default(_that.category,_that.amount,_that.share,_that.categoryIds,_that.otherCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category? category,  int amount,  double share,  Set<String> categoryIds,  int otherCount)?  $default,) {final _that = this;
switch (_that) {
case _DonutSlice() when $default != null:
return $default(_that.category,_that.amount,_that.share,_that.categoryIds,_that.otherCount);case _:
  return null;

}
}

}

/// @nodoc


class _DonutSlice extends DonutSlice {
  const _DonutSlice({this.category, required this.amount, required this.share, required  Set<String> categoryIds, this.otherCount = 0}): _categoryIds = categoryIds,super._();
  

/// Null for "Other".
@override final  Category? category;
@override final  int amount;
@override final  double share;
/// Categories behind the slice, for drill-down.
 final  Set<String> _categoryIds;
/// Categories behind the slice, for drill-down.
@override Set<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableSetView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categoryIds);
}

/// How many categories "Other" groups (0 for a single category).
@override@JsonKey() final  int otherCount;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DonutSlice&&(identical(other.category, category) || other.category == category)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.share, share) || other.share == share)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&(identical(other.otherCount, otherCount) || other.otherCount == otherCount));
}


@override
int get hashCode => Object.hash(runtimeType,category,amount,share,const DeepCollectionEquality().hash(_categoryIds),otherCount);

@override
String toString() {
  return 'DonutSlice(category: $category, amount: $amount, share: $share, categoryIds: $categoryIds, otherCount: $otherCount)';
}


}




/// @nodoc
mixin _$CategoryBreakdown {

 CategoryType get type;/// Largest first.
 List<CategoryTotal> get totals;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryBreakdown&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.totals, totals));
}


@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(totals));

@override
String toString() {
  return 'CategoryBreakdown(type: $type, totals: $totals)';
}


}




/// Adds pattern-matching-related methods to [CategoryBreakdown].
extension CategoryBreakdownPatterns on CategoryBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _CategoryBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryType type,  List<CategoryTotal> totals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
return $default(_that.type,_that.totals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryType type,  List<CategoryTotal> totals)  $default,) {final _that = this;
switch (_that) {
case _CategoryBreakdown():
return $default(_that.type,_that.totals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryType type,  List<CategoryTotal> totals)?  $default,) {final _that = this;
switch (_that) {
case _CategoryBreakdown() when $default != null:
return $default(_that.type,_that.totals);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryBreakdown extends CategoryBreakdown {
  const _CategoryBreakdown({required this.type, required  List<CategoryTotal> totals}): _totals = totals,super._();
  

@override final  CategoryType type;
/// Largest first.
 final  List<CategoryTotal> _totals;
/// Largest first.
@override List<CategoryTotal> get totals {
  if (_totals is EqualUnmodifiableListView) return _totals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_totals);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryBreakdown&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._totals, _totals));
}


@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_totals));

@override
String toString() {
  return 'CategoryBreakdown(type: $type, totals: $totals)';
}


}




// dart format on

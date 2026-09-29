// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_comparison.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryChange {

 Category get category; int get current; int get previous;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryChange&&(identical(other.category, category) || other.category == category)&&(identical(other.current, current) || other.current == current)&&(identical(other.previous, previous) || other.previous == previous));
}


@override
int get hashCode => Object.hash(runtimeType,category,current,previous);

@override
String toString() {
  return 'CategoryChange(category: $category, current: $current, previous: $previous)';
}


}




/// Adds pattern-matching-related methods to [CategoryChange].
extension CategoryChangePatterns on CategoryChange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryChange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryChange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryChange value)  $default,){
final _that = this;
switch (_that) {
case _CategoryChange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryChange value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryChange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category category,  int current,  int previous)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryChange() when $default != null:
return $default(_that.category,_that.current,_that.previous);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category category,  int current,  int previous)  $default,) {final _that = this;
switch (_that) {
case _CategoryChange():
return $default(_that.category,_that.current,_that.previous);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category category,  int current,  int previous)?  $default,) {final _that = this;
switch (_that) {
case _CategoryChange() when $default != null:
return $default(_that.category,_that.current,_that.previous);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryChange extends CategoryChange {
  const _CategoryChange({required this.category, required this.current, required this.previous}): super._();
  

@override final  Category category;
@override final  int current;
@override final  int previous;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryChange&&(identical(other.category, category) || other.category == category)&&(identical(other.current, current) || other.current == current)&&(identical(other.previous, previous) || other.previous == previous));
}


@override
int get hashCode => Object.hash(runtimeType,category,current,previous);

@override
String toString() {
  return 'CategoryChange(category: $category, current: $current, previous: $previous)';
}


}




/// @nodoc
mixin _$PeriodComparison {

 CategoryType get type; Period get current; Period get previous;/// Largest |Δ| first.
 List<CategoryChange> get changes;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodComparison&&(identical(other.type, type) || other.type == type)&&(identical(other.current, current) || other.current == current)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other.changes, changes));
}


@override
int get hashCode => Object.hash(runtimeType,type,current,previous,const DeepCollectionEquality().hash(changes));

@override
String toString() {
  return 'PeriodComparison(type: $type, current: $current, previous: $previous, changes: $changes)';
}


}




/// Adds pattern-matching-related methods to [PeriodComparison].
extension PeriodComparisonPatterns on PeriodComparison {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodComparison value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodComparison() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodComparison value)  $default,){
final _that = this;
switch (_that) {
case _PeriodComparison():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodComparison value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodComparison() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryType type,  Period current,  Period previous,  List<CategoryChange> changes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodComparison() when $default != null:
return $default(_that.type,_that.current,_that.previous,_that.changes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryType type,  Period current,  Period previous,  List<CategoryChange> changes)  $default,) {final _that = this;
switch (_that) {
case _PeriodComparison():
return $default(_that.type,_that.current,_that.previous,_that.changes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryType type,  Period current,  Period previous,  List<CategoryChange> changes)?  $default,) {final _that = this;
switch (_that) {
case _PeriodComparison() when $default != null:
return $default(_that.type,_that.current,_that.previous,_that.changes);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodComparison extends PeriodComparison {
  const _PeriodComparison({required this.type, required this.current, required this.previous, required  List<CategoryChange> changes}): _changes = changes,super._();
  

@override final  CategoryType type;
@override final  Period current;
@override final  Period previous;
/// Largest |Δ| first.
 final  List<CategoryChange> _changes;
/// Largest |Δ| first.
@override List<CategoryChange> get changes {
  if (_changes is EqualUnmodifiableListView) return _changes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_changes);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodComparison&&(identical(other.type, type) || other.type == type)&&(identical(other.current, current) || other.current == current)&&(identical(other.previous, previous) || other.previous == previous)&&const DeepCollectionEquality().equals(other._changes, _changes));
}


@override
int get hashCode => Object.hash(runtimeType,type,current,previous,const DeepCollectionEquality().hash(_changes));

@override
String toString() {
  return 'PeriodComparison(type: $type, current: $current, previous: $previous, changes: $changes)';
}


}




// dart format on

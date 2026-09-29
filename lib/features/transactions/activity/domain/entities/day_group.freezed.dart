// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'day_group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DayGroup {

 LocalDate get date;/// Income − expense of the listed transactions; transfers count zero.
 int get net;/// Newest first.
 List<TransactionView> get items;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DayGroup&&(identical(other.date, date) || other.date == date)&&(identical(other.net, net) || other.net == net)&&const DeepCollectionEquality().equals(other.items, items));
}


@override
int get hashCode => Object.hash(runtimeType,date,net,const DeepCollectionEquality().hash(items));

@override
String toString() {
  return 'DayGroup(date: $date, net: $net, items: $items)';
}


}




/// Adds pattern-matching-related methods to [DayGroup].
extension DayGroupPatterns on DayGroup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DayGroup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DayGroup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DayGroup value)  $default,){
final _that = this;
switch (_that) {
case _DayGroup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DayGroup value)?  $default,){
final _that = this;
switch (_that) {
case _DayGroup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalDate date,  int net,  List<TransactionView> items)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DayGroup() when $default != null:
return $default(_that.date,_that.net,_that.items);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalDate date,  int net,  List<TransactionView> items)  $default,) {final _that = this;
switch (_that) {
case _DayGroup():
return $default(_that.date,_that.net,_that.items);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalDate date,  int net,  List<TransactionView> items)?  $default,) {final _that = this;
switch (_that) {
case _DayGroup() when $default != null:
return $default(_that.date,_that.net,_that.items);case _:
  return null;

}
}

}

/// @nodoc


class _DayGroup implements DayGroup {
  const _DayGroup({required this.date, required this.net, required  List<TransactionView> items}): _items = items;
  

@override final  LocalDate date;
/// Income − expense of the listed transactions; transfers count zero.
@override final  int net;
/// Newest first.
 final  List<TransactionView> _items;
/// Newest first.
@override List<TransactionView> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DayGroup&&(identical(other.date, date) || other.date == date)&&(identical(other.net, net) || other.net == net)&&const DeepCollectionEquality().equals(other._items, _items));
}


@override
int get hashCode => Object.hash(runtimeType,date,net,const DeepCollectionEquality().hash(_items));

@override
String toString() {
  return 'DayGroup(date: $date, net: $net, items: $items)';
}


}




// dart format on

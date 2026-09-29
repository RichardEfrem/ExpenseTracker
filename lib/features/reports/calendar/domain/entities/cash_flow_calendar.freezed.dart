// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cash_flow_calendar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CalendarBlock {

/// The calendar month when a long period is split per month; null for
/// a single block.
 LocalDate? get month; List<LocalDate?> get cells;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CalendarBlock&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other.cells, cells));
}


@override
int get hashCode => Object.hash(runtimeType,month,const DeepCollectionEquality().hash(cells));

@override
String toString() {
  return 'CalendarBlock(month: $month, cells: $cells)';
}


}




/// Adds pattern-matching-related methods to [CalendarBlock].
extension CalendarBlockPatterns on CalendarBlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CalendarBlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CalendarBlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CalendarBlock value)  $default,){
final _that = this;
switch (_that) {
case _CalendarBlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CalendarBlock value)?  $default,){
final _that = this;
switch (_that) {
case _CalendarBlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalDate? month,  List<LocalDate?> cells)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CalendarBlock() when $default != null:
return $default(_that.month,_that.cells);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalDate? month,  List<LocalDate?> cells)  $default,) {final _that = this;
switch (_that) {
case _CalendarBlock():
return $default(_that.month,_that.cells);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalDate? month,  List<LocalDate?> cells)?  $default,) {final _that = this;
switch (_that) {
case _CalendarBlock() when $default != null:
return $default(_that.month,_that.cells);case _:
  return null;

}
}

}

/// @nodoc


class _CalendarBlock implements CalendarBlock {
  const _CalendarBlock({this.month, required  List<LocalDate?> cells}): _cells = cells;
  

/// The calendar month when a long period is split per month; null for
/// a single block.
@override final  LocalDate? month;
 final  List<LocalDate?> _cells;
@override List<LocalDate?> get cells {
  if (_cells is EqualUnmodifiableListView) return _cells;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cells);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CalendarBlock&&(identical(other.month, month) || other.month == month)&&const DeepCollectionEquality().equals(other._cells, _cells));
}


@override
int get hashCode => Object.hash(runtimeType,month,const DeepCollectionEquality().hash(_cells));

@override
String toString() {
  return 'CalendarBlock(month: $month, cells: $cells)';
}


}




/// @nodoc
mixin _$CashFlowCalendar {

 Period get period; LocalDate get today;/// Income − expense for each day with any; other days are absent.
 Map<LocalDate, int> get netByDay;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CashFlowCalendar&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.netByDay, netByDay));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,const DeepCollectionEquality().hash(netByDay));

@override
String toString() {
  return 'CashFlowCalendar(period: $period, today: $today, netByDay: $netByDay)';
}


}




/// Adds pattern-matching-related methods to [CashFlowCalendar].
extension CashFlowCalendarPatterns on CashFlowCalendar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CashFlowCalendar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CashFlowCalendar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CashFlowCalendar value)  $default,){
final _that = this;
switch (_that) {
case _CashFlowCalendar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CashFlowCalendar value)?  $default,){
final _that = this;
switch (_that) {
case _CashFlowCalendar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  Map<LocalDate, int> netByDay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CashFlowCalendar() when $default != null:
return $default(_that.period,_that.today,_that.netByDay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  Map<LocalDate, int> netByDay)  $default,) {final _that = this;
switch (_that) {
case _CashFlowCalendar():
return $default(_that.period,_that.today,_that.netByDay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Period period,  LocalDate today,  Map<LocalDate, int> netByDay)?  $default,) {final _that = this;
switch (_that) {
case _CashFlowCalendar() when $default != null:
return $default(_that.period,_that.today,_that.netByDay);case _:
  return null;

}
}

}

/// @nodoc


class _CashFlowCalendar extends CashFlowCalendar {
  const _CashFlowCalendar({required this.period, required this.today, required  Map<LocalDate, int> netByDay}): _netByDay = netByDay,super._();
  

@override final  Period period;
@override final  LocalDate today;
/// Income − expense for each day with any; other days are absent.
 final  Map<LocalDate, int> _netByDay;
/// Income − expense for each day with any; other days are absent.
@override Map<LocalDate, int> get netByDay {
  if (_netByDay is EqualUnmodifiableMapView) return _netByDay;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_netByDay);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CashFlowCalendar&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other._netByDay, _netByDay));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,const DeepCollectionEquality().hash(_netByDay));

@override
String toString() {
  return 'CashFlowCalendar(period: $period, today: $today, netByDay: $netByDay)';
}


}




// dart format on

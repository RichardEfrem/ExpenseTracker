// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'period_statistics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LargestExpense {

 String get transactionId; int get amount; LocalDate get date; Category? get category;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LargestExpense&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,amount,date,category);

@override
String toString() {
  return 'LargestExpense(transactionId: $transactionId, amount: $amount, date: $date, category: $category)';
}


}




/// Adds pattern-matching-related methods to [LargestExpense].
extension LargestExpensePatterns on LargestExpense {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LargestExpense value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LargestExpense() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LargestExpense value)  $default,){
final _that = this;
switch (_that) {
case _LargestExpense():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LargestExpense value)?  $default,){
final _that = this;
switch (_that) {
case _LargestExpense() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String transactionId,  int amount,  LocalDate date,  Category? category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LargestExpense() when $default != null:
return $default(_that.transactionId,_that.amount,_that.date,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String transactionId,  int amount,  LocalDate date,  Category? category)  $default,) {final _that = this;
switch (_that) {
case _LargestExpense():
return $default(_that.transactionId,_that.amount,_that.date,_that.category);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String transactionId,  int amount,  LocalDate date,  Category? category)?  $default,) {final _that = this;
switch (_that) {
case _LargestExpense() when $default != null:
return $default(_that.transactionId,_that.amount,_that.date,_that.category);case _:
  return null;

}
}

}

/// @nodoc


class _LargestExpense implements LargestExpense {
  const _LargestExpense({required this.transactionId, required this.amount, required this.date, this.category});
  

@override final  String transactionId;
@override final  int amount;
@override final  LocalDate date;
@override final  Category? category;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LargestExpense&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId,amount,date,category);

@override
String toString() {
  return 'LargestExpense(transactionId: $transactionId, amount: $amount, date: $date, category: $category)';
}


}




/// @nodoc
mixin _$CategoryCount {

 Category get category; int get count;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryCount&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'CategoryCount(category: $category, count: $count)';
}


}




/// Adds pattern-matching-related methods to [CategoryCount].
extension CategoryCountPatterns on CategoryCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryCount value)  $default,){
final _that = this;
switch (_that) {
case _CategoryCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryCount value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Category category,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryCount() when $default != null:
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Category category,  int count)  $default,) {final _that = this;
switch (_that) {
case _CategoryCount():
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Category category,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CategoryCount() when $default != null:
return $default(_that.category,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryCount implements CategoryCount {
  const _CategoryCount({required this.category, required this.count});
  

@override final  Category category;
@override final  int count;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryCount&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'CategoryCount(category: $category, count: $count)';
}


}




/// @nodoc
mixin _$PeriodStatistics {

 Period get period; LocalDate get today; int get income; int get expense; int get previousIncome; int get previousExpense;/// Days up to today with at least one expense.
 int get expenseDays; LargestExpense? get largestExpense; CategoryCount? get mostFrequentCategory;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodStatistics&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.previousIncome, previousIncome) || other.previousIncome == previousIncome)&&(identical(other.previousExpense, previousExpense) || other.previousExpense == previousExpense)&&(identical(other.expenseDays, expenseDays) || other.expenseDays == expenseDays)&&(identical(other.largestExpense, largestExpense) || other.largestExpense == largestExpense)&&(identical(other.mostFrequentCategory, mostFrequentCategory) || other.mostFrequentCategory == mostFrequentCategory));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,income,expense,previousIncome,previousExpense,expenseDays,largestExpense,mostFrequentCategory);

@override
String toString() {
  return 'PeriodStatistics(period: $period, today: $today, income: $income, expense: $expense, previousIncome: $previousIncome, previousExpense: $previousExpense, expenseDays: $expenseDays, largestExpense: $largestExpense, mostFrequentCategory: $mostFrequentCategory)';
}


}




/// Adds pattern-matching-related methods to [PeriodStatistics].
extension PeriodStatisticsPatterns on PeriodStatistics {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodStatistics value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodStatistics() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodStatistics value)  $default,){
final _that = this;
switch (_that) {
case _PeriodStatistics():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodStatistics value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodStatistics() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  int income,  int expense,  int previousIncome,  int previousExpense,  int expenseDays,  LargestExpense? largestExpense,  CategoryCount? mostFrequentCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodStatistics() when $default != null:
return $default(_that.period,_that.today,_that.income,_that.expense,_that.previousIncome,_that.previousExpense,_that.expenseDays,_that.largestExpense,_that.mostFrequentCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Period period,  LocalDate today,  int income,  int expense,  int previousIncome,  int previousExpense,  int expenseDays,  LargestExpense? largestExpense,  CategoryCount? mostFrequentCategory)  $default,) {final _that = this;
switch (_that) {
case _PeriodStatistics():
return $default(_that.period,_that.today,_that.income,_that.expense,_that.previousIncome,_that.previousExpense,_that.expenseDays,_that.largestExpense,_that.mostFrequentCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Period period,  LocalDate today,  int income,  int expense,  int previousIncome,  int previousExpense,  int expenseDays,  LargestExpense? largestExpense,  CategoryCount? mostFrequentCategory)?  $default,) {final _that = this;
switch (_that) {
case _PeriodStatistics() when $default != null:
return $default(_that.period,_that.today,_that.income,_that.expense,_that.previousIncome,_that.previousExpense,_that.expenseDays,_that.largestExpense,_that.mostFrequentCategory);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodStatistics extends PeriodStatistics {
  const _PeriodStatistics({required this.period, required this.today, required this.income, required this.expense, required this.previousIncome, required this.previousExpense, required this.expenseDays, this.largestExpense, this.mostFrequentCategory}): super._();
  

@override final  Period period;
@override final  LocalDate today;
@override final  int income;
@override final  int expense;
@override final  int previousIncome;
@override final  int previousExpense;
/// Days up to today with at least one expense.
@override final  int expenseDays;
@override final  LargestExpense? largestExpense;
@override final  CategoryCount? mostFrequentCategory;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodStatistics&&(identical(other.period, period) || other.period == period)&&(identical(other.today, today) || other.today == today)&&(identical(other.income, income) || other.income == income)&&(identical(other.expense, expense) || other.expense == expense)&&(identical(other.previousIncome, previousIncome) || other.previousIncome == previousIncome)&&(identical(other.previousExpense, previousExpense) || other.previousExpense == previousExpense)&&(identical(other.expenseDays, expenseDays) || other.expenseDays == expenseDays)&&(identical(other.largestExpense, largestExpense) || other.largestExpense == largestExpense)&&(identical(other.mostFrequentCategory, mostFrequentCategory) || other.mostFrequentCategory == mostFrequentCategory));
}


@override
int get hashCode => Object.hash(runtimeType,period,today,income,expense,previousIncome,previousExpense,expenseDays,largestExpense,mostFrequentCategory);

@override
String toString() {
  return 'PeriodStatistics(period: $period, today: $today, income: $income, expense: $expense, previousIncome: $previousIncome, previousExpense: $previousExpense, expenseDays: $expenseDays, largestExpense: $largestExpense, mostFrequentCategory: $mostFrequentCategory)';
}


}




// dart format on

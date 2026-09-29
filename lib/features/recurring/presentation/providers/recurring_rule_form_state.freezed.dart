// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_rule_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringRuleFormState {

/// Set when editing an existing rule.
 String? get editingId; TransactionType get type;/// Keypad text, e.g. `25000+12500`.
 String get expression;/// [expression] evaluated; null while empty or invalid.
 int? get amount; String? get categoryId;/// The category shown first in the grid.
 String? get firstCategoryId; String get accountId;/// Transfers only: the destination account.
 String? get toAccountId; String? get note; RecurrenceFrequency get frequency; int get interval;/// Monthly only; null follows [startDate]'s day.
 int? get dayOfMonth; LocalDate get startDate; LocalDate? get endDate; bool get autoCreate; bool get saving; Failure? get failure;
/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringRuleFormStateCopyWith<RecurringRuleFormState> get copyWith => _$RecurringRuleFormStateCopyWithImpl<RecurringRuleFormState>(this as RecurringRuleFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringRuleFormState&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.firstCategoryId, firstCategoryId) || other.firstCategoryId == firstCategoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,editingId,type,expression,amount,categoryId,firstCategoryId,accountId,toAccountId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate,saving,failure);

@override
String toString() {
  return 'RecurringRuleFormState(editingId: $editingId, type: $type, expression: $expression, amount: $amount, categoryId: $categoryId, firstCategoryId: $firstCategoryId, accountId: $accountId, toAccountId: $toAccountId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate, saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $RecurringRuleFormStateCopyWith<$Res>  {
  factory $RecurringRuleFormStateCopyWith(RecurringRuleFormState value, $Res Function(RecurringRuleFormState) _then) = _$RecurringRuleFormStateCopyWithImpl;
@useResult
$Res call({
 String? editingId, TransactionType type, String expression, int? amount, String? categoryId, String? firstCategoryId, String accountId, String? toAccountId, String? note, RecurrenceFrequency frequency, int interval, int? dayOfMonth, LocalDate startDate, LocalDate? endDate, bool autoCreate, bool saving, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$RecurringRuleFormStateCopyWithImpl<$Res>
    implements $RecurringRuleFormStateCopyWith<$Res> {
  _$RecurringRuleFormStateCopyWithImpl(this._self, this._then);

  final RecurringRuleFormState _self;
  final $Res Function(RecurringRuleFormState) _then;

/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? editingId = freezed,Object? type = null,Object? expression = null,Object? amount = freezed,Object? categoryId = freezed,Object? firstCategoryId = freezed,Object? accountId = null,Object? toAccountId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,Object? saving = null,Object? failure = freezed,}) {
  return _then(RecurringRuleFormState(
editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,firstCategoryId: freezed == firstCategoryId ? _self.firstCategoryId : firstCategoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as LocalDate,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecurringRuleFormState].
extension RecurringRuleFormStatePatterns on RecurringRuleFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringRuleFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringRuleFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringRuleFormState value)  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringRuleFormState value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate,  bool saving,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringRuleFormState() when $default != null:
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate,  bool saving,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleFormState():
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate,  bool saving,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleFormState() when $default != null:
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.saving,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringRuleFormState extends RecurringRuleFormState {
  const _RecurringRuleFormState({this.editingId, required this.type, this.expression = '', this.amount, this.categoryId, this.firstCategoryId, required this.accountId, this.toAccountId, this.note, required this.frequency, this.interval = 1, this.dayOfMonth, required this.startDate, this.endDate, this.autoCreate = true, this.saving = false, this.failure}): super._();
  

/// Set when editing an existing rule.
@override final  String? editingId;
@override final  TransactionType type;
/// Keypad text, e.g. `25000+12500`.
@override@JsonKey() final  String expression;
/// [expression] evaluated; null while empty or invalid.
@override final  int? amount;
@override final  String? categoryId;
/// The category shown first in the grid.
@override final  String? firstCategoryId;
@override final  String accountId;
/// Transfers only: the destination account.
@override final  String? toAccountId;
@override final  String? note;
@override final  RecurrenceFrequency frequency;
@override@JsonKey() final  int interval;
/// Monthly only; null follows [startDate]'s day.
@override final  int? dayOfMonth;
@override final  LocalDate startDate;
@override final  LocalDate? endDate;
@override@JsonKey() final  bool autoCreate;
@override@JsonKey() final  bool saving;
@override final  Failure? failure;

/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringRuleFormStateCopyWith<_RecurringRuleFormState> get copyWith => __$RecurringRuleFormStateCopyWithImpl<_RecurringRuleFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringRuleFormState&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.firstCategoryId, firstCategoryId) || other.firstCategoryId == firstCategoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,editingId,type,expression,amount,categoryId,firstCategoryId,accountId,toAccountId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate,saving,failure);

@override
String toString() {
  return 'RecurringRuleFormState(editingId: $editingId, type: $type, expression: $expression, amount: $amount, categoryId: $categoryId, firstCategoryId: $firstCategoryId, accountId: $accountId, toAccountId: $toAccountId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate, saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$RecurringRuleFormStateCopyWith<$Res> implements $RecurringRuleFormStateCopyWith<$Res> {
  factory _$RecurringRuleFormStateCopyWith(_RecurringRuleFormState value, $Res Function(_RecurringRuleFormState) _then) = __$RecurringRuleFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? editingId, TransactionType type, String expression, int? amount, String? categoryId, String? firstCategoryId, String accountId, String? toAccountId, String? note, RecurrenceFrequency frequency, int interval, int? dayOfMonth, LocalDate startDate, LocalDate? endDate, bool autoCreate, bool saving, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$RecurringRuleFormStateCopyWithImpl<$Res>
    implements _$RecurringRuleFormStateCopyWith<$Res> {
  __$RecurringRuleFormStateCopyWithImpl(this._self, this._then);

  final _RecurringRuleFormState _self;
  final $Res Function(_RecurringRuleFormState) _then;

/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? editingId = freezed,Object? type = null,Object? expression = null,Object? amount = freezed,Object? categoryId = freezed,Object? firstCategoryId = freezed,Object? accountId = null,Object? toAccountId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,Object? saving = null,Object? failure = freezed,}) {
  return _then(_RecurringRuleFormState(
editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,firstCategoryId: freezed == firstCategoryId ? _self.firstCategoryId : firstCategoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as LocalDate,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of RecurringRuleFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FailureCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $FailureCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on

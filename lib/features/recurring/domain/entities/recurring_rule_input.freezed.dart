// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurring_rule_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RecurringRuleInput {

 TransactionType get type; int get amount; String get accountId; String? get toAccountId; String? get categoryId; String? get note; RecurrenceFrequency get frequency; int get interval; int? get dayOfMonth; LocalDate get startDate; LocalDate? get endDate; bool get autoCreate;
/// Create a copy of RecurringRuleInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringRuleInputCopyWith<RecurringRuleInput> get copyWith => _$RecurringRuleInputCopyWithImpl<RecurringRuleInput>(this as RecurringRuleInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringRuleInput&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,accountId,toAccountId,categoryId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate);

@override
String toString() {
  return 'RecurringRuleInput(type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate)';
}


}

/// @nodoc
abstract mixin class $RecurringRuleInputCopyWith<$Res>  {
  factory $RecurringRuleInputCopyWith(RecurringRuleInput value, $Res Function(RecurringRuleInput) _then) = _$RecurringRuleInputCopyWithImpl;
@useResult
$Res call({
 TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, String? note, RecurrenceFrequency frequency, int interval, int? dayOfMonth, LocalDate startDate, LocalDate? endDate, bool autoCreate
});




}
/// @nodoc
class _$RecurringRuleInputCopyWithImpl<$Res>
    implements $RecurringRuleInputCopyWith<$Res> {
  _$RecurringRuleInputCopyWithImpl(this._self, this._then);

  final RecurringRuleInput _self;
  final $Res Function(RecurringRuleInput) _then;

/// Create a copy of RecurringRuleInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,}) {
  return _then(RecurringRuleInput(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as LocalDate,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringRuleInput].
extension RecurringRuleInputPatterns on RecurringRuleInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringRuleInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringRuleInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringRuleInput value)  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringRuleInput value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringRuleInput() when $default != null:
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate)  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleInput():
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  RecurrenceFrequency frequency,  int interval,  int? dayOfMonth,  LocalDate startDate,  LocalDate? endDate,  bool autoCreate)?  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleInput() when $default != null:
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate);case _:
  return null;

}
}

}

/// @nodoc


class _RecurringRuleInput extends RecurringRuleInput {
  const _RecurringRuleInput({required this.type, required this.amount, required this.accountId, this.toAccountId, this.categoryId, this.note, required this.frequency, this.interval = 1, this.dayOfMonth, required this.startDate, this.endDate, this.autoCreate = true}): super._();
  

@override final  TransactionType type;
@override final  int amount;
@override final  String accountId;
@override final  String? toAccountId;
@override final  String? categoryId;
@override final  String? note;
@override final  RecurrenceFrequency frequency;
@override@JsonKey() final  int interval;
@override final  int? dayOfMonth;
@override final  LocalDate startDate;
@override final  LocalDate? endDate;
@override@JsonKey() final  bool autoCreate;

/// Create a copy of RecurringRuleInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringRuleInputCopyWith<_RecurringRuleInput> get copyWith => __$RecurringRuleInputCopyWithImpl<_RecurringRuleInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringRuleInput&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,accountId,toAccountId,categoryId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate);

@override
String toString() {
  return 'RecurringRuleInput(type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate)';
}


}

/// @nodoc
abstract mixin class _$RecurringRuleInputCopyWith<$Res> implements $RecurringRuleInputCopyWith<$Res> {
  factory _$RecurringRuleInputCopyWith(_RecurringRuleInput value, $Res Function(_RecurringRuleInput) _then) = __$RecurringRuleInputCopyWithImpl;
@override @useResult
$Res call({
 TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, String? note, RecurrenceFrequency frequency, int interval, int? dayOfMonth, LocalDate startDate, LocalDate? endDate, bool autoCreate
});




}
/// @nodoc
class __$RecurringRuleInputCopyWithImpl<$Res>
    implements _$RecurringRuleInputCopyWith<$Res> {
  __$RecurringRuleInputCopyWithImpl(this._self, this._then);

  final _RecurringRuleInput _self;
  final $Res Function(_RecurringRuleInput) _then;

/// Create a copy of RecurringRuleInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,}) {
  return _then(_RecurringRuleInput(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as LocalDate,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on

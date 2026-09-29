// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionInput {

 TransactionType get type; int get amount; String get accountId; String? get toAccountId; String? get categoryId; LocalDate get date; LocalTime get time; String? get note;
/// Create a copy of TransactionInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionInputCopyWith<TransactionInput> get copyWith => _$TransactionInputCopyWithImpl<TransactionInput>(this as TransactionInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionInput&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,accountId,toAccountId,categoryId,date,time,note);

@override
String toString() {
  return 'TransactionInput(type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note)';
}


}

/// @nodoc
abstract mixin class $TransactionInputCopyWith<$Res>  {
  factory $TransactionInputCopyWith(TransactionInput value, $Res Function(TransactionInput) _then) = _$TransactionInputCopyWithImpl;
@useResult
$Res call({
 TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, LocalDate date, LocalTime time, String? note
});




}
/// @nodoc
class _$TransactionInputCopyWithImpl<$Res>
    implements $TransactionInputCopyWith<$Res> {
  _$TransactionInputCopyWithImpl(this._self, this._then);

  final TransactionInput _self;
  final $Res Function(TransactionInput) _then;

/// Create a copy of TransactionInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,}) {
  return _then(TransactionInput(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionInput].
extension TransactionInputPatterns on TransactionInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionInput value)  $default,){
final _that = this;
switch (_that) {
case _TransactionInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionInput value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionInput() when $default != null:
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note)  $default,) {final _that = this;
switch (_that) {
case _TransactionInput():
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note)?  $default,) {final _that = this;
switch (_that) {
case _TransactionInput() when $default != null:
return $default(_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionInput extends TransactionInput {
  const _TransactionInput({required this.type, required this.amount, required this.accountId, this.toAccountId, this.categoryId, required this.date, required this.time, this.note}): super._();
  

@override final  TransactionType type;
@override final  int amount;
@override final  String accountId;
@override final  String? toAccountId;
@override final  String? categoryId;
@override final  LocalDate date;
@override final  LocalTime time;
@override final  String? note;

/// Create a copy of TransactionInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionInputCopyWith<_TransactionInput> get copyWith => __$TransactionInputCopyWithImpl<_TransactionInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionInput&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,type,amount,accountId,toAccountId,categoryId,date,time,note);

@override
String toString() {
  return 'TransactionInput(type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note)';
}


}

/// @nodoc
abstract mixin class _$TransactionInputCopyWith<$Res> implements $TransactionInputCopyWith<$Res> {
  factory _$TransactionInputCopyWith(_TransactionInput value, $Res Function(_TransactionInput) _then) = __$TransactionInputCopyWithImpl;
@override @useResult
$Res call({
 TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, LocalDate date, LocalTime time, String? note
});




}
/// @nodoc
class __$TransactionInputCopyWithImpl<$Res>
    implements _$TransactionInputCopyWith<$Res> {
  __$TransactionInputCopyWithImpl(this._self, this._then);

  final _TransactionInput _self;
  final $Res Function(_TransactionInput) _then;

/// Create a copy of TransactionInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,}) {
  return _then(_TransactionInput(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'csv_transaction_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CsvTransactionRow {

 LocalDate get date; LocalTime get time; TransactionType get type;/// Rupiah. Positive, with [type] giving the direction, except for
/// adjustments that remove money, which are negative.
 int get amount;/// Null for transfers and adjustments.
 String? get category; String get account;/// Transfers only: where the money went.
 String? get toAccount; String? get note;/// Tag names, sorted.
 List<String> get tags;
/// Create a copy of CsvTransactionRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsvTransactionRowCopyWith<CsvTransactionRow> get copyWith => _$CsvTransactionRowCopyWithImpl<CsvTransactionRow>(this as CsvTransactionRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsvTransactionRow&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,date,time,type,amount,category,account,toAccount,note,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'CsvTransactionRow(date: $date, time: $time, type: $type, amount: $amount, category: $category, account: $account, toAccount: $toAccount, note: $note, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $CsvTransactionRowCopyWith<$Res>  {
  factory $CsvTransactionRowCopyWith(CsvTransactionRow value, $Res Function(CsvTransactionRow) _then) = _$CsvTransactionRowCopyWithImpl;
@useResult
$Res call({
 LocalDate date, LocalTime time, TransactionType type, int amount, String? category, String account, String? toAccount, String? note, List<String> tags
});




}
/// @nodoc
class _$CsvTransactionRowCopyWithImpl<$Res>
    implements $CsvTransactionRowCopyWith<$Res> {
  _$CsvTransactionRowCopyWithImpl(this._self, this._then);

  final CsvTransactionRow _self;
  final $Res Function(CsvTransactionRow) _then;

/// Create a copy of CsvTransactionRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? time = null,Object? type = null,Object? amount = null,Object? category = freezed,Object? account = null,Object? toAccount = freezed,Object? note = freezed,Object? tags = null,}) {
  return _then(CsvTransactionRow(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,toAccount: freezed == toAccount ? _self.toAccount : toAccount // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [CsvTransactionRow].
extension CsvTransactionRowPatterns on CsvTransactionRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsvTransactionRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsvTransactionRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsvTransactionRow value)  $default,){
final _that = this;
switch (_that) {
case _CsvTransactionRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsvTransactionRow value)?  $default,){
final _that = this;
switch (_that) {
case _CsvTransactionRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LocalDate date,  LocalTime time,  TransactionType type,  int amount,  String? category,  String account,  String? toAccount,  String? note,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsvTransactionRow() when $default != null:
return $default(_that.date,_that.time,_that.type,_that.amount,_that.category,_that.account,_that.toAccount,_that.note,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LocalDate date,  LocalTime time,  TransactionType type,  int amount,  String? category,  String account,  String? toAccount,  String? note,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _CsvTransactionRow():
return $default(_that.date,_that.time,_that.type,_that.amount,_that.category,_that.account,_that.toAccount,_that.note,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LocalDate date,  LocalTime time,  TransactionType type,  int amount,  String? category,  String account,  String? toAccount,  String? note,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _CsvTransactionRow() when $default != null:
return $default(_that.date,_that.time,_that.type,_that.amount,_that.category,_that.account,_that.toAccount,_that.note,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _CsvTransactionRow implements CsvTransactionRow {
  const _CsvTransactionRow({required this.date, required this.time, required this.type, required this.amount, this.category, required this.account, this.toAccount, this.note,  List<String> tags = const <String>[]}): _tags = tags;
  

@override final  LocalDate date;
@override final  LocalTime time;
@override final  TransactionType type;
/// Rupiah. Positive, with [type] giving the direction, except for
/// adjustments that remove money, which are negative.
@override final  int amount;
/// Null for transfers and adjustments.
@override final  String? category;
@override final  String account;
/// Transfers only: where the money went.
@override final  String? toAccount;
@override final  String? note;
/// Tag names, sorted.
 final  List<String> _tags;
/// Tag names, sorted.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of CsvTransactionRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsvTransactionRowCopyWith<_CsvTransactionRow> get copyWith => __$CsvTransactionRowCopyWithImpl<_CsvTransactionRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsvTransactionRow&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,date,time,type,amount,category,account,toAccount,note,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'CsvTransactionRow(date: $date, time: $time, type: $type, amount: $amount, category: $category, account: $account, toAccount: $toAccount, note: $note, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$CsvTransactionRowCopyWith<$Res> implements $CsvTransactionRowCopyWith<$Res> {
  factory _$CsvTransactionRowCopyWith(_CsvTransactionRow value, $Res Function(_CsvTransactionRow) _then) = __$CsvTransactionRowCopyWithImpl;
@override @useResult
$Res call({
 LocalDate date, LocalTime time, TransactionType type, int amount, String? category, String account, String? toAccount, String? note, List<String> tags
});




}
/// @nodoc
class __$CsvTransactionRowCopyWithImpl<$Res>
    implements _$CsvTransactionRowCopyWith<$Res> {
  __$CsvTransactionRowCopyWithImpl(this._self, this._then);

  final _CsvTransactionRow _self;
  final $Res Function(_CsvTransactionRow) _then;

/// Create a copy of CsvTransactionRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? time = null,Object? type = null,Object? amount = null,Object? category = freezed,Object? account = null,Object? toAccount = freezed,Object? note = freezed,Object? tags = null,}) {
  return _then(_CsvTransactionRow(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,account: null == account ? _self.account : account // ignore: cast_nullable_to_non_nullable
as String,toAccount: freezed == toAccount ? _self.toAccount : toAccount // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

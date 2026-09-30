// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Transaction {

 String get id; TransactionType get type;/// Positive integer rupiah; [type] gives the direction.
 int get amount; String get accountId; String? get toAccountId; String? get categoryId; LocalDate get date; LocalTime get time; String? get note; String? get recurringRuleId; String? get receiptPath; DateTime get createdAt; DateTime get updatedAt;/// Tag names, sorted (PRD US-15). Loaded when reading one transaction
/// (detail, edit, duplicate, delete for undo); lists leave it empty.
 List<String> get tags;
/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionCopyWith<Transaction> get copyWith => _$TransactionCopyWithImpl<Transaction>(this as Transaction, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,date,time,note,recurringRuleId,receiptPath,createdAt,updatedAt,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'Transaction(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note, recurringRuleId: $recurringRuleId, receiptPath: $receiptPath, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $TransactionCopyWith<$Res>  {
  factory $TransactionCopyWith(Transaction value, $Res Function(Transaction) _then) = _$TransactionCopyWithImpl;
@useResult
$Res call({
 String id, TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, LocalDate date, LocalTime time, String? note, String? recurringRuleId, String? receiptPath, DateTime createdAt, DateTime updatedAt, List<String> tags
});




}
/// @nodoc
class _$TransactionCopyWithImpl<$Res>
    implements $TransactionCopyWith<$Res> {
  _$TransactionCopyWithImpl(this._self, this._then);

  final Transaction _self;
  final $Res Function(Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? recurringRuleId = freezed,Object? receiptPath = freezed,Object? createdAt = null,Object? updatedAt = null,Object? tags = null,}) {
  return _then(Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Transaction].
extension TransactionPatterns on Transaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Transaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Transaction value)  $default,){
final _that = this;
switch (_that) {
case _Transaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Transaction value)?  $default,){
final _that = this;
switch (_that) {
case _Transaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note,  String? recurringRuleId,  String? receiptPath,  DateTime createdAt,  DateTime updatedAt,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note,  String? recurringRuleId,  String? receiptPath,  DateTime createdAt,  DateTime updatedAt,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _Transaction():
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  TransactionType type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  LocalDate date,  LocalTime time,  String? note,  String? recurringRuleId,  String? receiptPath,  DateTime createdAt,  DateTime updatedAt,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _Transaction() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _Transaction extends Transaction {
  const _Transaction({required this.id, required this.type, required this.amount, required this.accountId, this.toAccountId, this.categoryId, required this.date, required this.time, this.note, this.recurringRuleId, this.receiptPath, required this.createdAt, required this.updatedAt,  List<String> tags = const <String>[]}): _tags = tags,super._();
  

@override final  String id;
@override final  TransactionType type;
/// Positive integer rupiah; [type] gives the direction.
@override final  int amount;
@override final  String accountId;
@override final  String? toAccountId;
@override final  String? categoryId;
@override final  LocalDate date;
@override final  LocalTime time;
@override final  String? note;
@override final  String? recurringRuleId;
@override final  String? receiptPath;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
/// Tag names, sorted (PRD US-15). Loaded when reading one transaction
/// (detail, edit, duplicate, delete for undo); lists leave it empty.
 final  List<String> _tags;
/// Tag names, sorted (PRD US-15). Loaded when reading one transaction
/// (detail, edit, duplicate, delete for undo); lists leave it empty.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionCopyWith<_Transaction> get copyWith => __$TransactionCopyWithImpl<_Transaction>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Transaction&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,date,time,note,recurringRuleId,receiptPath,createdAt,updatedAt,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'Transaction(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note, recurringRuleId: $recurringRuleId, receiptPath: $receiptPath, createdAt: $createdAt, updatedAt: $updatedAt, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$TransactionCopyWith<$Res> implements $TransactionCopyWith<$Res> {
  factory _$TransactionCopyWith(_Transaction value, $Res Function(_Transaction) _then) = __$TransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, TransactionType type, int amount, String accountId, String? toAccountId, String? categoryId, LocalDate date, LocalTime time, String? note, String? recurringRuleId, String? receiptPath, DateTime createdAt, DateTime updatedAt, List<String> tags
});




}
/// @nodoc
class __$TransactionCopyWithImpl<$Res>
    implements _$TransactionCopyWith<$Res> {
  __$TransactionCopyWithImpl(this._self, this._then);

  final _Transaction _self;
  final $Res Function(_Transaction) _then;

/// Create a copy of Transaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? recurringRuleId = freezed,Object? receiptPath = freezed,Object? createdAt = null,Object? updatedAt = null,Object? tags = null,}) {
  return _then(_Transaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on

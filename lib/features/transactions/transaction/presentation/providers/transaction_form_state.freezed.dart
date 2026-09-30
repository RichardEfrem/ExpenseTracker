// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFormState {

/// Set when editing an existing transaction.
 String? get editingId; TransactionType get type;/// Keypad text, e.g. `25000+12500`.
 String get expression;/// [expression] evaluated; null while empty or invalid.
 int? get amount; String? get categoryId;/// The last-used category, shown first in the grid.
 String? get firstCategoryId; String get accountId;/// Transfers only: the destination account.
 String? get toAccountId; LocalDate get date; LocalTime get time; String? get note;/// Tag names (PRD US-15).
 List<String> get tags; bool get saving; Failure? get failure;
/// Create a copy of TransactionFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFormStateCopyWith<TransactionFormState> get copyWith => _$TransactionFormStateCopyWithImpl<TransactionFormState>(this as TransactionFormState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFormState&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.firstCategoryId, firstCategoryId) || other.firstCategoryId == firstCategoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,editingId,type,expression,amount,categoryId,firstCategoryId,accountId,toAccountId,date,time,note,const DeepCollectionEquality().hash(tags),saving,failure);

@override
String toString() {
  return 'TransactionFormState(editingId: $editingId, type: $type, expression: $expression, amount: $amount, categoryId: $categoryId, firstCategoryId: $firstCategoryId, accountId: $accountId, toAccountId: $toAccountId, date: $date, time: $time, note: $note, tags: $tags, saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $TransactionFormStateCopyWith<$Res>  {
  factory $TransactionFormStateCopyWith(TransactionFormState value, $Res Function(TransactionFormState) _then) = _$TransactionFormStateCopyWithImpl;
@useResult
$Res call({
 String? editingId, TransactionType type, String expression, int? amount, String? categoryId, String? firstCategoryId, String accountId, String? toAccountId, LocalDate date, LocalTime time, String? note, List<String> tags, bool saving, Failure? failure
});


$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$TransactionFormStateCopyWithImpl<$Res>
    implements $TransactionFormStateCopyWith<$Res> {
  _$TransactionFormStateCopyWithImpl(this._self, this._then);

  final TransactionFormState _self;
  final $Res Function(TransactionFormState) _then;

/// Create a copy of TransactionFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? editingId = freezed,Object? type = null,Object? expression = null,Object? amount = freezed,Object? categoryId = freezed,Object? firstCategoryId = freezed,Object? accountId = null,Object? toAccountId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? tags = null,Object? saving = null,Object? failure = freezed,}) {
  return _then(TransactionFormState(
editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,firstCategoryId: freezed == firstCategoryId ? _self.firstCategoryId : firstCategoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}
/// Create a copy of TransactionFormState
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


/// Adds pattern-matching-related methods to [TransactionFormState].
extension TransactionFormStatePatterns on TransactionFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionFormState value)  $default,){
final _that = this;
switch (_that) {
case _TransactionFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionFormState value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  LocalDate date,  LocalTime time,  String? note,  List<String> tags,  bool saving,  Failure? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionFormState() when $default != null:
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.date,_that.time,_that.note,_that.tags,_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  LocalDate date,  LocalTime time,  String? note,  List<String> tags,  bool saving,  Failure? failure)  $default,) {final _that = this;
switch (_that) {
case _TransactionFormState():
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.date,_that.time,_that.note,_that.tags,_that.saving,_that.failure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? editingId,  TransactionType type,  String expression,  int? amount,  String? categoryId,  String? firstCategoryId,  String accountId,  String? toAccountId,  LocalDate date,  LocalTime time,  String? note,  List<String> tags,  bool saving,  Failure? failure)?  $default,) {final _that = this;
switch (_that) {
case _TransactionFormState() when $default != null:
return $default(_that.editingId,_that.type,_that.expression,_that.amount,_that.categoryId,_that.firstCategoryId,_that.accountId,_that.toAccountId,_that.date,_that.time,_that.note,_that.tags,_that.saving,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionFormState extends TransactionFormState {
  const _TransactionFormState({this.editingId, required this.type, this.expression = '', this.amount, this.categoryId, this.firstCategoryId, required this.accountId, this.toAccountId, required this.date, required this.time, this.note,  List<String> tags = const <String>[], this.saving = false, this.failure}): _tags = tags,super._();
  

/// Set when editing an existing transaction.
@override final  String? editingId;
@override final  TransactionType type;
/// Keypad text, e.g. `25000+12500`.
@override@JsonKey() final  String expression;
/// [expression] evaluated; null while empty or invalid.
@override final  int? amount;
@override final  String? categoryId;
/// The last-used category, shown first in the grid.
@override final  String? firstCategoryId;
@override final  String accountId;
/// Transfers only: the destination account.
@override final  String? toAccountId;
@override final  LocalDate date;
@override final  LocalTime time;
@override final  String? note;
/// Tag names (PRD US-15).
 final  List<String> _tags;
/// Tag names (PRD US-15).
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool saving;
@override final  Failure? failure;

/// Create a copy of TransactionFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFormStateCopyWith<_TransactionFormState> get copyWith => __$TransactionFormStateCopyWithImpl<_TransactionFormState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFormState&&(identical(other.editingId, editingId) || other.editingId == editingId)&&(identical(other.type, type) || other.type == type)&&(identical(other.expression, expression) || other.expression == expression)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.firstCategoryId, firstCategoryId) || other.firstCategoryId == firstCategoryId)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,editingId,type,expression,amount,categoryId,firstCategoryId,accountId,toAccountId,date,time,note,const DeepCollectionEquality().hash(_tags),saving,failure);

@override
String toString() {
  return 'TransactionFormState(editingId: $editingId, type: $type, expression: $expression, amount: $amount, categoryId: $categoryId, firstCategoryId: $firstCategoryId, accountId: $accountId, toAccountId: $toAccountId, date: $date, time: $time, note: $note, tags: $tags, saving: $saving, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$TransactionFormStateCopyWith<$Res> implements $TransactionFormStateCopyWith<$Res> {
  factory _$TransactionFormStateCopyWith(_TransactionFormState value, $Res Function(_TransactionFormState) _then) = __$TransactionFormStateCopyWithImpl;
@override @useResult
$Res call({
 String? editingId, TransactionType type, String expression, int? amount, String? categoryId, String? firstCategoryId, String accountId, String? toAccountId, LocalDate date, LocalTime time, String? note, List<String> tags, bool saving, Failure? failure
});


@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$TransactionFormStateCopyWithImpl<$Res>
    implements _$TransactionFormStateCopyWith<$Res> {
  __$TransactionFormStateCopyWithImpl(this._self, this._then);

  final _TransactionFormState _self;
  final $Res Function(_TransactionFormState) _then;

/// Create a copy of TransactionFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? editingId = freezed,Object? type = null,Object? expression = null,Object? amount = freezed,Object? categoryId = freezed,Object? firstCategoryId = freezed,Object? accountId = null,Object? toAccountId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? tags = null,Object? saving = null,Object? failure = freezed,}) {
  return _then(_TransactionFormState(
editingId: freezed == editingId ? _self.editingId : editingId // ignore: cast_nullable_to_non_nullable
as String?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as TransactionType,expression: null == expression ? _self.expression : expression // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,firstCategoryId: freezed == firstCategoryId ? _self.firstCategoryId : firstCategoryId // ignore: cast_nullable_to_non_nullable
as String?,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as LocalTime,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,
  ));
}

/// Create a copy of TransactionFormState
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

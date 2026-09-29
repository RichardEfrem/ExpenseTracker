// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_occurrence.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PendingOccurrence {

 String get id; String get ruleId; LocalDate get date; DateTime get createdAt;
/// Create a copy of PendingOccurrence
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingOccurrenceCopyWith<PendingOccurrence> get copyWith => _$PendingOccurrenceCopyWithImpl<PendingOccurrence>(this as PendingOccurrence, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingOccurrence&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleId,date,createdAt);

@override
String toString() {
  return 'PendingOccurrence(id: $id, ruleId: $ruleId, date: $date, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PendingOccurrenceCopyWith<$Res>  {
  factory $PendingOccurrenceCopyWith(PendingOccurrence value, $Res Function(PendingOccurrence) _then) = _$PendingOccurrenceCopyWithImpl;
@useResult
$Res call({
 String id, String ruleId, LocalDate date, DateTime createdAt
});




}
/// @nodoc
class _$PendingOccurrenceCopyWithImpl<$Res>
    implements $PendingOccurrenceCopyWith<$Res> {
  _$PendingOccurrenceCopyWithImpl(this._self, this._then);

  final PendingOccurrence _self;
  final $Res Function(PendingOccurrence) _then;

/// Create a copy of PendingOccurrence
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruleId = null,Object? date = null,Object? createdAt = null,}) {
  return _then(PendingOccurrence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingOccurrence].
extension PendingOccurrencePatterns on PendingOccurrence {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingOccurrence value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingOccurrence() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingOccurrence value)  $default,){
final _that = this;
switch (_that) {
case _PendingOccurrence():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingOccurrence value)?  $default,){
final _that = this;
switch (_that) {
case _PendingOccurrence() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleId,  LocalDate date,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingOccurrence() when $default != null:
return $default(_that.id,_that.ruleId,_that.date,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleId,  LocalDate date,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _PendingOccurrence():
return $default(_that.id,_that.ruleId,_that.date,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleId,  LocalDate date,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PendingOccurrence() when $default != null:
return $default(_that.id,_that.ruleId,_that.date,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _PendingOccurrence implements PendingOccurrence {
  const _PendingOccurrence({required this.id, required this.ruleId, required this.date, required this.createdAt});
  

@override final  String id;
@override final  String ruleId;
@override final  LocalDate date;
@override final  DateTime createdAt;

/// Create a copy of PendingOccurrence
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingOccurrenceCopyWith<_PendingOccurrence> get copyWith => __$PendingOccurrenceCopyWithImpl<_PendingOccurrence>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingOccurrence&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,ruleId,date,createdAt);

@override
String toString() {
  return 'PendingOccurrence(id: $id, ruleId: $ruleId, date: $date, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PendingOccurrenceCopyWith<$Res> implements $PendingOccurrenceCopyWith<$Res> {
  factory _$PendingOccurrenceCopyWith(_PendingOccurrence value, $Res Function(_PendingOccurrence) _then) = __$PendingOccurrenceCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleId, LocalDate date, DateTime createdAt
});




}
/// @nodoc
class __$PendingOccurrenceCopyWithImpl<$Res>
    implements _$PendingOccurrenceCopyWith<$Res> {
  __$PendingOccurrenceCopyWithImpl(this._self, this._then);

  final _PendingOccurrence _self;
  final $Res Function(_PendingOccurrence) _then;

/// Create a copy of PendingOccurrence
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleId = null,Object? date = null,Object? createdAt = null,}) {
  return _then(_PendingOccurrence(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as LocalDate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$RuleView {

 RecurringRule get rule; Category? get category; Account get account; Account? get toAccount;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleView&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount));
}


@override
int get hashCode => Object.hash(runtimeType,rule,category,account,toAccount);

@override
String toString() {
  return 'RuleView(rule: $rule, category: $category, account: $account, toAccount: $toAccount)';
}


}




/// Adds pattern-matching-related methods to [RuleView].
extension RuleViewPatterns on RuleView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleView value)  $default,){
final _that = this;
switch (_that) {
case _RuleView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleView value)?  $default,){
final _that = this;
switch (_that) {
case _RuleView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurringRule rule,  Category? category,  Account account,  Account? toAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleView() when $default != null:
return $default(_that.rule,_that.category,_that.account,_that.toAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurringRule rule,  Category? category,  Account account,  Account? toAccount)  $default,) {final _that = this;
switch (_that) {
case _RuleView():
return $default(_that.rule,_that.category,_that.account,_that.toAccount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurringRule rule,  Category? category,  Account account,  Account? toAccount)?  $default,) {final _that = this;
switch (_that) {
case _RuleView() when $default != null:
return $default(_that.rule,_that.category,_that.account,_that.toAccount);case _:
  return null;

}
}

}

/// @nodoc


class _RuleView implements RuleView {
  const _RuleView({required this.rule, this.category, required this.account, this.toAccount});
  

@override final  RecurringRule rule;
@override final  Category? category;
@override final  Account account;
@override final  Account? toAccount;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleView&&(identical(other.rule, rule) || other.rule == rule)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount));
}


@override
int get hashCode => Object.hash(runtimeType,rule,category,account,toAccount);

@override
String toString() {
  return 'RuleView(rule: $rule, category: $category, account: $account, toAccount: $toAccount)';
}


}




/// @nodoc
mixin _$PendingView {

 PendingOccurrence get pending; RuleView get rule;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingView&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rule, rule) || other.rule == rule));
}


@override
int get hashCode => Object.hash(runtimeType,pending,rule);

@override
String toString() {
  return 'PendingView(pending: $pending, rule: $rule)';
}


}




/// Adds pattern-matching-related methods to [PendingView].
extension PendingViewPatterns on PendingView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingView value)  $default,){
final _that = this;
switch (_that) {
case _PendingView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingView value)?  $default,){
final _that = this;
switch (_that) {
case _PendingView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PendingOccurrence pending,  RuleView rule)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingView() when $default != null:
return $default(_that.pending,_that.rule);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PendingOccurrence pending,  RuleView rule)  $default,) {final _that = this;
switch (_that) {
case _PendingView():
return $default(_that.pending,_that.rule);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PendingOccurrence pending,  RuleView rule)?  $default,) {final _that = this;
switch (_that) {
case _PendingView() when $default != null:
return $default(_that.pending,_that.rule);case _:
  return null;

}
}

}

/// @nodoc


class _PendingView implements PendingView {
  const _PendingView({required this.pending, required this.rule});
  

@override final  PendingOccurrence pending;
@override final  RuleView rule;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingView&&(identical(other.pending, pending) || other.pending == pending)&&(identical(other.rule, rule) || other.rule == rule));
}


@override
int get hashCode => Object.hash(runtimeType,pending,rule);

@override
String toString() {
  return 'PendingView(pending: $pending, rule: $rule)';
}


}




/// @nodoc
mixin _$RuleGeneration {

 RecurringRule get rule;/// Due dates to create (auto) or queue (pending).
 List<LocalDate> get dates;/// The rule's new last-generated date.
 LocalDate get through;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RuleGeneration&&(identical(other.rule, rule) || other.rule == rule)&&const DeepCollectionEquality().equals(other.dates, dates)&&(identical(other.through, through) || other.through == through));
}


@override
int get hashCode => Object.hash(runtimeType,rule,const DeepCollectionEquality().hash(dates),through);

@override
String toString() {
  return 'RuleGeneration(rule: $rule, dates: $dates, through: $through)';
}


}




/// Adds pattern-matching-related methods to [RuleGeneration].
extension RuleGenerationPatterns on RuleGeneration {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RuleGeneration value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RuleGeneration() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RuleGeneration value)  $default,){
final _that = this;
switch (_that) {
case _RuleGeneration():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RuleGeneration value)?  $default,){
final _that = this;
switch (_that) {
case _RuleGeneration() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurringRule rule,  List<LocalDate> dates,  LocalDate through)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RuleGeneration() when $default != null:
return $default(_that.rule,_that.dates,_that.through);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurringRule rule,  List<LocalDate> dates,  LocalDate through)  $default,) {final _that = this;
switch (_that) {
case _RuleGeneration():
return $default(_that.rule,_that.dates,_that.through);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurringRule rule,  List<LocalDate> dates,  LocalDate through)?  $default,) {final _that = this;
switch (_that) {
case _RuleGeneration() when $default != null:
return $default(_that.rule,_that.dates,_that.through);case _:
  return null;

}
}

}

/// @nodoc


class _RuleGeneration implements RuleGeneration {
  const _RuleGeneration({required this.rule, required  List<LocalDate> dates, required this.through}): _dates = dates;
  

@override final  RecurringRule rule;
/// Due dates to create (auto) or queue (pending).
 final  List<LocalDate> _dates;
/// Due dates to create (auto) or queue (pending).
@override List<LocalDate> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

/// The rule's new last-generated date.
@override final  LocalDate through;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RuleGeneration&&(identical(other.rule, rule) || other.rule == rule)&&const DeepCollectionEquality().equals(other._dates, _dates)&&(identical(other.through, through) || other.through == through));
}


@override
int get hashCode => Object.hash(runtimeType,rule,const DeepCollectionEquality().hash(_dates),through);

@override
String toString() {
  return 'RuleGeneration(rule: $rule, dates: $dates, through: $through)';
}


}




/// @nodoc
mixin _$GenerationResult {

 int get created; int get pending;
/// Create a copy of GenerationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GenerationResultCopyWith<GenerationResult> get copyWith => _$GenerationResultCopyWithImpl<GenerationResult>(this as GenerationResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GenerationResult&&(identical(other.created, created) || other.created == created)&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,created,pending);

@override
String toString() {
  return 'GenerationResult(created: $created, pending: $pending)';
}


}

/// @nodoc
abstract mixin class $GenerationResultCopyWith<$Res>  {
  factory $GenerationResultCopyWith(GenerationResult value, $Res Function(GenerationResult) _then) = _$GenerationResultCopyWithImpl;
@useResult
$Res call({
 int created, int pending
});




}
/// @nodoc
class _$GenerationResultCopyWithImpl<$Res>
    implements $GenerationResultCopyWith<$Res> {
  _$GenerationResultCopyWithImpl(this._self, this._then);

  final GenerationResult _self;
  final $Res Function(GenerationResult) _then;

/// Create a copy of GenerationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? created = null,Object? pending = null,}) {
  return _then(GenerationResult(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [GenerationResult].
extension GenerationResultPatterns on GenerationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GenerationResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GenerationResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GenerationResult value)  $default,){
final _that = this;
switch (_that) {
case _GenerationResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GenerationResult value)?  $default,){
final _that = this;
switch (_that) {
case _GenerationResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int created,  int pending)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GenerationResult() when $default != null:
return $default(_that.created,_that.pending);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int created,  int pending)  $default,) {final _that = this;
switch (_that) {
case _GenerationResult():
return $default(_that.created,_that.pending);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int created,  int pending)?  $default,) {final _that = this;
switch (_that) {
case _GenerationResult() when $default != null:
return $default(_that.created,_that.pending);case _:
  return null;

}
}

}

/// @nodoc


class _GenerationResult implements GenerationResult {
  const _GenerationResult({this.created = 0, this.pending = 0});
  

@override@JsonKey() final  int created;
@override@JsonKey() final  int pending;

/// Create a copy of GenerationResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GenerationResultCopyWith<_GenerationResult> get copyWith => __$GenerationResultCopyWithImpl<_GenerationResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GenerationResult&&(identical(other.created, created) || other.created == created)&&(identical(other.pending, pending) || other.pending == pending));
}


@override
int get hashCode => Object.hash(runtimeType,created,pending);

@override
String toString() {
  return 'GenerationResult(created: $created, pending: $pending)';
}


}

/// @nodoc
abstract mixin class _$GenerationResultCopyWith<$Res> implements $GenerationResultCopyWith<$Res> {
  factory _$GenerationResultCopyWith(_GenerationResult value, $Res Function(_GenerationResult) _then) = __$GenerationResultCopyWithImpl;
@override @useResult
$Res call({
 int created, int pending
});




}
/// @nodoc
class __$GenerationResultCopyWithImpl<$Res>
    implements _$GenerationResultCopyWith<$Res> {
  __$GenerationResultCopyWithImpl(this._self, this._then);

  final _GenerationResult _self;
  final $Res Function(_GenerationResult) _then;

/// Create a copy of GenerationResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? created = null,Object? pending = null,}) {
  return _then(_GenerationResult(
created: null == created ? _self.created : created // ignore: cast_nullable_to_non_nullable
as int,pending: null == pending ? _self.pending : pending // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

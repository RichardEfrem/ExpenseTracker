// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupPreview {

 int get transactions; int get accounts; int get categories; int get recurringRules; LocalDate? get firstDate; LocalDate? get lastDate; DateTime get exportedAt;
/// Create a copy of BackupPreview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupPreviewCopyWith<BackupPreview> get copyWith => _$BackupPreviewCopyWithImpl<BackupPreview>(this as BackupPreview, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupPreview&&(identical(other.transactions, transactions) || other.transactions == transactions)&&(identical(other.accounts, accounts) || other.accounts == accounts)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.recurringRules, recurringRules) || other.recurringRules == recurringRules)&&(identical(other.firstDate, firstDate) || other.firstDate == firstDate)&&(identical(other.lastDate, lastDate) || other.lastDate == lastDate)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt));
}


@override
int get hashCode => Object.hash(runtimeType,transactions,accounts,categories,recurringRules,firstDate,lastDate,exportedAt);

@override
String toString() {
  return 'BackupPreview(transactions: $transactions, accounts: $accounts, categories: $categories, recurringRules: $recurringRules, firstDate: $firstDate, lastDate: $lastDate, exportedAt: $exportedAt)';
}


}

/// @nodoc
abstract mixin class $BackupPreviewCopyWith<$Res>  {
  factory $BackupPreviewCopyWith(BackupPreview value, $Res Function(BackupPreview) _then) = _$BackupPreviewCopyWithImpl;
@useResult
$Res call({
 int transactions, int accounts, int categories, int recurringRules, LocalDate? firstDate, LocalDate? lastDate, DateTime exportedAt
});




}
/// @nodoc
class _$BackupPreviewCopyWithImpl<$Res>
    implements $BackupPreviewCopyWith<$Res> {
  _$BackupPreviewCopyWithImpl(this._self, this._then);

  final BackupPreview _self;
  final $Res Function(BackupPreview) _then;

/// Create a copy of BackupPreview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transactions = null,Object? accounts = null,Object? categories = null,Object? recurringRules = null,Object? firstDate = freezed,Object? lastDate = freezed,Object? exportedAt = null,}) {
  return _then(BackupPreview(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as int,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as int,recurringRules: null == recurringRules ? _self.recurringRules : recurringRules // ignore: cast_nullable_to_non_nullable
as int,firstDate: freezed == firstDate ? _self.firstDate : firstDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,lastDate: freezed == lastDate ? _self.lastDate : lastDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupPreview].
extension BackupPreviewPatterns on BackupPreview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupPreview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupPreview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupPreview value)  $default,){
final _that = this;
switch (_that) {
case _BackupPreview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupPreview value)?  $default,){
final _that = this;
switch (_that) {
case _BackupPreview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int transactions,  int accounts,  int categories,  int recurringRules,  LocalDate? firstDate,  LocalDate? lastDate,  DateTime exportedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupPreview() when $default != null:
return $default(_that.transactions,_that.accounts,_that.categories,_that.recurringRules,_that.firstDate,_that.lastDate,_that.exportedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int transactions,  int accounts,  int categories,  int recurringRules,  LocalDate? firstDate,  LocalDate? lastDate,  DateTime exportedAt)  $default,) {final _that = this;
switch (_that) {
case _BackupPreview():
return $default(_that.transactions,_that.accounts,_that.categories,_that.recurringRules,_that.firstDate,_that.lastDate,_that.exportedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int transactions,  int accounts,  int categories,  int recurringRules,  LocalDate? firstDate,  LocalDate? lastDate,  DateTime exportedAt)?  $default,) {final _that = this;
switch (_that) {
case _BackupPreview() when $default != null:
return $default(_that.transactions,_that.accounts,_that.categories,_that.recurringRules,_that.firstDate,_that.lastDate,_that.exportedAt);case _:
  return null;

}
}

}

/// @nodoc


class _BackupPreview implements BackupPreview {
  const _BackupPreview({required this.transactions, required this.accounts, required this.categories, this.recurringRules = 0, this.firstDate, this.lastDate, required this.exportedAt});
  

@override final  int transactions;
@override final  int accounts;
@override final  int categories;
@override@JsonKey() final  int recurringRules;
@override final  LocalDate? firstDate;
@override final  LocalDate? lastDate;
@override final  DateTime exportedAt;

/// Create a copy of BackupPreview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupPreviewCopyWith<_BackupPreview> get copyWith => __$BackupPreviewCopyWithImpl<_BackupPreview>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupPreview&&(identical(other.transactions, transactions) || other.transactions == transactions)&&(identical(other.accounts, accounts) || other.accounts == accounts)&&(identical(other.categories, categories) || other.categories == categories)&&(identical(other.recurringRules, recurringRules) || other.recurringRules == recurringRules)&&(identical(other.firstDate, firstDate) || other.firstDate == firstDate)&&(identical(other.lastDate, lastDate) || other.lastDate == lastDate)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt));
}


@override
int get hashCode => Object.hash(runtimeType,transactions,accounts,categories,recurringRules,firstDate,lastDate,exportedAt);

@override
String toString() {
  return 'BackupPreview(transactions: $transactions, accounts: $accounts, categories: $categories, recurringRules: $recurringRules, firstDate: $firstDate, lastDate: $lastDate, exportedAt: $exportedAt)';
}


}

/// @nodoc
abstract mixin class _$BackupPreviewCopyWith<$Res> implements $BackupPreviewCopyWith<$Res> {
  factory _$BackupPreviewCopyWith(_BackupPreview value, $Res Function(_BackupPreview) _then) = __$BackupPreviewCopyWithImpl;
@override @useResult
$Res call({
 int transactions, int accounts, int categories, int recurringRules, LocalDate? firstDate, LocalDate? lastDate, DateTime exportedAt
});




}
/// @nodoc
class __$BackupPreviewCopyWithImpl<$Res>
    implements _$BackupPreviewCopyWith<$Res> {
  __$BackupPreviewCopyWithImpl(this._self, this._then);

  final _BackupPreview _self;
  final $Res Function(_BackupPreview) _then;

/// Create a copy of BackupPreview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transactions = null,Object? accounts = null,Object? categories = null,Object? recurringRules = null,Object? firstDate = freezed,Object? lastDate = freezed,Object? exportedAt = null,}) {
  return _then(_BackupPreview(
transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as int,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as int,recurringRules: null == recurringRules ? _self.recurringRules : recurringRules // ignore: cast_nullable_to_non_nullable
as int,firstDate: freezed == firstDate ? _self.firstDate : firstDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,lastDate: freezed == lastDate ? _self.lastDate : lastDate // ignore: cast_nullable_to_non_nullable
as LocalDate?,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc
mixin _$BackupFile {

 int get schemaVersion; String get appVersion; DateTime get exportedAt; List<Account> get accounts; List<Category> get categories; List<Transaction> get transactions;/// Schema v2 on; empty when restoring a v1 file.
 List<RecurringRule> get recurringRules; List<PendingOccurrence> get pendingOccurrences;/// Preferences and small app state, key → value.
 Map<String, String> get settings;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupFile&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.recurringRules, recurringRules)&&const DeepCollectionEquality().equals(other.pendingOccurrences, pendingOccurrences)&&const DeepCollectionEquality().equals(other.settings, settings));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,appVersion,exportedAt,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(recurringRules),const DeepCollectionEquality().hash(pendingOccurrences),const DeepCollectionEquality().hash(settings));

@override
String toString() {
  return 'BackupFile(schemaVersion: $schemaVersion, appVersion: $appVersion, exportedAt: $exportedAt, accounts: $accounts, categories: $categories, transactions: $transactions, recurringRules: $recurringRules, pendingOccurrences: $pendingOccurrences, settings: $settings)';
}


}




/// Adds pattern-matching-related methods to [BackupFile].
extension BackupFilePatterns on BackupFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupFile value)  $default,){
final _that = this;
switch (_that) {
case _BackupFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupFile value)?  $default,){
final _that = this;
switch (_that) {
case _BackupFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int schemaVersion,  String appVersion,  DateTime exportedAt,  List<Account> accounts,  List<Category> categories,  List<Transaction> transactions,  List<RecurringRule> recurringRules,  List<PendingOccurrence> pendingOccurrences,  Map<String, String> settings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupFile() when $default != null:
return $default(_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int schemaVersion,  String appVersion,  DateTime exportedAt,  List<Account> accounts,  List<Category> categories,  List<Transaction> transactions,  List<RecurringRule> recurringRules,  List<PendingOccurrence> pendingOccurrences,  Map<String, String> settings)  $default,) {final _that = this;
switch (_that) {
case _BackupFile():
return $default(_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int schemaVersion,  String appVersion,  DateTime exportedAt,  List<Account> accounts,  List<Category> categories,  List<Transaction> transactions,  List<RecurringRule> recurringRules,  List<PendingOccurrence> pendingOccurrences,  Map<String, String> settings)?  $default,) {final _that = this;
switch (_that) {
case _BackupFile() when $default != null:
return $default(_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
  return null;

}
}

}

/// @nodoc


class _BackupFile extends BackupFile {
  const _BackupFile({required this.schemaVersion, required this.appVersion, required this.exportedAt, required  List<Account> accounts, required  List<Category> categories, required  List<Transaction> transactions,  List<RecurringRule> recurringRules = const [],  List<PendingOccurrence> pendingOccurrences = const [], required  Map<String, String> settings}): _accounts = accounts,_categories = categories,_transactions = transactions,_recurringRules = recurringRules,_pendingOccurrences = pendingOccurrences,_settings = settings,super._();
  

@override final  int schemaVersion;
@override final  String appVersion;
@override final  DateTime exportedAt;
 final  List<Account> _accounts;
@override List<Account> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<Category> _categories;
@override List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<Transaction> _transactions;
@override List<Transaction> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

/// Schema v2 on; empty when restoring a v1 file.
 final  List<RecurringRule> _recurringRules;
/// Schema v2 on; empty when restoring a v1 file.
@override@JsonKey() List<RecurringRule> get recurringRules {
  if (_recurringRules is EqualUnmodifiableListView) return _recurringRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurringRules);
}

 final  List<PendingOccurrence> _pendingOccurrences;
@override@JsonKey() List<PendingOccurrence> get pendingOccurrences {
  if (_pendingOccurrences is EqualUnmodifiableListView) return _pendingOccurrences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingOccurrences);
}

/// Preferences and small app state, key → value.
 final  Map<String, String> _settings;
/// Preferences and small app state, key → value.
@override Map<String, String> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupFile&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._recurringRules, _recurringRules)&&const DeepCollectionEquality().equals(other._pendingOccurrences, _pendingOccurrences)&&const DeepCollectionEquality().equals(other._settings, _settings));
}


@override
int get hashCode => Object.hash(runtimeType,schemaVersion,appVersion,exportedAt,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_recurringRules),const DeepCollectionEquality().hash(_pendingOccurrences),const DeepCollectionEquality().hash(_settings));

@override
String toString() {
  return 'BackupFile(schemaVersion: $schemaVersion, appVersion: $appVersion, exportedAt: $exportedAt, accounts: $accounts, categories: $categories, transactions: $transactions, recurringRules: $recurringRules, pendingOccurrences: $pendingOccurrences, settings: $settings)';
}


}




// dart format on

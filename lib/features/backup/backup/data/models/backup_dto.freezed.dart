// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupFileDto {

 String get format; int get schemaVersion; String get appVersion;/// ISO 8601, UTC.
 String get exportedAt; List<AccountDto> get accounts; List<CategoryDto> get categories; List<TransactionDto> get transactions; List<RecurringRuleDto> get recurringRules; List<PendingOccurrenceDto> get pendingOccurrences; Map<String, String> get settings;
/// Create a copy of BackupFileDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupFileDtoCopyWith<BackupFileDto> get copyWith => _$BackupFileDtoCopyWithImpl<BackupFileDto>(this as BackupFileDto, _$identity);

  /// Serializes this BackupFileDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupFileDto&&(identical(other.format, format) || other.format == format)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other.accounts, accounts)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.transactions, transactions)&&const DeepCollectionEquality().equals(other.recurringRules, recurringRules)&&const DeepCollectionEquality().equals(other.pendingOccurrences, pendingOccurrences)&&const DeepCollectionEquality().equals(other.settings, settings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,schemaVersion,appVersion,exportedAt,const DeepCollectionEquality().hash(accounts),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(transactions),const DeepCollectionEquality().hash(recurringRules),const DeepCollectionEquality().hash(pendingOccurrences),const DeepCollectionEquality().hash(settings));

@override
String toString() {
  return 'BackupFileDto(format: $format, schemaVersion: $schemaVersion, appVersion: $appVersion, exportedAt: $exportedAt, accounts: $accounts, categories: $categories, transactions: $transactions, recurringRules: $recurringRules, pendingOccurrences: $pendingOccurrences, settings: $settings)';
}


}

/// @nodoc
abstract mixin class $BackupFileDtoCopyWith<$Res>  {
  factory $BackupFileDtoCopyWith(BackupFileDto value, $Res Function(BackupFileDto) _then) = _$BackupFileDtoCopyWithImpl;
@useResult
$Res call({
 String format, int schemaVersion, String appVersion, String exportedAt, List<AccountDto> accounts, List<CategoryDto> categories, List<TransactionDto> transactions, List<RecurringRuleDto> recurringRules, List<PendingOccurrenceDto> pendingOccurrences, Map<String, String> settings
});




}
/// @nodoc
class _$BackupFileDtoCopyWithImpl<$Res>
    implements $BackupFileDtoCopyWith<$Res> {
  _$BackupFileDtoCopyWithImpl(this._self, this._then);

  final BackupFileDto _self;
  final $Res Function(BackupFileDto) _then;

/// Create a copy of BackupFileDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? format = null,Object? schemaVersion = null,Object? appVersion = null,Object? exportedAt = null,Object? accounts = null,Object? categories = null,Object? transactions = null,Object? recurringRules = null,Object? pendingOccurrences = null,Object? settings = null,}) {
  return _then(BackupFileDto(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self.accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountDto>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,transactions: null == transactions ? _self.transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionDto>,recurringRules: null == recurringRules ? _self.recurringRules : recurringRules // ignore: cast_nullable_to_non_nullable
as List<RecurringRuleDto>,pendingOccurrences: null == pendingOccurrences ? _self.pendingOccurrences : pendingOccurrences // ignore: cast_nullable_to_non_nullable
as List<PendingOccurrenceDto>,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupFileDto].
extension BackupFileDtoPatterns on BackupFileDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupFileDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupFileDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupFileDto value)  $default,){
final _that = this;
switch (_that) {
case _BackupFileDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupFileDto value)?  $default,){
final _that = this;
switch (_that) {
case _BackupFileDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String format,  int schemaVersion,  String appVersion,  String exportedAt,  List<AccountDto> accounts,  List<CategoryDto> categories,  List<TransactionDto> transactions,  List<RecurringRuleDto> recurringRules,  List<PendingOccurrenceDto> pendingOccurrences,  Map<String, String> settings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupFileDto() when $default != null:
return $default(_that.format,_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String format,  int schemaVersion,  String appVersion,  String exportedAt,  List<AccountDto> accounts,  List<CategoryDto> categories,  List<TransactionDto> transactions,  List<RecurringRuleDto> recurringRules,  List<PendingOccurrenceDto> pendingOccurrences,  Map<String, String> settings)  $default,) {final _that = this;
switch (_that) {
case _BackupFileDto():
return $default(_that.format,_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String format,  int schemaVersion,  String appVersion,  String exportedAt,  List<AccountDto> accounts,  List<CategoryDto> categories,  List<TransactionDto> transactions,  List<RecurringRuleDto> recurringRules,  List<PendingOccurrenceDto> pendingOccurrences,  Map<String, String> settings)?  $default,) {final _that = this;
switch (_that) {
case _BackupFileDto() when $default != null:
return $default(_that.format,_that.schemaVersion,_that.appVersion,_that.exportedAt,_that.accounts,_that.categories,_that.transactions,_that.recurringRules,_that.pendingOccurrences,_that.settings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupFileDto implements BackupFileDto {
  const _BackupFileDto({this.format = backupFormat, required this.schemaVersion, required this.appVersion, required this.exportedAt, required  List<AccountDto> accounts, required  List<CategoryDto> categories, required  List<TransactionDto> transactions,  List<RecurringRuleDto> recurringRules = const [],  List<PendingOccurrenceDto> pendingOccurrences = const [], required  Map<String, String> settings}): _accounts = accounts,_categories = categories,_transactions = transactions,_recurringRules = recurringRules,_pendingOccurrences = pendingOccurrences,_settings = settings;
  factory _BackupFileDto.fromJson(Map<String, dynamic> json) => _$BackupFileDtoFromJson(json);

@override@JsonKey() final  String format;
@override final  int schemaVersion;
@override final  String appVersion;
/// ISO 8601, UTC.
@override final  String exportedAt;
 final  List<AccountDto> _accounts;
@override List<AccountDto> get accounts {
  if (_accounts is EqualUnmodifiableListView) return _accounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_accounts);
}

 final  List<CategoryDto> _categories;
@override List<CategoryDto> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<TransactionDto> _transactions;
@override List<TransactionDto> get transactions {
  if (_transactions is EqualUnmodifiableListView) return _transactions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_transactions);
}

 final  List<RecurringRuleDto> _recurringRules;
@override@JsonKey() List<RecurringRuleDto> get recurringRules {
  if (_recurringRules is EqualUnmodifiableListView) return _recurringRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recurringRules);
}

 final  List<PendingOccurrenceDto> _pendingOccurrences;
@override@JsonKey() List<PendingOccurrenceDto> get pendingOccurrences {
  if (_pendingOccurrences is EqualUnmodifiableListView) return _pendingOccurrences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_pendingOccurrences);
}

 final  Map<String, String> _settings;
@override Map<String, String> get settings {
  if (_settings is EqualUnmodifiableMapView) return _settings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_settings);
}


/// Create a copy of BackupFileDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupFileDtoCopyWith<_BackupFileDto> get copyWith => __$BackupFileDtoCopyWithImpl<_BackupFileDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupFileDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupFileDto&&(identical(other.format, format) || other.format == format)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&(identical(other.appVersion, appVersion) || other.appVersion == appVersion)&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&const DeepCollectionEquality().equals(other._accounts, _accounts)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._transactions, _transactions)&&const DeepCollectionEquality().equals(other._recurringRules, _recurringRules)&&const DeepCollectionEquality().equals(other._pendingOccurrences, _pendingOccurrences)&&const DeepCollectionEquality().equals(other._settings, _settings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,format,schemaVersion,appVersion,exportedAt,const DeepCollectionEquality().hash(_accounts),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_transactions),const DeepCollectionEquality().hash(_recurringRules),const DeepCollectionEquality().hash(_pendingOccurrences),const DeepCollectionEquality().hash(_settings));

@override
String toString() {
  return 'BackupFileDto(format: $format, schemaVersion: $schemaVersion, appVersion: $appVersion, exportedAt: $exportedAt, accounts: $accounts, categories: $categories, transactions: $transactions, recurringRules: $recurringRules, pendingOccurrences: $pendingOccurrences, settings: $settings)';
}


}

/// @nodoc
abstract mixin class _$BackupFileDtoCopyWith<$Res> implements $BackupFileDtoCopyWith<$Res> {
  factory _$BackupFileDtoCopyWith(_BackupFileDto value, $Res Function(_BackupFileDto) _then) = __$BackupFileDtoCopyWithImpl;
@override @useResult
$Res call({
 String format, int schemaVersion, String appVersion, String exportedAt, List<AccountDto> accounts, List<CategoryDto> categories, List<TransactionDto> transactions, List<RecurringRuleDto> recurringRules, List<PendingOccurrenceDto> pendingOccurrences, Map<String, String> settings
});




}
/// @nodoc
class __$BackupFileDtoCopyWithImpl<$Res>
    implements _$BackupFileDtoCopyWith<$Res> {
  __$BackupFileDtoCopyWithImpl(this._self, this._then);

  final _BackupFileDto _self;
  final $Res Function(_BackupFileDto) _then;

/// Create a copy of BackupFileDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? format = null,Object? schemaVersion = null,Object? appVersion = null,Object? exportedAt = null,Object? accounts = null,Object? categories = null,Object? transactions = null,Object? recurringRules = null,Object? pendingOccurrences = null,Object? settings = null,}) {
  return _then(_BackupFileDto(
format: null == format ? _self.format : format // ignore: cast_nullable_to_non_nullable
as String,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,appVersion: null == appVersion ? _self.appVersion : appVersion // ignore: cast_nullable_to_non_nullable
as String,exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as String,accounts: null == accounts ? _self._accounts : accounts // ignore: cast_nullable_to_non_nullable
as List<AccountDto>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryDto>,transactions: null == transactions ? _self._transactions : transactions // ignore: cast_nullable_to_non_nullable
as List<TransactionDto>,recurringRules: null == recurringRules ? _self._recurringRules : recurringRules // ignore: cast_nullable_to_non_nullable
as List<RecurringRuleDto>,pendingOccurrences: null == pendingOccurrences ? _self._pendingOccurrences : pendingOccurrences // ignore: cast_nullable_to_non_nullable
as List<PendingOccurrenceDto>,settings: null == settings ? _self._settings : settings // ignore: cast_nullable_to_non_nullable
as Map<String, String>,
  ));
}


}


/// @nodoc
mixin _$AccountDto {

 String get id; String get name; String get type; String get icon; String get color; int get openingBalance; bool get isArchived; int get sortOrder; int get createdAt; int get updatedAt;
/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDtoCopyWith<AccountDto> get copyWith => _$AccountDtoCopyWithImpl<AccountDto>(this as AccountDto, _$identity);

  /// Serializes this AccountDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,icon,color,openingBalance,isArchived,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'AccountDto(id: $id, name: $name, type: $type, icon: $icon, color: $color, openingBalance: $openingBalance, isArchived: $isArchived, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $AccountDtoCopyWith<$Res>  {
  factory $AccountDtoCopyWith(AccountDto value, $Res Function(AccountDto) _then) = _$AccountDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String icon, String color, int openingBalance, bool isArchived, int sortOrder, int createdAt, int updatedAt
});




}
/// @nodoc
class _$AccountDtoCopyWithImpl<$Res>
    implements $AccountDtoCopyWith<$Res> {
  _$AccountDtoCopyWithImpl(this._self, this._then);

  final AccountDto _self;
  final $Res Function(AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? openingBalance = null,Object? isArchived = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(AccountDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AccountDto].
extension AccountDtoPatterns on AccountDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AccountDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AccountDto value)  $default,){
final _that = this;
switch (_that) {
case _AccountDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AccountDto value)?  $default,){
final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String icon,  String color,  int openingBalance,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.openingBalance,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String icon,  String color,  int openingBalance,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)  $default,) {final _that = this;
switch (_that) {
case _AccountDto():
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.openingBalance,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String icon,  String color,  int openingBalance,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _AccountDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.openingBalance,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AccountDto extends AccountDto {
  const _AccountDto({required this.id, required this.name, required this.type, required this.icon, required this.color, required this.openingBalance, required this.isArchived, required this.sortOrder, required this.createdAt, required this.updatedAt}): super._();
  factory _AccountDto.fromJson(Map<String, dynamic> json) => _$AccountDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String icon;
@override final  String color;
@override final  int openingBalance;
@override final  bool isArchived;
@override final  int sortOrder;
@override final  int createdAt;
@override final  int updatedAt;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AccountDtoCopyWith<_AccountDto> get copyWith => __$AccountDtoCopyWithImpl<_AccountDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AccountDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AccountDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.openingBalance, openingBalance) || other.openingBalance == openingBalance)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,icon,color,openingBalance,isArchived,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'AccountDto(id: $id, name: $name, type: $type, icon: $icon, color: $color, openingBalance: $openingBalance, isArchived: $isArchived, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$AccountDtoCopyWith<$Res> implements $AccountDtoCopyWith<$Res> {
  factory _$AccountDtoCopyWith(_AccountDto value, $Res Function(_AccountDto) _then) = __$AccountDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String icon, String color, int openingBalance, bool isArchived, int sortOrder, int createdAt, int updatedAt
});




}
/// @nodoc
class __$AccountDtoCopyWithImpl<$Res>
    implements _$AccountDtoCopyWith<$Res> {
  __$AccountDtoCopyWithImpl(this._self, this._then);

  final _AccountDto _self;
  final $Res Function(_AccountDto) _then;

/// Create a copy of AccountDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? openingBalance = null,Object? isArchived = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_AccountDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,openingBalance: null == openingBalance ? _self.openingBalance : openingBalance // ignore: cast_nullable_to_non_nullable
as int,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CategoryDto {

 String get id; String get name; String get type; String get icon; String get color; bool get isArchived; int get sortOrder; int get createdAt; int get updatedAt;
/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryDtoCopyWith<CategoryDto> get copyWith => _$CategoryDtoCopyWithImpl<CategoryDto>(this as CategoryDto, _$identity);

  /// Serializes this CategoryDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,icon,color,isArchived,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'CategoryDto(id: $id, name: $name, type: $type, icon: $icon, color: $color, isArchived: $isArchived, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CategoryDtoCopyWith<$Res>  {
  factory $CategoryDtoCopyWith(CategoryDto value, $Res Function(CategoryDto) _then) = _$CategoryDtoCopyWithImpl;
@useResult
$Res call({
 String id, String name, String type, String icon, String color, bool isArchived, int sortOrder, int createdAt, int updatedAt
});




}
/// @nodoc
class _$CategoryDtoCopyWithImpl<$Res>
    implements $CategoryDtoCopyWith<$Res> {
  _$CategoryDtoCopyWithImpl(this._self, this._then);

  final CategoryDto _self;
  final $Res Function(CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? isArchived = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(CategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryDto].
extension CategoryDtoPatterns on CategoryDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryDto value)  $default,){
final _that = this;
switch (_that) {
case _CategoryDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryDto value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String icon,  String color,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String type,  String icon,  String color,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CategoryDto():
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String type,  String icon,  String color,  bool isArchived,  int sortOrder,  int createdAt,  int updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CategoryDto() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.icon,_that.color,_that.isArchived,_that.sortOrder,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CategoryDto extends CategoryDto {
  const _CategoryDto({required this.id, required this.name, required this.type, required this.icon, required this.color, required this.isArchived, required this.sortOrder, required this.createdAt, required this.updatedAt}): super._();
  factory _CategoryDto.fromJson(Map<String, dynamic> json) => _$CategoryDtoFromJson(json);

@override final  String id;
@override final  String name;
@override final  String type;
@override final  String icon;
@override final  String color;
@override final  bool isArchived;
@override final  int sortOrder;
@override final  int createdAt;
@override final  int updatedAt;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryDtoCopyWith<_CategoryDto> get copyWith => __$CategoryDtoCopyWithImpl<_CategoryDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CategoryDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryDto&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.color, color) || other.color == color)&&(identical(other.isArchived, isArchived) || other.isArchived == isArchived)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,icon,color,isArchived,sortOrder,createdAt,updatedAt);

@override
String toString() {
  return 'CategoryDto(id: $id, name: $name, type: $type, icon: $icon, color: $color, isArchived: $isArchived, sortOrder: $sortOrder, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CategoryDtoCopyWith<$Res> implements $CategoryDtoCopyWith<$Res> {
  factory _$CategoryDtoCopyWith(_CategoryDto value, $Res Function(_CategoryDto) _then) = __$CategoryDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String type, String icon, String color, bool isArchived, int sortOrder, int createdAt, int updatedAt
});




}
/// @nodoc
class __$CategoryDtoCopyWithImpl<$Res>
    implements _$CategoryDtoCopyWith<$Res> {
  __$CategoryDtoCopyWithImpl(this._self, this._then);

  final _CategoryDto _self;
  final $Res Function(_CategoryDto) _then;

/// Create a copy of CategoryDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? icon = null,Object? color = null,Object? isArchived = null,Object? sortOrder = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CategoryDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as String,isArchived: null == isArchived ? _self.isArchived : isArchived // ignore: cast_nullable_to_non_nullable
as bool,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TransactionDto {

 String get id; String get type; int get amount; String get accountId; String? get toAccountId; String? get categoryId;/// Local date, `YYYY-MM-DD`.
 String get date;/// Local time, `HH:mm`.
 String get time; String? get note; String? get recurringRuleId; String? get receiptPath; int get createdAt; int get updatedAt;
/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionDtoCopyWith<TransactionDto> get copyWith => _$TransactionDtoCopyWithImpl<TransactionDto>(this as TransactionDto, _$identity);

  /// Serializes this TransactionDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,date,time,note,recurringRuleId,receiptPath,createdAt,updatedAt);

@override
String toString() {
  return 'TransactionDto(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note, recurringRuleId: $recurringRuleId, receiptPath: $receiptPath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $TransactionDtoCopyWith<$Res>  {
  factory $TransactionDtoCopyWith(TransactionDto value, $Res Function(TransactionDto) _then) = _$TransactionDtoCopyWithImpl;
@useResult
$Res call({
 String id, String type, int amount, String accountId, String? toAccountId, String? categoryId, String date, String time, String? note, String? recurringRuleId, String? receiptPath, int createdAt, int updatedAt
});




}
/// @nodoc
class _$TransactionDtoCopyWithImpl<$Res>
    implements $TransactionDtoCopyWith<$Res> {
  _$TransactionDtoCopyWithImpl(this._self, this._then);

  final TransactionDto _self;
  final $Res Function(TransactionDto) _then;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? recurringRuleId = freezed,Object? receiptPath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(TransactionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionDto].
extension TransactionDtoPatterns on TransactionDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionDto value)  $default,){
final _that = this;
switch (_that) {
case _TransactionDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionDto value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String date,  String time,  String? note,  String? recurringRuleId,  String? receiptPath,  int createdAt,  int updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String date,  String time,  String? note,  String? recurringRuleId,  String? receiptPath,  int createdAt,  int updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TransactionDto():
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String date,  String time,  String? note,  String? recurringRuleId,  String? receiptPath,  int createdAt,  int updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TransactionDto() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.date,_that.time,_that.note,_that.recurringRuleId,_that.receiptPath,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TransactionDto extends TransactionDto {
  const _TransactionDto({required this.id, required this.type, required this.amount, required this.accountId, required this.toAccountId, required this.categoryId, required this.date, required this.time, required this.note, required this.recurringRuleId, required this.receiptPath, required this.createdAt, required this.updatedAt}): super._();
  factory _TransactionDto.fromJson(Map<String, dynamic> json) => _$TransactionDtoFromJson(json);

@override final  String id;
@override final  String type;
@override final  int amount;
@override final  String accountId;
@override final  String? toAccountId;
@override final  String? categoryId;
/// Local date, `YYYY-MM-DD`.
@override final  String date;
/// Local time, `HH:mm`.
@override final  String time;
@override final  String? note;
@override final  String? recurringRuleId;
@override final  String? receiptPath;
@override final  int createdAt;
@override final  int updatedAt;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionDtoCopyWith<_TransactionDto> get copyWith => __$TransactionDtoCopyWithImpl<_TransactionDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TransactionDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.date, date) || other.date == date)&&(identical(other.time, time) || other.time == time)&&(identical(other.note, note) || other.note == note)&&(identical(other.recurringRuleId, recurringRuleId) || other.recurringRuleId == recurringRuleId)&&(identical(other.receiptPath, receiptPath) || other.receiptPath == receiptPath)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,date,time,note,recurringRuleId,receiptPath,createdAt,updatedAt);

@override
String toString() {
  return 'TransactionDto(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, date: $date, time: $time, note: $note, recurringRuleId: $recurringRuleId, receiptPath: $receiptPath, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TransactionDtoCopyWith<$Res> implements $TransactionDtoCopyWith<$Res> {
  factory _$TransactionDtoCopyWith(_TransactionDto value, $Res Function(_TransactionDto) _then) = __$TransactionDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, int amount, String accountId, String? toAccountId, String? categoryId, String date, String time, String? note, String? recurringRuleId, String? receiptPath, int createdAt, int updatedAt
});




}
/// @nodoc
class __$TransactionDtoCopyWithImpl<$Res>
    implements _$TransactionDtoCopyWith<$Res> {
  __$TransactionDtoCopyWithImpl(this._self, this._then);

  final _TransactionDto _self;
  final $Res Function(_TransactionDto) _then;

/// Create a copy of TransactionDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? date = null,Object? time = null,Object? note = freezed,Object? recurringRuleId = freezed,Object? receiptPath = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_TransactionDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,recurringRuleId: freezed == recurringRuleId ? _self.recurringRuleId : recurringRuleId // ignore: cast_nullable_to_non_nullable
as String?,receiptPath: freezed == receiptPath ? _self.receiptPath : receiptPath // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RecurringRuleDto {

 String get id; String get type; int get amount; String get accountId; String? get toAccountId; String? get categoryId; String? get note; String get frequency; int get interval; int? get dayOfMonth;/// Local dates, `YYYY-MM-DD`.
 String get startDate; String? get endDate; bool get autoCreate; String? get lastGeneratedDate; int get createdAt; int get updatedAt;
/// Create a copy of RecurringRuleDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurringRuleDtoCopyWith<RecurringRuleDto> get copyWith => _$RecurringRuleDtoCopyWithImpl<RecurringRuleDto>(this as RecurringRuleDto, _$identity);

  /// Serializes this RecurringRuleDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurringRuleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate)&&(identical(other.lastGeneratedDate, lastGeneratedDate) || other.lastGeneratedDate == lastGeneratedDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate,lastGeneratedDate,createdAt,updatedAt);

@override
String toString() {
  return 'RecurringRuleDto(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate, lastGeneratedDate: $lastGeneratedDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RecurringRuleDtoCopyWith<$Res>  {
  factory $RecurringRuleDtoCopyWith(RecurringRuleDto value, $Res Function(RecurringRuleDto) _then) = _$RecurringRuleDtoCopyWithImpl;
@useResult
$Res call({
 String id, String type, int amount, String accountId, String? toAccountId, String? categoryId, String? note, String frequency, int interval, int? dayOfMonth, String startDate, String? endDate, bool autoCreate, String? lastGeneratedDate, int createdAt, int updatedAt
});




}
/// @nodoc
class _$RecurringRuleDtoCopyWithImpl<$Res>
    implements $RecurringRuleDtoCopyWith<$Res> {
  _$RecurringRuleDtoCopyWithImpl(this._self, this._then);

  final RecurringRuleDto _self;
  final $Res Function(RecurringRuleDto) _then;

/// Create a copy of RecurringRuleDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,Object? lastGeneratedDate = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(RecurringRuleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurringRuleDto].
extension RecurringRuleDtoPatterns on RecurringRuleDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurringRuleDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurringRuleDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurringRuleDto value)  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurringRuleDto value)?  $default,){
final _that = this;
switch (_that) {
case _RecurringRuleDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  String frequency,  int interval,  int? dayOfMonth,  String startDate,  String? endDate,  bool autoCreate,  String? lastGeneratedDate,  int createdAt,  int updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurringRuleDto() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.lastGeneratedDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  String frequency,  int interval,  int? dayOfMonth,  String startDate,  String? endDate,  bool autoCreate,  String? lastGeneratedDate,  int createdAt,  int updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleDto():
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.lastGeneratedDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String type,  int amount,  String accountId,  String? toAccountId,  String? categoryId,  String? note,  String frequency,  int interval,  int? dayOfMonth,  String startDate,  String? endDate,  bool autoCreate,  String? lastGeneratedDate,  int createdAt,  int updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecurringRuleDto() when $default != null:
return $default(_that.id,_that.type,_that.amount,_that.accountId,_that.toAccountId,_that.categoryId,_that.note,_that.frequency,_that.interval,_that.dayOfMonth,_that.startDate,_that.endDate,_that.autoCreate,_that.lastGeneratedDate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurringRuleDto extends RecurringRuleDto {
  const _RecurringRuleDto({required this.id, required this.type, required this.amount, required this.accountId, required this.toAccountId, required this.categoryId, required this.note, required this.frequency, required this.interval, required this.dayOfMonth, required this.startDate, required this.endDate, required this.autoCreate, required this.lastGeneratedDate, required this.createdAt, required this.updatedAt}): super._();
  factory _RecurringRuleDto.fromJson(Map<String, dynamic> json) => _$RecurringRuleDtoFromJson(json);

@override final  String id;
@override final  String type;
@override final  int amount;
@override final  String accountId;
@override final  String? toAccountId;
@override final  String? categoryId;
@override final  String? note;
@override final  String frequency;
@override final  int interval;
@override final  int? dayOfMonth;
/// Local dates, `YYYY-MM-DD`.
@override final  String startDate;
@override final  String? endDate;
@override final  bool autoCreate;
@override final  String? lastGeneratedDate;
@override final  int createdAt;
@override final  int updatedAt;

/// Create a copy of RecurringRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurringRuleDtoCopyWith<_RecurringRuleDto> get copyWith => __$RecurringRuleDtoCopyWithImpl<_RecurringRuleDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurringRuleDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurringRuleDto&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.accountId, accountId) || other.accountId == accountId)&&(identical(other.toAccountId, toAccountId) || other.toAccountId == toAccountId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.note, note) || other.note == note)&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.dayOfMonth, dayOfMonth) || other.dayOfMonth == dayOfMonth)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoCreate, autoCreate) || other.autoCreate == autoCreate)&&(identical(other.lastGeneratedDate, lastGeneratedDate) || other.lastGeneratedDate == lastGeneratedDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,amount,accountId,toAccountId,categoryId,note,frequency,interval,dayOfMonth,startDate,endDate,autoCreate,lastGeneratedDate,createdAt,updatedAt);

@override
String toString() {
  return 'RecurringRuleDto(id: $id, type: $type, amount: $amount, accountId: $accountId, toAccountId: $toAccountId, categoryId: $categoryId, note: $note, frequency: $frequency, interval: $interval, dayOfMonth: $dayOfMonth, startDate: $startDate, endDate: $endDate, autoCreate: $autoCreate, lastGeneratedDate: $lastGeneratedDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RecurringRuleDtoCopyWith<$Res> implements $RecurringRuleDtoCopyWith<$Res> {
  factory _$RecurringRuleDtoCopyWith(_RecurringRuleDto value, $Res Function(_RecurringRuleDto) _then) = __$RecurringRuleDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String type, int amount, String accountId, String? toAccountId, String? categoryId, String? note, String frequency, int interval, int? dayOfMonth, String startDate, String? endDate, bool autoCreate, String? lastGeneratedDate, int createdAt, int updatedAt
});




}
/// @nodoc
class __$RecurringRuleDtoCopyWithImpl<$Res>
    implements _$RecurringRuleDtoCopyWith<$Res> {
  __$RecurringRuleDtoCopyWithImpl(this._self, this._then);

  final _RecurringRuleDto _self;
  final $Res Function(_RecurringRuleDto) _then;

/// Create a copy of RecurringRuleDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? amount = null,Object? accountId = null,Object? toAccountId = freezed,Object? categoryId = freezed,Object? note = freezed,Object? frequency = null,Object? interval = null,Object? dayOfMonth = freezed,Object? startDate = null,Object? endDate = freezed,Object? autoCreate = null,Object? lastGeneratedDate = freezed,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_RecurringRuleDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,accountId: null == accountId ? _self.accountId : accountId // ignore: cast_nullable_to_non_nullable
as String,toAccountId: freezed == toAccountId ? _self.toAccountId : toAccountId // ignore: cast_nullable_to_non_nullable
as String?,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as String,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,dayOfMonth: freezed == dayOfMonth ? _self.dayOfMonth : dayOfMonth // ignore: cast_nullable_to_non_nullable
as int?,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoCreate: null == autoCreate ? _self.autoCreate : autoCreate // ignore: cast_nullable_to_non_nullable
as bool,lastGeneratedDate: freezed == lastGeneratedDate ? _self.lastGeneratedDate : lastGeneratedDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PendingOccurrenceDto {

 String get id; String get ruleId;/// Local date, `YYYY-MM-DD`.
 String get date; int get createdAt;
/// Create a copy of PendingOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PendingOccurrenceDtoCopyWith<PendingOccurrenceDto> get copyWith => _$PendingOccurrenceDtoCopyWithImpl<PendingOccurrenceDto>(this as PendingOccurrenceDto, _$identity);

  /// Serializes this PendingOccurrenceDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PendingOccurrenceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,date,createdAt);

@override
String toString() {
  return 'PendingOccurrenceDto(id: $id, ruleId: $ruleId, date: $date, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PendingOccurrenceDtoCopyWith<$Res>  {
  factory $PendingOccurrenceDtoCopyWith(PendingOccurrenceDto value, $Res Function(PendingOccurrenceDto) _then) = _$PendingOccurrenceDtoCopyWithImpl;
@useResult
$Res call({
 String id, String ruleId, String date, int createdAt
});




}
/// @nodoc
class _$PendingOccurrenceDtoCopyWithImpl<$Res>
    implements $PendingOccurrenceDtoCopyWith<$Res> {
  _$PendingOccurrenceDtoCopyWithImpl(this._self, this._then);

  final PendingOccurrenceDto _self;
  final $Res Function(PendingOccurrenceDto) _then;

/// Create a copy of PendingOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? ruleId = null,Object? date = null,Object? createdAt = null,}) {
  return _then(PendingOccurrenceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PendingOccurrenceDto].
extension PendingOccurrenceDtoPatterns on PendingOccurrenceDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PendingOccurrenceDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PendingOccurrenceDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PendingOccurrenceDto value)  $default,){
final _that = this;
switch (_that) {
case _PendingOccurrenceDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PendingOccurrenceDto value)?  $default,){
final _that = this;
switch (_that) {
case _PendingOccurrenceDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String ruleId,  String date,  int createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PendingOccurrenceDto() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String ruleId,  String date,  int createdAt)  $default,) {final _that = this;
switch (_that) {
case _PendingOccurrenceDto():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String ruleId,  String date,  int createdAt)?  $default,) {final _that = this;
switch (_that) {
case _PendingOccurrenceDto() when $default != null:
return $default(_that.id,_that.ruleId,_that.date,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PendingOccurrenceDto extends PendingOccurrenceDto {
  const _PendingOccurrenceDto({required this.id, required this.ruleId, required this.date, required this.createdAt}): super._();
  factory _PendingOccurrenceDto.fromJson(Map<String, dynamic> json) => _$PendingOccurrenceDtoFromJson(json);

@override final  String id;
@override final  String ruleId;
/// Local date, `YYYY-MM-DD`.
@override final  String date;
@override final  int createdAt;

/// Create a copy of PendingOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PendingOccurrenceDtoCopyWith<_PendingOccurrenceDto> get copyWith => __$PendingOccurrenceDtoCopyWithImpl<_PendingOccurrenceDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PendingOccurrenceDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PendingOccurrenceDto&&(identical(other.id, id) || other.id == id)&&(identical(other.ruleId, ruleId) || other.ruleId == ruleId)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,ruleId,date,createdAt);

@override
String toString() {
  return 'PendingOccurrenceDto(id: $id, ruleId: $ruleId, date: $date, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PendingOccurrenceDtoCopyWith<$Res> implements $PendingOccurrenceDtoCopyWith<$Res> {
  factory _$PendingOccurrenceDtoCopyWith(_PendingOccurrenceDto value, $Res Function(_PendingOccurrenceDto) _then) = __$PendingOccurrenceDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String ruleId, String date, int createdAt
});




}
/// @nodoc
class __$PendingOccurrenceDtoCopyWithImpl<$Res>
    implements _$PendingOccurrenceDtoCopyWith<$Res> {
  __$PendingOccurrenceDtoCopyWithImpl(this._self, this._then);

  final _PendingOccurrenceDto _self;
  final $Res Function(_PendingOccurrenceDto) _then;

/// Create a copy of PendingOccurrenceDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? ruleId = null,Object? date = null,Object? createdAt = null,}) {
  return _then(_PendingOccurrenceDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,ruleId: null == ruleId ? _self.ruleId : ruleId // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupFolder {

 String get uri; String get name;
/// Create a copy of BackupFolder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupFolderCopyWith<BackupFolder> get copyWith => _$BackupFolderCopyWithImpl<BackupFolder>(this as BackupFolder, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupFolder&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,uri,name);

@override
String toString() {
  return 'BackupFolder(uri: $uri, name: $name)';
}


}

/// @nodoc
abstract mixin class $BackupFolderCopyWith<$Res>  {
  factory $BackupFolderCopyWith(BackupFolder value, $Res Function(BackupFolder) _then) = _$BackupFolderCopyWithImpl;
@useResult
$Res call({
 String uri, String name
});




}
/// @nodoc
class _$BackupFolderCopyWithImpl<$Res>
    implements $BackupFolderCopyWith<$Res> {
  _$BackupFolderCopyWithImpl(this._self, this._then);

  final BackupFolder _self;
  final $Res Function(BackupFolder) _then;

/// Create a copy of BackupFolder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uri = null,Object? name = null,}) {
  return _then(BackupFolder(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupFolder].
extension BackupFolderPatterns on BackupFolder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupFolder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupFolder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupFolder value)  $default,){
final _that = this;
switch (_that) {
case _BackupFolder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupFolder value)?  $default,){
final _that = this;
switch (_that) {
case _BackupFolder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uri,  String name)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupFolder() when $default != null:
return $default(_that.uri,_that.name);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uri,  String name)  $default,) {final _that = this;
switch (_that) {
case _BackupFolder():
return $default(_that.uri,_that.name);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uri,  String name)?  $default,) {final _that = this;
switch (_that) {
case _BackupFolder() when $default != null:
return $default(_that.uri,_that.name);case _:
  return null;

}
}

}

/// @nodoc


class _BackupFolder implements BackupFolder {
  const _BackupFolder({required this.uri, required this.name});
  

@override final  String uri;
@override final  String name;

/// Create a copy of BackupFolder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupFolderCopyWith<_BackupFolder> get copyWith => __$BackupFolderCopyWithImpl<_BackupFolder>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupFolder&&(identical(other.uri, uri) || other.uri == uri)&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,uri,name);

@override
String toString() {
  return 'BackupFolder(uri: $uri, name: $name)';
}


}

/// @nodoc
abstract mixin class _$BackupFolderCopyWith<$Res> implements $BackupFolderCopyWith<$Res> {
  factory _$BackupFolderCopyWith(_BackupFolder value, $Res Function(_BackupFolder) _then) = __$BackupFolderCopyWithImpl;
@override @useResult
$Res call({
 String uri, String name
});




}
/// @nodoc
class __$BackupFolderCopyWithImpl<$Res>
    implements _$BackupFolderCopyWith<$Res> {
  __$BackupFolderCopyWithImpl(this._self, this._then);

  final _BackupFolder _self;
  final $Res Function(_BackupFolder) _then;

/// Create a copy of BackupFolder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uri = null,Object? name = null,}) {
  return _then(_BackupFolder(
uri: null == uri ? _self.uri : uri // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$BackupReminderDue {

 int? get daysSinceBackup;
/// Create a copy of BackupReminderDue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupReminderDueCopyWith<BackupReminderDue> get copyWith => _$BackupReminderDueCopyWithImpl<BackupReminderDue>(this as BackupReminderDue, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupReminderDue&&(identical(other.daysSinceBackup, daysSinceBackup) || other.daysSinceBackup == daysSinceBackup));
}


@override
int get hashCode => Object.hash(runtimeType,daysSinceBackup);

@override
String toString() {
  return 'BackupReminderDue(daysSinceBackup: $daysSinceBackup)';
}


}

/// @nodoc
abstract mixin class $BackupReminderDueCopyWith<$Res>  {
  factory $BackupReminderDueCopyWith(BackupReminderDue value, $Res Function(BackupReminderDue) _then) = _$BackupReminderDueCopyWithImpl;
@useResult
$Res call({
 int? daysSinceBackup
});




}
/// @nodoc
class _$BackupReminderDueCopyWithImpl<$Res>
    implements $BackupReminderDueCopyWith<$Res> {
  _$BackupReminderDueCopyWithImpl(this._self, this._then);

  final BackupReminderDue _self;
  final $Res Function(BackupReminderDue) _then;

/// Create a copy of BackupReminderDue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? daysSinceBackup = freezed,}) {
  return _then(BackupReminderDue(
daysSinceBackup: freezed == daysSinceBackup ? _self.daysSinceBackup : daysSinceBackup // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupReminderDue].
extension BackupReminderDuePatterns on BackupReminderDue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupReminderDue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupReminderDue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupReminderDue value)  $default,){
final _that = this;
switch (_that) {
case _BackupReminderDue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupReminderDue value)?  $default,){
final _that = this;
switch (_that) {
case _BackupReminderDue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? daysSinceBackup)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupReminderDue() when $default != null:
return $default(_that.daysSinceBackup);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? daysSinceBackup)  $default,) {final _that = this;
switch (_that) {
case _BackupReminderDue():
return $default(_that.daysSinceBackup);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? daysSinceBackup)?  $default,) {final _that = this;
switch (_that) {
case _BackupReminderDue() when $default != null:
return $default(_that.daysSinceBackup);case _:
  return null;

}
}

}

/// @nodoc


class _BackupReminderDue implements BackupReminderDue {
  const _BackupReminderDue({this.daysSinceBackup});
  

@override final  int? daysSinceBackup;

/// Create a copy of BackupReminderDue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupReminderDueCopyWith<_BackupReminderDue> get copyWith => __$BackupReminderDueCopyWithImpl<_BackupReminderDue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupReminderDue&&(identical(other.daysSinceBackup, daysSinceBackup) || other.daysSinceBackup == daysSinceBackup));
}


@override
int get hashCode => Object.hash(runtimeType,daysSinceBackup);

@override
String toString() {
  return 'BackupReminderDue(daysSinceBackup: $daysSinceBackup)';
}


}

/// @nodoc
abstract mixin class _$BackupReminderDueCopyWith<$Res> implements $BackupReminderDueCopyWith<$Res> {
  factory _$BackupReminderDueCopyWith(_BackupReminderDue value, $Res Function(_BackupReminderDue) _then) = __$BackupReminderDueCopyWithImpl;
@override @useResult
$Res call({
 int? daysSinceBackup
});




}
/// @nodoc
class __$BackupReminderDueCopyWithImpl<$Res>
    implements _$BackupReminderDueCopyWith<$Res> {
  __$BackupReminderDueCopyWithImpl(this._self, this._then);

  final _BackupReminderDue _self;
  final $Res Function(_BackupReminderDue) _then;

/// Create a copy of BackupReminderDue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? daysSinceBackup = freezed,}) {
  return _then(_BackupReminderDue(
daysSinceBackup: freezed == daysSinceBackup ? _self.daysSinceBackup : daysSinceBackup // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc
mixin _$BackupStatus {

 DateTime? get lastBackupAt;/// When the oldest transaction was created; null with no transactions.
 DateTime? get firstRecordAt; bool get reminderEnabled; DateTime? get reminderSnoozedUntil; BackupFolder? get autoBackupFolder; DateTime? get lastAutoBackupAt;/// The last auto-backup couldn't write to the folder (e.g. access was
/// revoked, or the backup came from another phone).
 bool get autoBackupFailed;
/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupStatusCopyWith<BackupStatus> get copyWith => _$BackupStatusCopyWithImpl<BackupStatus>(this as BackupStatus, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupStatus&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt)&&(identical(other.firstRecordAt, firstRecordAt) || other.firstRecordAt == firstRecordAt)&&(identical(other.reminderEnabled, reminderEnabled) || other.reminderEnabled == reminderEnabled)&&(identical(other.reminderSnoozedUntil, reminderSnoozedUntil) || other.reminderSnoozedUntil == reminderSnoozedUntil)&&(identical(other.autoBackupFolder, autoBackupFolder) || other.autoBackupFolder == autoBackupFolder)&&(identical(other.lastAutoBackupAt, lastAutoBackupAt) || other.lastAutoBackupAt == lastAutoBackupAt)&&(identical(other.autoBackupFailed, autoBackupFailed) || other.autoBackupFailed == autoBackupFailed));
}


@override
int get hashCode => Object.hash(runtimeType,lastBackupAt,firstRecordAt,reminderEnabled,reminderSnoozedUntil,autoBackupFolder,lastAutoBackupAt,autoBackupFailed);

@override
String toString() {
  return 'BackupStatus(lastBackupAt: $lastBackupAt, firstRecordAt: $firstRecordAt, reminderEnabled: $reminderEnabled, reminderSnoozedUntil: $reminderSnoozedUntil, autoBackupFolder: $autoBackupFolder, lastAutoBackupAt: $lastAutoBackupAt, autoBackupFailed: $autoBackupFailed)';
}


}

/// @nodoc
abstract mixin class $BackupStatusCopyWith<$Res>  {
  factory $BackupStatusCopyWith(BackupStatus value, $Res Function(BackupStatus) _then) = _$BackupStatusCopyWithImpl;
@useResult
$Res call({
 DateTime? lastBackupAt, DateTime? firstRecordAt, bool reminderEnabled, DateTime? reminderSnoozedUntil, BackupFolder? autoBackupFolder, DateTime? lastAutoBackupAt, bool autoBackupFailed
});


$BackupFolderCopyWith<$Res>? get autoBackupFolder;

}
/// @nodoc
class _$BackupStatusCopyWithImpl<$Res>
    implements $BackupStatusCopyWith<$Res> {
  _$BackupStatusCopyWithImpl(this._self, this._then);

  final BackupStatus _self;
  final $Res Function(BackupStatus) _then;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastBackupAt = freezed,Object? firstRecordAt = freezed,Object? reminderEnabled = null,Object? reminderSnoozedUntil = freezed,Object? autoBackupFolder = freezed,Object? lastAutoBackupAt = freezed,Object? autoBackupFailed = null,}) {
  return _then(BackupStatus(
lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstRecordAt: freezed == firstRecordAt ? _self.firstRecordAt : firstRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderEnabled: null == reminderEnabled ? _self.reminderEnabled : reminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderSnoozedUntil: freezed == reminderSnoozedUntil ? _self.reminderSnoozedUntil : reminderSnoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,autoBackupFolder: freezed == autoBackupFolder ? _self.autoBackupFolder : autoBackupFolder // ignore: cast_nullable_to_non_nullable
as BackupFolder?,lastAutoBackupAt: freezed == lastAutoBackupAt ? _self.lastAutoBackupAt : lastAutoBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoBackupFailed: null == autoBackupFailed ? _self.autoBackupFailed : autoBackupFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupFolderCopyWith<$Res>? get autoBackupFolder {
    if (_self.autoBackupFolder == null) {
    return null;
  }

  return $BackupFolderCopyWith<$Res>(_self.autoBackupFolder!, (value) {
    return _then(_self.copyWith(autoBackupFolder: value));
  });
}
}


/// Adds pattern-matching-related methods to [BackupStatus].
extension BackupStatusPatterns on BackupStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupStatus value)  $default,){
final _that = this;
switch (_that) {
case _BackupStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupStatus value)?  $default,){
final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? lastBackupAt,  DateTime? firstRecordAt,  bool reminderEnabled,  DateTime? reminderSnoozedUntil,  BackupFolder? autoBackupFolder,  DateTime? lastAutoBackupAt,  bool autoBackupFailed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
return $default(_that.lastBackupAt,_that.firstRecordAt,_that.reminderEnabled,_that.reminderSnoozedUntil,_that.autoBackupFolder,_that.lastAutoBackupAt,_that.autoBackupFailed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? lastBackupAt,  DateTime? firstRecordAt,  bool reminderEnabled,  DateTime? reminderSnoozedUntil,  BackupFolder? autoBackupFolder,  DateTime? lastAutoBackupAt,  bool autoBackupFailed)  $default,) {final _that = this;
switch (_that) {
case _BackupStatus():
return $default(_that.lastBackupAt,_that.firstRecordAt,_that.reminderEnabled,_that.reminderSnoozedUntil,_that.autoBackupFolder,_that.lastAutoBackupAt,_that.autoBackupFailed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? lastBackupAt,  DateTime? firstRecordAt,  bool reminderEnabled,  DateTime? reminderSnoozedUntil,  BackupFolder? autoBackupFolder,  DateTime? lastAutoBackupAt,  bool autoBackupFailed)?  $default,) {final _that = this;
switch (_that) {
case _BackupStatus() when $default != null:
return $default(_that.lastBackupAt,_that.firstRecordAt,_that.reminderEnabled,_that.reminderSnoozedUntil,_that.autoBackupFolder,_that.lastAutoBackupAt,_that.autoBackupFailed);case _:
  return null;

}
}

}

/// @nodoc


class _BackupStatus extends BackupStatus {
  const _BackupStatus({this.lastBackupAt, this.firstRecordAt, this.reminderEnabled = true, this.reminderSnoozedUntil, this.autoBackupFolder, this.lastAutoBackupAt, this.autoBackupFailed = false}): super._();
  

@override final  DateTime? lastBackupAt;
/// When the oldest transaction was created; null with no transactions.
@override final  DateTime? firstRecordAt;
@override@JsonKey() final  bool reminderEnabled;
@override final  DateTime? reminderSnoozedUntil;
@override final  BackupFolder? autoBackupFolder;
@override final  DateTime? lastAutoBackupAt;
/// The last auto-backup couldn't write to the folder (e.g. access was
/// revoked, or the backup came from another phone).
@override@JsonKey() final  bool autoBackupFailed;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupStatusCopyWith<_BackupStatus> get copyWith => __$BackupStatusCopyWithImpl<_BackupStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupStatus&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt)&&(identical(other.firstRecordAt, firstRecordAt) || other.firstRecordAt == firstRecordAt)&&(identical(other.reminderEnabled, reminderEnabled) || other.reminderEnabled == reminderEnabled)&&(identical(other.reminderSnoozedUntil, reminderSnoozedUntil) || other.reminderSnoozedUntil == reminderSnoozedUntil)&&(identical(other.autoBackupFolder, autoBackupFolder) || other.autoBackupFolder == autoBackupFolder)&&(identical(other.lastAutoBackupAt, lastAutoBackupAt) || other.lastAutoBackupAt == lastAutoBackupAt)&&(identical(other.autoBackupFailed, autoBackupFailed) || other.autoBackupFailed == autoBackupFailed));
}


@override
int get hashCode => Object.hash(runtimeType,lastBackupAt,firstRecordAt,reminderEnabled,reminderSnoozedUntil,autoBackupFolder,lastAutoBackupAt,autoBackupFailed);

@override
String toString() {
  return 'BackupStatus(lastBackupAt: $lastBackupAt, firstRecordAt: $firstRecordAt, reminderEnabled: $reminderEnabled, reminderSnoozedUntil: $reminderSnoozedUntil, autoBackupFolder: $autoBackupFolder, lastAutoBackupAt: $lastAutoBackupAt, autoBackupFailed: $autoBackupFailed)';
}


}

/// @nodoc
abstract mixin class _$BackupStatusCopyWith<$Res> implements $BackupStatusCopyWith<$Res> {
  factory _$BackupStatusCopyWith(_BackupStatus value, $Res Function(_BackupStatus) _then) = __$BackupStatusCopyWithImpl;
@override @useResult
$Res call({
 DateTime? lastBackupAt, DateTime? firstRecordAt, bool reminderEnabled, DateTime? reminderSnoozedUntil, BackupFolder? autoBackupFolder, DateTime? lastAutoBackupAt, bool autoBackupFailed
});


@override $BackupFolderCopyWith<$Res>? get autoBackupFolder;

}
/// @nodoc
class __$BackupStatusCopyWithImpl<$Res>
    implements _$BackupStatusCopyWith<$Res> {
  __$BackupStatusCopyWithImpl(this._self, this._then);

  final _BackupStatus _self;
  final $Res Function(_BackupStatus) _then;

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastBackupAt = freezed,Object? firstRecordAt = freezed,Object? reminderEnabled = null,Object? reminderSnoozedUntil = freezed,Object? autoBackupFolder = freezed,Object? lastAutoBackupAt = freezed,Object? autoBackupFailed = null,}) {
  return _then(_BackupStatus(
lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstRecordAt: freezed == firstRecordAt ? _self.firstRecordAt : firstRecordAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reminderEnabled: null == reminderEnabled ? _self.reminderEnabled : reminderEnabled // ignore: cast_nullable_to_non_nullable
as bool,reminderSnoozedUntil: freezed == reminderSnoozedUntil ? _self.reminderSnoozedUntil : reminderSnoozedUntil // ignore: cast_nullable_to_non_nullable
as DateTime?,autoBackupFolder: freezed == autoBackupFolder ? _self.autoBackupFolder : autoBackupFolder // ignore: cast_nullable_to_non_nullable
as BackupFolder?,lastAutoBackupAt: freezed == lastAutoBackupAt ? _self.lastAutoBackupAt : lastAutoBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoBackupFailed: null == autoBackupFailed ? _self.autoBackupFailed : autoBackupFailed // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of BackupStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupFolderCopyWith<$Res>? get autoBackupFolder {
    if (_self.autoBackupFolder == null) {
    return null;
  }

  return $BackupFolderCopyWith<$Res>(_self.autoBackupFolder!, (value) {
    return _then(_self.copyWith(autoBackupFolder: value));
  });
}
}

// dart format on

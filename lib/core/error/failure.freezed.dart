// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Failure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Failure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'Failure()';
}


}

/// @nodoc
class $FailureCopyWith<$Res>  {
$FailureCopyWith(Failure _, $Res Function(Failure) __);
}


/// Adds pattern-matching-related methods to [Failure].
extension FailurePatterns on Failure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( DatabaseFailure value)?  database,TResult Function( ValidationFailure value)?  validation,TResult Function( NotFoundFailure value)?  notFound,TResult Function( FileFailure value)?  file,TResult Function( BackupFailure value)?  backup,TResult Function( UnexpectedFailure value)?  unexpected,required TResult orElse(),}){
final _that = this;
switch (_that) {
case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case FileFailure() when file != null:
return file(_that);case BackupFailure() when backup != null:
return backup(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( DatabaseFailure value)  database,required TResult Function( ValidationFailure value)  validation,required TResult Function( NotFoundFailure value)  notFound,required TResult Function( FileFailure value)  file,required TResult Function( BackupFailure value)  backup,required TResult Function( UnexpectedFailure value)  unexpected,}){
final _that = this;
switch (_that) {
case DatabaseFailure():
return database(_that);case ValidationFailure():
return validation(_that);case NotFoundFailure():
return notFound(_that);case FileFailure():
return file(_that);case BackupFailure():
return backup(_that);case UnexpectedFailure():
return unexpected(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( DatabaseFailure value)?  database,TResult? Function( ValidationFailure value)?  validation,TResult? Function( NotFoundFailure value)?  notFound,TResult? Function( FileFailure value)?  file,TResult? Function( BackupFailure value)?  backup,TResult? Function( UnexpectedFailure value)?  unexpected,}){
final _that = this;
switch (_that) {
case DatabaseFailure() when database != null:
return database(_that);case ValidationFailure() when validation != null:
return validation(_that);case NotFoundFailure() when notFound != null:
return notFound(_that);case FileFailure() when file != null:
return file(_that);case BackupFailure() when backup != null:
return backup(_that);case UnexpectedFailure() when unexpected != null:
return unexpected(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? detail)?  database,TResult Function( ValidationReason reason)?  validation,TResult Function( String? detail)?  notFound,TResult Function( String? detail)?  file,TResult Function( BackupProblem problem,  String? detail)?  backup,TResult Function( String? detail)?  unexpected,required TResult orElse(),}) {final _that = this;
switch (_that) {
case DatabaseFailure() when database != null:
return database(_that.detail);case ValidationFailure() when validation != null:
return validation(_that.reason);case NotFoundFailure() when notFound != null:
return notFound(_that.detail);case FileFailure() when file != null:
return file(_that.detail);case BackupFailure() when backup != null:
return backup(_that.problem,_that.detail);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.detail);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? detail)  database,required TResult Function( ValidationReason reason)  validation,required TResult Function( String? detail)  notFound,required TResult Function( String? detail)  file,required TResult Function( BackupProblem problem,  String? detail)  backup,required TResult Function( String? detail)  unexpected,}) {final _that = this;
switch (_that) {
case DatabaseFailure():
return database(_that.detail);case ValidationFailure():
return validation(_that.reason);case NotFoundFailure():
return notFound(_that.detail);case FileFailure():
return file(_that.detail);case BackupFailure():
return backup(_that.problem,_that.detail);case UnexpectedFailure():
return unexpected(_that.detail);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? detail)?  database,TResult? Function( ValidationReason reason)?  validation,TResult? Function( String? detail)?  notFound,TResult? Function( String? detail)?  file,TResult? Function( BackupProblem problem,  String? detail)?  backup,TResult? Function( String? detail)?  unexpected,}) {final _that = this;
switch (_that) {
case DatabaseFailure() when database != null:
return database(_that.detail);case ValidationFailure() when validation != null:
return validation(_that.reason);case NotFoundFailure() when notFound != null:
return notFound(_that.detail);case FileFailure() when file != null:
return file(_that.detail);case BackupFailure() when backup != null:
return backup(_that.problem,_that.detail);case UnexpectedFailure() when unexpected != null:
return unexpected(_that.detail);case _:
  return null;

}
}

}

/// @nodoc


class DatabaseFailure implements Failure {
  const DatabaseFailure([this.detail]);
  

 final  String? detail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DatabaseFailureCopyWith<DatabaseFailure> get copyWith => _$DatabaseFailureCopyWithImpl<DatabaseFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DatabaseFailure&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'Failure.database(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $DatabaseFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $DatabaseFailureCopyWith(DatabaseFailure value, $Res Function(DatabaseFailure) _then) = _$DatabaseFailureCopyWithImpl;
@useResult
$Res call({
 String? detail
});




}
/// @nodoc
class _$DatabaseFailureCopyWithImpl<$Res>
    implements $DatabaseFailureCopyWith<$Res> {
  _$DatabaseFailureCopyWithImpl(this._self, this._then);

  final DatabaseFailure _self;
  final $Res Function(DatabaseFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = freezed,}) {
  return _then(DatabaseFailure(
freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ValidationFailure implements Failure {
  const ValidationFailure(this.reason);
  

 final  ValidationReason reason;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ValidationFailureCopyWith<ValidationFailure> get copyWith => _$ValidationFailureCopyWithImpl<ValidationFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ValidationFailure&&(identical(other.reason, reason) || other.reason == reason));
}


@override
int get hashCode => Object.hash(runtimeType,reason);

@override
String toString() {
  return 'Failure.validation(reason: $reason)';
}


}

/// @nodoc
abstract mixin class $ValidationFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $ValidationFailureCopyWith(ValidationFailure value, $Res Function(ValidationFailure) _then) = _$ValidationFailureCopyWithImpl;
@useResult
$Res call({
 ValidationReason reason
});




}
/// @nodoc
class _$ValidationFailureCopyWithImpl<$Res>
    implements $ValidationFailureCopyWith<$Res> {
  _$ValidationFailureCopyWithImpl(this._self, this._then);

  final ValidationFailure _self;
  final $Res Function(ValidationFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reason = null,}) {
  return _then(ValidationFailure(
null == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as ValidationReason,
  ));
}


}

/// @nodoc


class NotFoundFailure implements Failure {
  const NotFoundFailure([this.detail]);
  

 final  String? detail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotFoundFailureCopyWith<NotFoundFailure> get copyWith => _$NotFoundFailureCopyWithImpl<NotFoundFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotFoundFailure&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'Failure.notFound(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $NotFoundFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $NotFoundFailureCopyWith(NotFoundFailure value, $Res Function(NotFoundFailure) _then) = _$NotFoundFailureCopyWithImpl;
@useResult
$Res call({
 String? detail
});




}
/// @nodoc
class _$NotFoundFailureCopyWithImpl<$Res>
    implements $NotFoundFailureCopyWith<$Res> {
  _$NotFoundFailureCopyWithImpl(this._self, this._then);

  final NotFoundFailure _self;
  final $Res Function(NotFoundFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = freezed,}) {
  return _then(NotFoundFailure(
freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class FileFailure implements Failure {
  const FileFailure([this.detail]);
  

 final  String? detail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FileFailureCopyWith<FileFailure> get copyWith => _$FileFailureCopyWithImpl<FileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FileFailure&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'Failure.file(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $FileFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $FileFailureCopyWith(FileFailure value, $Res Function(FileFailure) _then) = _$FileFailureCopyWithImpl;
@useResult
$Res call({
 String? detail
});




}
/// @nodoc
class _$FileFailureCopyWithImpl<$Res>
    implements $FileFailureCopyWith<$Res> {
  _$FileFailureCopyWithImpl(this._self, this._then);

  final FileFailure _self;
  final $Res Function(FileFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = freezed,}) {
  return _then(FileFailure(
freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class BackupFailure implements Failure {
  const BackupFailure(this.problem, [this.detail]);
  

 final  BackupProblem problem;
 final  String? detail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupFailureCopyWith<BackupFailure> get copyWith => _$BackupFailureCopyWithImpl<BackupFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupFailure&&(identical(other.problem, problem) || other.problem == problem)&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,problem,detail);

@override
String toString() {
  return 'Failure.backup(problem: $problem, detail: $detail)';
}


}

/// @nodoc
abstract mixin class $BackupFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $BackupFailureCopyWith(BackupFailure value, $Res Function(BackupFailure) _then) = _$BackupFailureCopyWithImpl;
@useResult
$Res call({
 BackupProblem problem, String? detail
});




}
/// @nodoc
class _$BackupFailureCopyWithImpl<$Res>
    implements $BackupFailureCopyWith<$Res> {
  _$BackupFailureCopyWithImpl(this._self, this._then);

  final BackupFailure _self;
  final $Res Function(BackupFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? problem = null,Object? detail = freezed,}) {
  return _then(BackupFailure(
null == problem ? _self.problem : problem // ignore: cast_nullable_to_non_nullable
as BackupProblem,freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class UnexpectedFailure implements Failure {
  const UnexpectedFailure([this.detail]);
  

 final  String? detail;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UnexpectedFailureCopyWith<UnexpectedFailure> get copyWith => _$UnexpectedFailureCopyWithImpl<UnexpectedFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UnexpectedFailure&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'Failure.unexpected(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $UnexpectedFailureCopyWith<$Res> implements $FailureCopyWith<$Res> {
  factory $UnexpectedFailureCopyWith(UnexpectedFailure value, $Res Function(UnexpectedFailure) _then) = _$UnexpectedFailureCopyWithImpl;
@useResult
$Res call({
 String? detail
});




}
/// @nodoc
class _$UnexpectedFailureCopyWithImpl<$Res>
    implements $UnexpectedFailureCopyWith<$Res> {
  _$UnexpectedFailureCopyWithImpl(this._self, this._then);

  final UnexpectedFailure _self;
  final $Res Function(UnexpectedFailure) _then;

/// Create a copy of Failure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = freezed,}) {
  return _then(UnexpectedFailure(
freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on

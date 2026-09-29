// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_hash_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PinHashModel {

 String get algorithm; int get iterations;/// Base64.
 String get salt;/// Base64.
 String get hash;
/// Create a copy of PinHashModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinHashModelCopyWith<PinHashModel> get copyWith => _$PinHashModelCopyWithImpl<PinHashModel>(this as PinHashModel, _$identity);

  /// Serializes this PinHashModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinHashModel&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,iterations,salt,hash);

@override
String toString() {
  return 'PinHashModel(algorithm: $algorithm, iterations: $iterations, salt: $salt, hash: $hash)';
}


}

/// @nodoc
abstract mixin class $PinHashModelCopyWith<$Res>  {
  factory $PinHashModelCopyWith(PinHashModel value, $Res Function(PinHashModel) _then) = _$PinHashModelCopyWithImpl;
@useResult
$Res call({
 String algorithm, int iterations, String salt, String hash
});




}
/// @nodoc
class _$PinHashModelCopyWithImpl<$Res>
    implements $PinHashModelCopyWith<$Res> {
  _$PinHashModelCopyWithImpl(this._self, this._then);

  final PinHashModel _self;
  final $Res Function(PinHashModel) _then;

/// Create a copy of PinHashModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? algorithm = null,Object? iterations = null,Object? salt = null,Object? hash = null,}) {
  return _then(PinHashModel(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as String,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PinHashModel].
extension PinHashModelPatterns on PinHashModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinHashModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinHashModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinHashModel value)  $default,){
final _that = this;
switch (_that) {
case _PinHashModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinHashModel value)?  $default,){
final _that = this;
switch (_that) {
case _PinHashModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String algorithm,  int iterations,  String salt,  String hash)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinHashModel() when $default != null:
return $default(_that.algorithm,_that.iterations,_that.salt,_that.hash);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String algorithm,  int iterations,  String salt,  String hash)  $default,) {final _that = this;
switch (_that) {
case _PinHashModel():
return $default(_that.algorithm,_that.iterations,_that.salt,_that.hash);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String algorithm,  int iterations,  String salt,  String hash)?  $default,) {final _that = this;
switch (_that) {
case _PinHashModel() when $default != null:
return $default(_that.algorithm,_that.iterations,_that.salt,_that.hash);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PinHashModel implements PinHashModel {
  const _PinHashModel({this.algorithm = PinHashModel.pbkdf2Sha256, required this.iterations, required this.salt, required this.hash});
  factory _PinHashModel.fromJson(Map<String, dynamic> json) => _$PinHashModelFromJson(json);

@override@JsonKey() final  String algorithm;
@override final  int iterations;
/// Base64.
@override final  String salt;
/// Base64.
@override final  String hash;

/// Create a copy of PinHashModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinHashModelCopyWith<_PinHashModel> get copyWith => __$PinHashModelCopyWithImpl<_PinHashModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PinHashModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinHashModel&&(identical(other.algorithm, algorithm) || other.algorithm == algorithm)&&(identical(other.iterations, iterations) || other.iterations == iterations)&&(identical(other.salt, salt) || other.salt == salt)&&(identical(other.hash, hash) || other.hash == hash));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,algorithm,iterations,salt,hash);

@override
String toString() {
  return 'PinHashModel(algorithm: $algorithm, iterations: $iterations, salt: $salt, hash: $hash)';
}


}

/// @nodoc
abstract mixin class _$PinHashModelCopyWith<$Res> implements $PinHashModelCopyWith<$Res> {
  factory _$PinHashModelCopyWith(_PinHashModel value, $Res Function(_PinHashModel) _then) = __$PinHashModelCopyWithImpl;
@override @useResult
$Res call({
 String algorithm, int iterations, String salt, String hash
});




}
/// @nodoc
class __$PinHashModelCopyWithImpl<$Res>
    implements _$PinHashModelCopyWith<$Res> {
  __$PinHashModelCopyWithImpl(this._self, this._then);

  final _PinHashModel _self;
  final $Res Function(_PinHashModel) _then;

/// Create a copy of PinHashModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? algorithm = null,Object? iterations = null,Object? salt = null,Object? hash = null,}) {
  return _then(_PinHashModel(
algorithm: null == algorithm ? _self.algorithm : algorithm // ignore: cast_nullable_to_non_nullable
as String,iterations: null == iterations ? _self.iterations : iterations // ignore: cast_nullable_to_non_nullable
as int,salt: null == salt ? _self.salt : salt // ignore: cast_nullable_to_non_nullable
as String,hash: null == hash ? _self.hash : hash // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

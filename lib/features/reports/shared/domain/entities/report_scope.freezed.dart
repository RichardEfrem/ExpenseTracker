// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_scope.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReportScope {

 Period get period;/// Empty means all accounts.
 Set<String> get accountIds;
/// Create a copy of ReportScope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReportScopeCopyWith<ReportScope> get copyWith => _$ReportScopeCopyWithImpl<ReportScope>(this as ReportScope, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReportScope&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other.accountIds, accountIds));
}


@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(accountIds));

@override
String toString() {
  return 'ReportScope(period: $period, accountIds: $accountIds)';
}


}

/// @nodoc
abstract mixin class $ReportScopeCopyWith<$Res>  {
  factory $ReportScopeCopyWith(ReportScope value, $Res Function(ReportScope) _then) = _$ReportScopeCopyWithImpl;
@useResult
$Res call({
 Period period, Set<String> accountIds
});




}
/// @nodoc
class _$ReportScopeCopyWithImpl<$Res>
    implements $ReportScopeCopyWith<$Res> {
  _$ReportScopeCopyWithImpl(this._self, this._then);

  final ReportScope _self;
  final $Res Function(ReportScope) _then;

/// Create a copy of ReportScope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? period = null,Object? accountIds = null,}) {
  return _then(ReportScope(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,accountIds: null == accountIds ? _self.accountIds : accountIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ReportScope].
extension ReportScopePatterns on ReportScope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReportScope value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReportScope() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReportScope value)  $default,){
final _that = this;
switch (_that) {
case _ReportScope():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReportScope value)?  $default,){
final _that = this;
switch (_that) {
case _ReportScope() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Period period,  Set<String> accountIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReportScope() when $default != null:
return $default(_that.period,_that.accountIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Period period,  Set<String> accountIds)  $default,) {final _that = this;
switch (_that) {
case _ReportScope():
return $default(_that.period,_that.accountIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Period period,  Set<String> accountIds)?  $default,) {final _that = this;
switch (_that) {
case _ReportScope() when $default != null:
return $default(_that.period,_that.accountIds);case _:
  return null;

}
}

}

/// @nodoc


class _ReportScope extends ReportScope {
  const _ReportScope({required this.period,  Set<String> accountIds = const <String>{}}): _accountIds = accountIds,super._();
  

@override final  Period period;
/// Empty means all accounts.
 final  Set<String> _accountIds;
/// Empty means all accounts.
@override@JsonKey() Set<String> get accountIds {
  if (_accountIds is EqualUnmodifiableSetView) return _accountIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_accountIds);
}


/// Create a copy of ReportScope
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReportScopeCopyWith<_ReportScope> get copyWith => __$ReportScopeCopyWithImpl<_ReportScope>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReportScope&&(identical(other.period, period) || other.period == period)&&const DeepCollectionEquality().equals(other._accountIds, _accountIds));
}


@override
int get hashCode => Object.hash(runtimeType,period,const DeepCollectionEquality().hash(_accountIds));

@override
String toString() {
  return 'ReportScope(period: $period, accountIds: $accountIds)';
}


}

/// @nodoc
abstract mixin class _$ReportScopeCopyWith<$Res> implements $ReportScopeCopyWith<$Res> {
  factory _$ReportScopeCopyWith(_ReportScope value, $Res Function(_ReportScope) _then) = __$ReportScopeCopyWithImpl;
@override @useResult
$Res call({
 Period period, Set<String> accountIds
});




}
/// @nodoc
class __$ReportScopeCopyWithImpl<$Res>
    implements _$ReportScopeCopyWith<$Res> {
  __$ReportScopeCopyWithImpl(this._self, this._then);

  final _ReportScope _self;
  final $Res Function(_ReportScope) _then;

/// Create a copy of ReportScope
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? period = null,Object? accountIds = null,}) {
  return _then(_ReportScope(
period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as Period,accountIds: null == accountIds ? _self._accountIds : accountIds // ignore: cast_nullable_to_non_nullable
as Set<String>,
  ));
}


}

// dart format on

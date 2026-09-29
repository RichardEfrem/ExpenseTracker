// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_entry_notifiers.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LockScreenState {

 String get digits;/// The last rejected try (wrong or throttled), for the message.
 UnlockResult? get rejected; Failure? get failure; bool get checking;
/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LockScreenStateCopyWith<LockScreenState> get copyWith => _$LockScreenStateCopyWithImpl<LockScreenState>(this as LockScreenState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LockScreenState&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.checking, checking) || other.checking == checking));
}


@override
int get hashCode => Object.hash(runtimeType,digits,rejected,failure,checking);

@override
String toString() {
  return 'LockScreenState(digits: $digits, rejected: $rejected, failure: $failure, checking: $checking)';
}


}

/// @nodoc
abstract mixin class $LockScreenStateCopyWith<$Res>  {
  factory $LockScreenStateCopyWith(LockScreenState value, $Res Function(LockScreenState) _then) = _$LockScreenStateCopyWithImpl;
@useResult
$Res call({
 String digits, UnlockResult? rejected, Failure? failure, bool checking
});


$UnlockResultCopyWith<$Res>? get rejected;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$LockScreenStateCopyWithImpl<$Res>
    implements $LockScreenStateCopyWith<$Res> {
  _$LockScreenStateCopyWithImpl(this._self, this._then);

  final LockScreenState _self;
  final $Res Function(LockScreenState) _then;

/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? digits = null,Object? rejected = freezed,Object? failure = freezed,Object? checking = null,}) {
  return _then(LockScreenState(
digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as String,rejected: freezed == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as UnlockResult?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,checking: null == checking ? _self.checking : checking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockResultCopyWith<$Res>? get rejected {
    if (_self.rejected == null) {
    return null;
  }

  return $UnlockResultCopyWith<$Res>(_self.rejected!, (value) {
    return _then(_self.copyWith(rejected: value));
  });
}/// Create a copy of LockScreenState
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


/// Adds pattern-matching-related methods to [LockScreenState].
extension LockScreenStatePatterns on LockScreenState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LockScreenState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LockScreenState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LockScreenState value)  $default,){
final _that = this;
switch (_that) {
case _LockScreenState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LockScreenState value)?  $default,){
final _that = this;
switch (_that) {
case _LockScreenState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String digits,  UnlockResult? rejected,  Failure? failure,  bool checking)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LockScreenState() when $default != null:
return $default(_that.digits,_that.rejected,_that.failure,_that.checking);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String digits,  UnlockResult? rejected,  Failure? failure,  bool checking)  $default,) {final _that = this;
switch (_that) {
case _LockScreenState():
return $default(_that.digits,_that.rejected,_that.failure,_that.checking);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String digits,  UnlockResult? rejected,  Failure? failure,  bool checking)?  $default,) {final _that = this;
switch (_that) {
case _LockScreenState() when $default != null:
return $default(_that.digits,_that.rejected,_that.failure,_that.checking);case _:
  return null;

}
}

}

/// @nodoc


class _LockScreenState extends LockScreenState {
  const _LockScreenState({this.digits = '', this.rejected, this.failure, this.checking = false}): super._();
  

@override@JsonKey() final  String digits;
/// The last rejected try (wrong or throttled), for the message.
@override final  UnlockResult? rejected;
@override final  Failure? failure;
@override@JsonKey() final  bool checking;

/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LockScreenStateCopyWith<_LockScreenState> get copyWith => __$LockScreenStateCopyWithImpl<_LockScreenState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LockScreenState&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.checking, checking) || other.checking == checking));
}


@override
int get hashCode => Object.hash(runtimeType,digits,rejected,failure,checking);

@override
String toString() {
  return 'LockScreenState(digits: $digits, rejected: $rejected, failure: $failure, checking: $checking)';
}


}

/// @nodoc
abstract mixin class _$LockScreenStateCopyWith<$Res> implements $LockScreenStateCopyWith<$Res> {
  factory _$LockScreenStateCopyWith(_LockScreenState value, $Res Function(_LockScreenState) _then) = __$LockScreenStateCopyWithImpl;
@override @useResult
$Res call({
 String digits, UnlockResult? rejected, Failure? failure, bool checking
});


@override $UnlockResultCopyWith<$Res>? get rejected;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$LockScreenStateCopyWithImpl<$Res>
    implements _$LockScreenStateCopyWith<$Res> {
  __$LockScreenStateCopyWithImpl(this._self, this._then);

  final _LockScreenState _self;
  final $Res Function(_LockScreenState) _then;

/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? digits = null,Object? rejected = freezed,Object? failure = freezed,Object? checking = null,}) {
  return _then(_LockScreenState(
digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as String,rejected: freezed == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as UnlockResult?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,checking: null == checking ? _self.checking : checking // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LockScreenState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockResultCopyWith<$Res>? get rejected {
    if (_self.rejected == null) {
    return null;
  }

  return $UnlockResultCopyWith<$Res>(_self.rejected!, (value) {
    return _then(_self.copyWith(rejected: value));
  });
}/// Create a copy of LockScreenState
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

/// @nodoc
mixin _$PinSetupState {

 PinSetupStep get step; String get digits;/// The PIN typed in [PinSetupStep.choose].
 String get chosen; bool get mismatch; UnlockResult? get rejected; Failure? get failure; bool get busy;
/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PinSetupStateCopyWith<PinSetupState> get copyWith => _$PinSetupStateCopyWithImpl<PinSetupState>(this as PinSetupState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PinSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.chosen, chosen) || other.chosen == chosen)&&(identical(other.mismatch, mismatch) || other.mismatch == mismatch)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,step,digits,chosen,mismatch,rejected,failure,busy);

@override
String toString() {
  return 'PinSetupState(step: $step, digits: $digits, chosen: $chosen, mismatch: $mismatch, rejected: $rejected, failure: $failure, busy: $busy)';
}


}

/// @nodoc
abstract mixin class $PinSetupStateCopyWith<$Res>  {
  factory $PinSetupStateCopyWith(PinSetupState value, $Res Function(PinSetupState) _then) = _$PinSetupStateCopyWithImpl;
@useResult
$Res call({
 PinSetupStep step, String digits, String chosen, bool mismatch, UnlockResult? rejected, Failure? failure, bool busy
});


$UnlockResultCopyWith<$Res>? get rejected;$FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class _$PinSetupStateCopyWithImpl<$Res>
    implements $PinSetupStateCopyWith<$Res> {
  _$PinSetupStateCopyWithImpl(this._self, this._then);

  final PinSetupState _self;
  final $Res Function(PinSetupState) _then;

/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? step = null,Object? digits = null,Object? chosen = null,Object? mismatch = null,Object? rejected = freezed,Object? failure = freezed,Object? busy = null,}) {
  return _then(PinSetupState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PinSetupStep,digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as String,chosen: null == chosen ? _self.chosen : chosen // ignore: cast_nullable_to_non_nullable
as String,mismatch: null == mismatch ? _self.mismatch : mismatch // ignore: cast_nullable_to_non_nullable
as bool,rejected: freezed == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as UnlockResult?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockResultCopyWith<$Res>? get rejected {
    if (_self.rejected == null) {
    return null;
  }

  return $UnlockResultCopyWith<$Res>(_self.rejected!, (value) {
    return _then(_self.copyWith(rejected: value));
  });
}/// Create a copy of PinSetupState
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


/// Adds pattern-matching-related methods to [PinSetupState].
extension PinSetupStatePatterns on PinSetupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PinSetupState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PinSetupState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PinSetupState value)  $default,){
final _that = this;
switch (_that) {
case _PinSetupState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PinSetupState value)?  $default,){
final _that = this;
switch (_that) {
case _PinSetupState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PinSetupStep step,  String digits,  String chosen,  bool mismatch,  UnlockResult? rejected,  Failure? failure,  bool busy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PinSetupState() when $default != null:
return $default(_that.step,_that.digits,_that.chosen,_that.mismatch,_that.rejected,_that.failure,_that.busy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PinSetupStep step,  String digits,  String chosen,  bool mismatch,  UnlockResult? rejected,  Failure? failure,  bool busy)  $default,) {final _that = this;
switch (_that) {
case _PinSetupState():
return $default(_that.step,_that.digits,_that.chosen,_that.mismatch,_that.rejected,_that.failure,_that.busy);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PinSetupStep step,  String digits,  String chosen,  bool mismatch,  UnlockResult? rejected,  Failure? failure,  bool busy)?  $default,) {final _that = this;
switch (_that) {
case _PinSetupState() when $default != null:
return $default(_that.step,_that.digits,_that.chosen,_that.mismatch,_that.rejected,_that.failure,_that.busy);case _:
  return null;

}
}

}

/// @nodoc


class _PinSetupState extends PinSetupState {
  const _PinSetupState({required this.step, this.digits = '', this.chosen = '', this.mismatch = false, this.rejected, this.failure, this.busy = false}): super._();
  

@override final  PinSetupStep step;
@override@JsonKey() final  String digits;
/// The PIN typed in [PinSetupStep.choose].
@override@JsonKey() final  String chosen;
@override@JsonKey() final  bool mismatch;
@override final  UnlockResult? rejected;
@override final  Failure? failure;
@override@JsonKey() final  bool busy;

/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PinSetupStateCopyWith<_PinSetupState> get copyWith => __$PinSetupStateCopyWithImpl<_PinSetupState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PinSetupState&&(identical(other.step, step) || other.step == step)&&(identical(other.digits, digits) || other.digits == digits)&&(identical(other.chosen, chosen) || other.chosen == chosen)&&(identical(other.mismatch, mismatch) || other.mismatch == mismatch)&&(identical(other.rejected, rejected) || other.rejected == rejected)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.busy, busy) || other.busy == busy));
}


@override
int get hashCode => Object.hash(runtimeType,step,digits,chosen,mismatch,rejected,failure,busy);

@override
String toString() {
  return 'PinSetupState(step: $step, digits: $digits, chosen: $chosen, mismatch: $mismatch, rejected: $rejected, failure: $failure, busy: $busy)';
}


}

/// @nodoc
abstract mixin class _$PinSetupStateCopyWith<$Res> implements $PinSetupStateCopyWith<$Res> {
  factory _$PinSetupStateCopyWith(_PinSetupState value, $Res Function(_PinSetupState) _then) = __$PinSetupStateCopyWithImpl;
@override @useResult
$Res call({
 PinSetupStep step, String digits, String chosen, bool mismatch, UnlockResult? rejected, Failure? failure, bool busy
});


@override $UnlockResultCopyWith<$Res>? get rejected;@override $FailureCopyWith<$Res>? get failure;

}
/// @nodoc
class __$PinSetupStateCopyWithImpl<$Res>
    implements _$PinSetupStateCopyWith<$Res> {
  __$PinSetupStateCopyWithImpl(this._self, this._then);

  final _PinSetupState _self;
  final $Res Function(_PinSetupState) _then;

/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? step = null,Object? digits = null,Object? chosen = null,Object? mismatch = null,Object? rejected = freezed,Object? failure = freezed,Object? busy = null,}) {
  return _then(_PinSetupState(
step: null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as PinSetupStep,digits: null == digits ? _self.digits : digits // ignore: cast_nullable_to_non_nullable
as String,chosen: null == chosen ? _self.chosen : chosen // ignore: cast_nullable_to_non_nullable
as String,mismatch: null == mismatch ? _self.mismatch : mismatch // ignore: cast_nullable_to_non_nullable
as bool,rejected: freezed == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as UnlockResult?,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure?,busy: null == busy ? _self.busy : busy // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PinSetupState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UnlockResultCopyWith<$Res>? get rejected {
    if (_self.rejected == null) {
    return null;
  }

  return $UnlockResultCopyWith<$Res>(_self.rejected!, (value) {
    return _then(_self.copyWith(rejected: value));
  });
}/// Create a copy of PinSetupState
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

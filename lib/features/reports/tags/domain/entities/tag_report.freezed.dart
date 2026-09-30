// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tag_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TagTotal {

 String get name; int get amount; int get count;
/// Create a copy of TagTotal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagTotalCopyWith<TagTotal> get copyWith => _$TagTotalCopyWithImpl<TagTotal>(this as TagTotal, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagTotal&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,name,amount,count);

@override
String toString() {
  return 'TagTotal(name: $name, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class $TagTotalCopyWith<$Res>  {
  factory $TagTotalCopyWith(TagTotal value, $Res Function(TagTotal) _then) = _$TagTotalCopyWithImpl;
@useResult
$Res call({
 String name, int amount, int count
});




}
/// @nodoc
class _$TagTotalCopyWithImpl<$Res>
    implements $TagTotalCopyWith<$Res> {
  _$TagTotalCopyWithImpl(this._self, this._then);

  final TagTotal _self;
  final $Res Function(TagTotal) _then;

/// Create a copy of TagTotal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? amount = null,Object? count = null,}) {
  return _then(TagTotal(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TagTotal].
extension TagTotalPatterns on TagTotal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagTotal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagTotal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagTotal value)  $default,){
final _that = this;
switch (_that) {
case _TagTotal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagTotal value)?  $default,){
final _that = this;
switch (_that) {
case _TagTotal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int amount,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagTotal() when $default != null:
return $default(_that.name,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int amount,  int count)  $default,) {final _that = this;
switch (_that) {
case _TagTotal():
return $default(_that.name,_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int amount,  int count)?  $default,) {final _that = this;
switch (_that) {
case _TagTotal() when $default != null:
return $default(_that.name,_that.amount,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _TagTotal implements TagTotal {
  const _TagTotal({required this.name, required this.amount, required this.count});
  

@override final  String name;
@override final  int amount;
@override final  int count;

/// Create a copy of TagTotal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagTotalCopyWith<_TagTotal> get copyWith => __$TagTotalCopyWithImpl<_TagTotal>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagTotal&&(identical(other.name, name) || other.name == name)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,name,amount,count);

@override
String toString() {
  return 'TagTotal(name: $name, amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class _$TagTotalCopyWith<$Res> implements $TagTotalCopyWith<$Res> {
  factory _$TagTotalCopyWith(_TagTotal value, $Res Function(_TagTotal) _then) = __$TagTotalCopyWithImpl;
@override @useResult
$Res call({
 String name, int amount, int count
});




}
/// @nodoc
class __$TagTotalCopyWithImpl<$Res>
    implements _$TagTotalCopyWith<$Res> {
  __$TagTotalCopyWithImpl(this._self, this._then);

  final _TagTotal _self;
  final $Res Function(_TagTotal) _then;

/// Create a copy of TagTotal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? amount = null,Object? count = null,}) {
  return _then(_TagTotal(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$TagReport {

 CategoryType get type; List<TagTotal> get totals;
/// Create a copy of TagReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TagReportCopyWith<TagReport> get copyWith => _$TagReportCopyWithImpl<TagReport>(this as TagReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TagReport&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.totals, totals));
}


@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(totals));

@override
String toString() {
  return 'TagReport(type: $type, totals: $totals)';
}


}

/// @nodoc
abstract mixin class $TagReportCopyWith<$Res>  {
  factory $TagReportCopyWith(TagReport value, $Res Function(TagReport) _then) = _$TagReportCopyWithImpl;
@useResult
$Res call({
 CategoryType type, List<TagTotal> totals
});




}
/// @nodoc
class _$TagReportCopyWithImpl<$Res>
    implements $TagReportCopyWith<$Res> {
  _$TagReportCopyWithImpl(this._self, this._then);

  final TagReport _self;
  final $Res Function(TagReport) _then;

/// Create a copy of TagReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? type = null,Object? totals = null,}) {
  return _then(TagReport(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,totals: null == totals ? _self.totals : totals // ignore: cast_nullable_to_non_nullable
as List<TagTotal>,
  ));
}

}


/// Adds pattern-matching-related methods to [TagReport].
extension TagReportPatterns on TagReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TagReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TagReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TagReport value)  $default,){
final _that = this;
switch (_that) {
case _TagReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TagReport value)?  $default,){
final _that = this;
switch (_that) {
case _TagReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryType type,  List<TagTotal> totals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TagReport() when $default != null:
return $default(_that.type,_that.totals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryType type,  List<TagTotal> totals)  $default,) {final _that = this;
switch (_that) {
case _TagReport():
return $default(_that.type,_that.totals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryType type,  List<TagTotal> totals)?  $default,) {final _that = this;
switch (_that) {
case _TagReport() when $default != null:
return $default(_that.type,_that.totals);case _:
  return null;

}
}

}

/// @nodoc


class _TagReport extends TagReport {
  const _TagReport({required this.type, required  List<TagTotal> totals}): _totals = totals,super._();
  

@override final  CategoryType type;
 final  List<TagTotal> _totals;
@override List<TagTotal> get totals {
  if (_totals is EqualUnmodifiableListView) return _totals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_totals);
}


/// Create a copy of TagReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TagReportCopyWith<_TagReport> get copyWith => __$TagReportCopyWithImpl<_TagReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TagReport&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._totals, _totals));
}


@override
int get hashCode => Object.hash(runtimeType,type,const DeepCollectionEquality().hash(_totals));

@override
String toString() {
  return 'TagReport(type: $type, totals: $totals)';
}


}

/// @nodoc
abstract mixin class _$TagReportCopyWith<$Res> implements $TagReportCopyWith<$Res> {
  factory _$TagReportCopyWith(_TagReport value, $Res Function(_TagReport) _then) = __$TagReportCopyWithImpl;
@override @useResult
$Res call({
 CategoryType type, List<TagTotal> totals
});




}
/// @nodoc
class __$TagReportCopyWithImpl<$Res>
    implements _$TagReportCopyWith<$Res> {
  __$TagReportCopyWithImpl(this._self, this._then);

  final _TagReport _self;
  final $Res Function(_TagReport) _then;

/// Create a copy of TagReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? type = null,Object? totals = null,}) {
  return _then(_TagReport(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CategoryType,totals: null == totals ? _self._totals : totals // ignore: cast_nullable_to_non_nullable
as List<TagTotal>,
  ));
}


}

// dart format on

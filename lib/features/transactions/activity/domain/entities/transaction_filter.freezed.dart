// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_filter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionFilter {

/// Matches note, category name or tag name, case-insensitive.
 String get text; Set<TransactionType> get types; Set<String> get categoryIds; Set<String> get accountIds;/// Tag names; a transaction matches when it has any of them.
 Set<String> get tags; LocalDate? get from; LocalDate? get to; int? get minAmount; int? get maxAmount;
/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TransactionFilterCopyWith<TransactionFilter> get copyWith => _$TransactionFilterCopyWithImpl<TransactionFilter>(this as TransactionFilter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionFilter&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other.types, types)&&const DeepCollectionEquality().equals(other.categoryIds, categoryIds)&&const DeepCollectionEquality().equals(other.accountIds, accountIds)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.minAmount, minAmount) || other.minAmount == minAmount)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(types),const DeepCollectionEquality().hash(categoryIds),const DeepCollectionEquality().hash(accountIds),const DeepCollectionEquality().hash(tags),from,to,minAmount,maxAmount);

@override
String toString() {
  return 'TransactionFilter(text: $text, types: $types, categoryIds: $categoryIds, accountIds: $accountIds, tags: $tags, from: $from, to: $to, minAmount: $minAmount, maxAmount: $maxAmount)';
}


}

/// @nodoc
abstract mixin class $TransactionFilterCopyWith<$Res>  {
  factory $TransactionFilterCopyWith(TransactionFilter value, $Res Function(TransactionFilter) _then) = _$TransactionFilterCopyWithImpl;
@useResult
$Res call({
 String text, Set<TransactionType> types, Set<String> categoryIds, Set<String> accountIds, Set<String> tags, LocalDate? from, LocalDate? to, int? minAmount, int? maxAmount
});




}
/// @nodoc
class _$TransactionFilterCopyWithImpl<$Res>
    implements $TransactionFilterCopyWith<$Res> {
  _$TransactionFilterCopyWithImpl(this._self, this._then);

  final TransactionFilter _self;
  final $Res Function(TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? types = null,Object? categoryIds = null,Object? accountIds = null,Object? tags = null,Object? from = freezed,Object? to = freezed,Object? minAmount = freezed,Object? maxAmount = freezed,}) {
  return _then(TransactionFilter(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as Set<TransactionType>,categoryIds: null == categoryIds ? _self.categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,accountIds: null == accountIds ? _self.accountIds : accountIds // ignore: cast_nullable_to_non_nullable
as Set<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as LocalDate?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as LocalDate?,minAmount: freezed == minAmount ? _self.minAmount : minAmount // ignore: cast_nullable_to_non_nullable
as int?,maxAmount: freezed == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TransactionFilter].
extension TransactionFilterPatterns on TransactionFilter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionFilter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionFilter value)  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionFilter value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  Set<TransactionType> types,  Set<String> categoryIds,  Set<String> accountIds,  Set<String> tags,  LocalDate? from,  LocalDate? to,  int? minAmount,  int? maxAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.text,_that.types,_that.categoryIds,_that.accountIds,_that.tags,_that.from,_that.to,_that.minAmount,_that.maxAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  Set<TransactionType> types,  Set<String> categoryIds,  Set<String> accountIds,  Set<String> tags,  LocalDate? from,  LocalDate? to,  int? minAmount,  int? maxAmount)  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter():
return $default(_that.text,_that.types,_that.categoryIds,_that.accountIds,_that.tags,_that.from,_that.to,_that.minAmount,_that.maxAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  Set<TransactionType> types,  Set<String> categoryIds,  Set<String> accountIds,  Set<String> tags,  LocalDate? from,  LocalDate? to,  int? minAmount,  int? maxAmount)?  $default,) {final _that = this;
switch (_that) {
case _TransactionFilter() when $default != null:
return $default(_that.text,_that.types,_that.categoryIds,_that.accountIds,_that.tags,_that.from,_that.to,_that.minAmount,_that.maxAmount);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionFilter extends TransactionFilter {
  const _TransactionFilter({this.text = '',  Set<TransactionType> types = const <TransactionType>{},  Set<String> categoryIds = const <String>{},  Set<String> accountIds = const <String>{},  Set<String> tags = const <String>{}, this.from, this.to, this.minAmount, this.maxAmount}): _types = types,_categoryIds = categoryIds,_accountIds = accountIds,_tags = tags,super._();
  

/// Matches note, category name or tag name, case-insensitive.
@override@JsonKey() final  String text;
 final  Set<TransactionType> _types;
@override@JsonKey() Set<TransactionType> get types {
  if (_types is EqualUnmodifiableSetView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_types);
}

 final  Set<String> _categoryIds;
@override@JsonKey() Set<String> get categoryIds {
  if (_categoryIds is EqualUnmodifiableSetView) return _categoryIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categoryIds);
}

 final  Set<String> _accountIds;
@override@JsonKey() Set<String> get accountIds {
  if (_accountIds is EqualUnmodifiableSetView) return _accountIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_accountIds);
}

/// Tag names; a transaction matches when it has any of them.
 final  Set<String> _tags;
/// Tag names; a transaction matches when it has any of them.
@override@JsonKey() Set<String> get tags {
  if (_tags is EqualUnmodifiableSetView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_tags);
}

@override final  LocalDate? from;
@override final  LocalDate? to;
@override final  int? minAmount;
@override final  int? maxAmount;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TransactionFilterCopyWith<_TransactionFilter> get copyWith => __$TransactionFilterCopyWithImpl<_TransactionFilter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionFilter&&(identical(other.text, text) || other.text == text)&&const DeepCollectionEquality().equals(other._types, _types)&&const DeepCollectionEquality().equals(other._categoryIds, _categoryIds)&&const DeepCollectionEquality().equals(other._accountIds, _accountIds)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.from, from) || other.from == from)&&(identical(other.to, to) || other.to == to)&&(identical(other.minAmount, minAmount) || other.minAmount == minAmount)&&(identical(other.maxAmount, maxAmount) || other.maxAmount == maxAmount));
}


@override
int get hashCode => Object.hash(runtimeType,text,const DeepCollectionEquality().hash(_types),const DeepCollectionEquality().hash(_categoryIds),const DeepCollectionEquality().hash(_accountIds),const DeepCollectionEquality().hash(_tags),from,to,minAmount,maxAmount);

@override
String toString() {
  return 'TransactionFilter(text: $text, types: $types, categoryIds: $categoryIds, accountIds: $accountIds, tags: $tags, from: $from, to: $to, minAmount: $minAmount, maxAmount: $maxAmount)';
}


}

/// @nodoc
abstract mixin class _$TransactionFilterCopyWith<$Res> implements $TransactionFilterCopyWith<$Res> {
  factory _$TransactionFilterCopyWith(_TransactionFilter value, $Res Function(_TransactionFilter) _then) = __$TransactionFilterCopyWithImpl;
@override @useResult
$Res call({
 String text, Set<TransactionType> types, Set<String> categoryIds, Set<String> accountIds, Set<String> tags, LocalDate? from, LocalDate? to, int? minAmount, int? maxAmount
});




}
/// @nodoc
class __$TransactionFilterCopyWithImpl<$Res>
    implements _$TransactionFilterCopyWith<$Res> {
  __$TransactionFilterCopyWithImpl(this._self, this._then);

  final _TransactionFilter _self;
  final $Res Function(_TransactionFilter) _then;

/// Create a copy of TransactionFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? types = null,Object? categoryIds = null,Object? accountIds = null,Object? tags = null,Object? from = freezed,Object? to = freezed,Object? minAmount = freezed,Object? maxAmount = freezed,}) {
  return _then(_TransactionFilter(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as Set<TransactionType>,categoryIds: null == categoryIds ? _self._categoryIds : categoryIds // ignore: cast_nullable_to_non_nullable
as Set<String>,accountIds: null == accountIds ? _self._accountIds : accountIds // ignore: cast_nullable_to_non_nullable
as Set<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as Set<String>,from: freezed == from ? _self.from : from // ignore: cast_nullable_to_non_nullable
as LocalDate?,to: freezed == to ? _self.to : to // ignore: cast_nullable_to_non_nullable
as LocalDate?,minAmount: freezed == minAmount ? _self.minAmount : minAmount // ignore: cast_nullable_to_non_nullable
as int?,maxAmount: freezed == maxAmount ? _self.maxAmount : maxAmount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on

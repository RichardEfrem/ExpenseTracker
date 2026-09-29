// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transaction_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TransactionView {

 Transaction get transaction; Category? get category; Account get account; Account? get toAccount;



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TransactionView&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount));
}


@override
int get hashCode => Object.hash(runtimeType,transaction,category,account,toAccount);

@override
String toString() {
  return 'TransactionView(transaction: $transaction, category: $category, account: $account, toAccount: $toAccount)';
}


}




/// Adds pattern-matching-related methods to [TransactionView].
extension TransactionViewPatterns on TransactionView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TransactionView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TransactionView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TransactionView value)  $default,){
final _that = this;
switch (_that) {
case _TransactionView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TransactionView value)?  $default,){
final _that = this;
switch (_that) {
case _TransactionView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Transaction transaction,  Category? category,  Account account,  Account? toAccount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TransactionView() when $default != null:
return $default(_that.transaction,_that.category,_that.account,_that.toAccount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Transaction transaction,  Category? category,  Account account,  Account? toAccount)  $default,) {final _that = this;
switch (_that) {
case _TransactionView():
return $default(_that.transaction,_that.category,_that.account,_that.toAccount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Transaction transaction,  Category? category,  Account account,  Account? toAccount)?  $default,) {final _that = this;
switch (_that) {
case _TransactionView() when $default != null:
return $default(_that.transaction,_that.category,_that.account,_that.toAccount);case _:
  return null;

}
}

}

/// @nodoc


class _TransactionView implements TransactionView {
  const _TransactionView({required this.transaction, this.category, required this.account, this.toAccount});
  

@override final  Transaction transaction;
@override final  Category? category;
@override final  Account account;
@override final  Account? toAccount;




@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TransactionView&&(identical(other.transaction, transaction) || other.transaction == transaction)&&(identical(other.category, category) || other.category == category)&&(identical(other.account, account) || other.account == account)&&(identical(other.toAccount, toAccount) || other.toAccount == toAccount));
}


@override
int get hashCode => Object.hash(runtimeType,transaction,category,account,toAccount);

@override
String toString() {
  return 'TransactionView(transaction: $transaction, category: $category, account: $account, toAccount: $toAccount)';
}


}




// dart format on

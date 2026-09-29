import 'package:expense_tracker/features/accounts/accounts_domain.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_view.freezed.dart';

/// A transaction with the category and accounts it refers to, for display.
/// Read-only, so no copyWith (it would reach into other modules' types).
@Freezed(copyWith: false)
abstract class TransactionView with _$TransactionView {
  const factory TransactionView({
    required Transaction transaction,
    Category? category,
    required Account account,
    Account? toAccount,
  }) = _TransactionView;
}

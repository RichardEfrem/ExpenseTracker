import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_form_state.freezed.dart';

@freezed
abstract class TransactionFormState with _$TransactionFormState {
  const factory TransactionFormState({
    /// Set when editing an existing transaction.
    String? editingId,
    required TransactionType type,

    /// Keypad text, e.g. `25000+12500`.
    @Default('') String expression,

    /// [expression] evaluated; null while empty or invalid.
    int? amount,
    String? categoryId,

    /// The last-used category, shown first in the grid.
    String? firstCategoryId,
    required String accountId,

    /// Transfers only: the destination account.
    String? toAccountId,
    required LocalDate date,
    required LocalTime time,
    String? note,
    @Default(false) bool saving,
    Failure? failure,
  }) = _TransactionFormState;

  const TransactionFormState._();

  bool get isEditing => editingId != null;

  /// Save is enabled once there is an amount and, for income/expense, a
  /// category (DESIGN §8.2).
  bool get canSave =>
      !saving &&
      (amount ?? 0) > 0 &&
      (!type.needsCategory || categoryId != null) &&
      (type != TransactionType.transfer ||
          (toAccountId != null && toAccountId != accountId));
}

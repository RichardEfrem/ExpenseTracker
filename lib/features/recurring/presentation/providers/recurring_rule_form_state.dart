import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_rule_form_state.freezed.dart';

@freezed
abstract class RecurringRuleFormState with _$RecurringRuleFormState {
  const factory RecurringRuleFormState({
    /// Set when editing an existing rule.
    String? editingId,
    required TransactionType type,

    /// Keypad text, e.g. `25000+12500`.
    @Default('') String expression,

    /// [expression] evaluated; null while empty or invalid.
    int? amount,
    String? categoryId,

    /// The category shown first in the grid.
    String? firstCategoryId,
    required String accountId,

    /// Transfers only: the destination account.
    String? toAccountId,
    String? note,
    required RecurrenceFrequency frequency,
    @Default(1) int interval,

    /// Monthly only; null follows [startDate]'s day.
    int? dayOfMonth,
    required LocalDate startDate,
    LocalDate? endDate,
    @Default(true) bool autoCreate,
    @Default(false) bool saving,
    Failure? failure,
  }) = _RecurringRuleFormState;

  const RecurringRuleFormState._();

  bool get isEditing => editingId != null;

  /// The monthly day in effect.
  int get effectiveDayOfMonth => dayOfMonth ?? startDate.day;

  /// Same conditions as the Add screen's Save (DESIGN §8.2).
  bool get canSave =>
      !saving &&
      (amount ?? 0) > 0 &&
      (!type.needsCategory || categoryId != null) &&
      (type != TransactionType.transfer ||
          (toAccountId != null && toAccountId != accountId));
}

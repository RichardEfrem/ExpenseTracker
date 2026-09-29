import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_rule_input.freezed.dart';

@freezed
abstract class RecurringRuleInput with _$RecurringRuleInput {
  const factory RecurringRuleInput({
    required TransactionType type,
    required int amount,
    required String accountId,
    String? toAccountId,
    String? categoryId,
    String? note,
    required RecurrenceFrequency frequency,
    @Default(1) int interval,
    int? dayOfMonth,
    required LocalDate startDate,
    LocalDate? endDate,
    @Default(true) bool autoCreate,
  }) = _RecurringRuleInput;

  const RecurringRuleInput._();

  static const maxInterval = 365;

  /// Validated with the same rules as a transaction, plus the schedule.
  Either<ValidationReason, RecurringRuleInput> validated() {
    // Adjustments correct a balance once; they never repeat.
    if (type == TransactionType.adjustment) {
      return const Left(ValidationReason.invalidInput);
    }
    if (interval < 1 || interval > maxInterval) {
      return const Left(ValidationReason.intervalOutOfRange);
    }
    final day = dayOfMonth;
    if (day != null && (day < 1 || day > 31)) {
      return const Left(ValidationReason.dayOfMonthOutOfRange);
    }
    if (endDate != null && endDate! < startDate) {
      return const Left(ValidationReason.endBeforeStart);
    }
    return templateInput(startDate).validated().map(
      (t) => copyWith(
        note: t.note,
        categoryId: t.categoryId,
        toAccountId: t.toAccountId,
        dayOfMonth: frequency == RecurrenceFrequency.monthly
            ? (dayOfMonth ?? startDate.day)
            : null,
      ),
    );
  }

  /// The transaction this rule creates on [date].
  TransactionInput templateInput(LocalDate date) => TransactionInput(
    type: type,
    amount: amount,
    accountId: accountId,
    toAccountId: toAccountId,
    categoryId: categoryId,
    date: date,
    time: const LocalTime(0, 0),
    note: note,
  );
}

import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recurring_rule.freezed.dart';

/// A template transaction plus its schedule (PRD REC-01…03).
@freezed
abstract class RecurringRule with _$RecurringRule {
  const factory RecurringRule({
    required String id,
    required TransactionType type,
    required int amount,
    required String accountId,
    String? toAccountId,
    String? categoryId,
    String? note,
    required RecurrenceFrequency frequency,
    required int interval,
    int? dayOfMonth,
    required LocalDate startDate,
    LocalDate? endDate,
    required bool autoCreate,
    LocalDate? lastGeneratedDate,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RecurringRule;

  const RecurringRule._();

  /// The rule's editable fields, e.g. to prefill the edit form.
  RecurringRuleInput get input => RecurringRuleInput(
    type: type,
    amount: amount,
    accountId: accountId,
    toAccountId: toAccountId,
    categoryId: categoryId,
    note: note,
    frequency: frequency,
    interval: interval,
    dayOfMonth: dayOfMonth,
    startDate: startDate,
    endDate: endDate,
    autoCreate: autoCreate,
  );

  RecurrenceSchedule get schedule => RecurrenceSchedule(
    frequency: frequency,
    interval: interval,
    dayOfMonth: dayOfMonth,
    start: startDate,
    end: endDate,
  );

  /// The next date not generated yet, or null once the rule has ended.
  LocalDate? get nextDate => schedule.nextOnOrAfter(
    lastGeneratedDate == null
        ? startDate
        : LocalDate.max(startDate, lastGeneratedDate!.addDays(1)),
  );
}

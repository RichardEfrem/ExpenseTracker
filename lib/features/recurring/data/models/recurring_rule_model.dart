import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/accounts/accounts_data.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/transactions/transactions_data.dart';

/// A rule row with its category and accounts, as one SQL join.
typedef JoinedRuleRow = ({
  RecurringRuleRow rule,
  CategoryRow? category,
  AccountRow account,
  AccountRow? toAccount,
});

DateTime _utc(int ms) => DateTime.fromMillisecondsSinceEpoch(ms, isUtc: true);

extension RecurringRuleRowMapper on RecurringRuleRow {
  RecurringRule toEntity() => RecurringRule(
    id: id,
    type: TransactionType.values.byName(type),
    amount: amount,
    accountId: accountId,
    toAccountId: toAccountId,
    categoryId: categoryId,
    note: note,
    frequency: RecurrenceFrequency.values.byName(frequency),
    interval: interval,
    dayOfMonth: dayOfMonth,
    startDate: LocalDate.parse(startDate),
    endDate: endDate == null ? null : LocalDate.parse(endDate!),
    autoCreate: autoCreate,
    lastGeneratedDate: lastGeneratedDate == null
        ? null
        : LocalDate.parse(lastGeneratedDate!),
    createdAt: _utc(createdAt),
    updatedAt: _utc(updatedAt),
  );
}

extension PendingOccurrenceRowMapper on PendingOccurrenceRow {
  PendingOccurrence toEntity() => PendingOccurrence(
    id: id,
    ruleId: ruleId,
    date: LocalDate.parse(date),
    createdAt: _utc(createdAt),
  );
}

extension JoinedRuleMapper on JoinedRuleRow {
  RuleView toView() => RuleView(
    rule: rule.toEntity(),
    category: category?.toEntity(),
    account: account.toEntity(),
    toAccount: toAccount?.toEntity(),
  );
}

extension RecurringRuleInputJson on RecurringRuleInput {
  /// The write payload, keyed by `recurring_rules` column. Every key is
  /// always present: an explicit null clears the column on update (a removed
  /// note or end date). Generation state is never part of it.
  Map<String, Object?> toJson() => {
    'type': type.name,
    'amount': amount,
    'account_id': accountId,
    'to_account_id': toAccountId,
    'category_id': categoryId,
    'note': note,
    'frequency': frequency.name,
    'interval': interval,
    'day_of_month': dayOfMonth,
    'start_date': startDate.toIso(),
    'end_date': endDate?.toIso(),
    'auto_create': autoCreate,
  };
}

extension RecurringRuleTemplateJson on RecurringRule {
  /// The `transactions` row this rule creates on [date], linked back to it.
  Map<String, Object?> transactionJson(LocalDate date) => {
    ...input.templateInput(date).toJson(),
    'recurring_rule_id': id,
  };
}

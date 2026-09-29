import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/recurring/data/models/recurring_rule_model.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurrence.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule.dart';
import 'package:expense_tracker/features/recurring/domain/entities/recurring_rule_input.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('input payload writes every column, nulls explicitly', () {
    final json = RecurringRuleInput(
      type: TransactionType.expense,
      amount: 3000000,
      accountId: 'cash',
      categoryId: 'housing',
      frequency: RecurrenceFrequency.monthly,
      dayOfMonth: 31,
      startDate: LocalDate(2026, 1, 31),
      autoCreate: false,
    ).toJson();
    expect(json, {
      'type': 'expense',
      'amount': 3000000,
      'account_id': 'cash',
      'to_account_id': null,
      'category_id': 'housing',
      'note': null,
      'frequency': 'monthly',
      'interval': 1,
      'day_of_month': 31,
      'start_date': '2026-01-31',
      'end_date': null,
      'auto_create': false,
    });
    // An explicit null clears the column on update (removed note/end).
    for (final key in ['to_account_id', 'note', 'end_date']) {
      expect(json.containsKey(key), isTrue, reason: key);
    }
    // Generation state is never overwritten by an edit.
    expect(json.containsKey('last_generated_date'), isFalse);
  });

  test('generated transaction payload links back to the rule', () {
    final rule = RecurringRule(
      id: 'r1',
      type: TransactionType.transfer,
      amount: 500000,
      accountId: 'cash',
      toAccountId: 'bank',
      note: 'Savings',
      frequency: RecurrenceFrequency.weekly,
      interval: 1,
      startDate: LocalDate(2026, 9, 7),
      autoCreate: true,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );
    expect(rule.transactionJson(LocalDate(2026, 9, 14)), {
      'type': 'transfer',
      'amount': 500000,
      'account_id': 'cash',
      'to_account_id': 'bank',
      'category_id': null,
      'date': '2026-09-14',
      'time': '00:00',
      'note': 'Savings',
      'recurring_rule_id': 'r1',
    });
  });
}

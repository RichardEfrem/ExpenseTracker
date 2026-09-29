import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/transactions/transaction/data/models/transaction_model.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final input = TransactionInput(
    type: TransactionType.expense,
    amount: 45000,
    accountId: 'cash',
    categoryId: 'food',
    date: LocalDate(2026, 9, 5),
    time: const LocalTime(8, 5),
    note: 'Lunch',
  );

  test('payload keys are column names; date and time are local text', () {
    expect(input.toJson(), {
      'type': 'expense',
      'amount': 45000,
      'account_id': 'cash',
      'to_account_id': null,
      'category_id': 'food',
      'date': '2026-09-05',
      'time': '08:05',
      'note': 'Lunch',
    });
  });

  test(
    'a removed note is an explicit null, not omitted (clears on update)',
    () {
      final json = input.copyWith(note: null).toJson();
      expect(json.containsKey('note'), isTrue);
      expect(json['note'], isNull);
    },
  );

  test('to_account_id is always present so a type change clears it', () {
    expect(input.toJson().containsKey('to_account_id'), isTrue);
  });

  test('restore payload carries every column including id and timestamps', () {
    final t = Transaction(
      id: 'abc',
      type: TransactionType.income,
      amount: 10,
      accountId: 'cash',
      categoryId: 'salary',
      date: LocalDate(2026, 1, 2),
      time: const LocalTime(23, 59),
      createdAt: DateTime.utc(2026, 1, 2, 16, 59),
      updatedAt: DateTime.utc(2026, 1, 3),
    );
    expect(t.toRowJson(), {
      'id': 'abc',
      'type': 'income',
      'amount': 10,
      'account_id': 'cash',
      'to_account_id': null,
      'category_id': 'salary',
      'date': '2026-01-02',
      'time': '23:59',
      'note': null,
      'recurring_rule_id': null,
      'receipt_path': null,
      'created_at': DateTime.utc(2026, 1, 2, 16, 59).millisecondsSinceEpoch,
      'updated_at': DateTime.utc(2026, 1, 3).millisecondsSinceEpoch,
    });
  });

  test('transfer payload: destination set, no category', () {
    final transfer = input
        .copyWith(type: TransactionType.transfer, toAccountId: 'bank')
        .validated()
        .toNullable()!;
    expect(transfer.toJson(), {
      'type': 'transfer',
      'amount': 45000,
      'account_id': 'cash',
      'to_account_id': 'bank',
      'category_id': null,
      'date': '2026-09-05',
      'time': '08:05',
      'note': 'Lunch',
    });
  });

  test('adjustment keeps its direction only as to-itself', () {
    TransactionInput adjustment(String? to) => input
        .copyWith(type: TransactionType.adjustment, toAccountId: to)
        .validated()
        .toNullable()!;
    expect(adjustment('cash').toAccountId, 'cash');
    expect(adjustment('bank').toAccountId, isNull);
    expect(adjustment('cash').categoryId, isNull);
  });
}

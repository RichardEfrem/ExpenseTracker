import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/local_time.dart';
import 'package:expense_tracker/features/backup/csv_export/data/models/csv_transaction_row_model.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/entities/csv_transaction_row.dart';
import 'package:expense_tracker/features/transactions/transactions_domain.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('header is pinned', () {
    expect(csvHeader, [
      'date',
      'time',
      'type',
      'amount',
      'category',
      'account',
      'to_account',
      'note',
      'tags',
    ]);
  });

  test('expense: every field, plain integer amount', () {
    final row = CsvTransactionRow(
      date: LocalDate(2026, 9, 5),
      time: LocalTime.parse('07:05'),
      type: TransactionType.expense,
      amount: 1250000,
      category: 'Food & Drinks',
      account: 'Cash',
      note: 'Lunch, with "team"',
      tags: ['food', 'trip-bali'],
    );
    expect(row.toCsvFields(), [
      '2026-09-05',
      '07:05',
      'expense',
      '1250000',
      'Food & Drinks',
      'Cash',
      '',
      'Lunch, with "team"',
      'food, trip-bali',
    ]);
  });

  test('transfer: no category, to_account set; nulls are empty', () {
    final row = CsvTransactionRow(
      date: LocalDate(2026, 1, 1),
      time: LocalTime.parse('23:59'),
      type: TransactionType.transfer,
      amount: 500000,
      account: 'Cash',
      toAccount: 'BCA',
    );
    expect(row.toCsvFields(), [
      '2026-01-01',
      '23:59',
      'transfer',
      '500000',
      '',
      'Cash',
      'BCA',
      '',
      '',
    ]);
  });

  test('money-out adjustment is negative', () {
    final row = CsvTransactionRow(
      date: LocalDate(2026, 1, 1),
      time: LocalTime.parse('09:00'),
      type: TransactionType.adjustment,
      amount: -20000,
      account: 'Cash',
    );
    expect(row.toCsvFields()[3], '-20000');
  });

  test('typed text that looks like a formula is neutralized', () {
    final row = CsvTransactionRow(
      date: LocalDate(2026, 1, 1),
      time: LocalTime.parse('09:00'),
      type: TransactionType.income,
      amount: 1,
      category: '=Salary',
      account: '+Wallet',
      note: '@home',
    );
    final fields = row.toCsvFields();
    expect(fields[4], "'=Salary");
    expect(fields[5], "'+Wallet");
    expect(fields[7], "'@home");
  });
}

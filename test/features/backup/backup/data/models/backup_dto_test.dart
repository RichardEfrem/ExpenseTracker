import 'package:expense_tracker/features/backup/backup/data/models/backup_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const account = AccountDto(
    id: 'a',
    name: 'Cash',
    type: 'cash',
    icon: 'payments',
    color: 'emerald',
    openingBalance: 0,
    isArchived: false,
    sortOrder: 0,
    createdAt: 1,
    updatedAt: 2,
  );
  const category = CategoryDto(
    id: 'c',
    name: 'Food',
    type: 'expense',
    icon: 'restaurant',
    color: 'orange',
    isArchived: true,
    sortOrder: 3,
    createdAt: 1,
    updatedAt: 2,
  );
  const transaction = TransactionDto(
    id: 't',
    type: 'expense',
    amount: 45000,
    accountId: 'a',
    toAccountId: null,
    categoryId: 'c',
    date: '2026-09-29',
    time: '12:30',
    note: null,
    recurringRuleId: null,
    receiptPath: null,
    createdAt: 1,
    updatedAt: 2,
  );

  test('account payload', () {
    expect(account.toJson(), {
      'id': 'a',
      'name': 'Cash',
      'type': 'cash',
      'icon': 'payments',
      'color': 'emerald',
      'opening_balance': 0,
      'is_archived': false,
      'sort_order': 0,
      'created_at': 1,
      'updated_at': 2,
    });
  });

  test('category payload', () {
    expect(category.toJson(), {
      'id': 'c',
      'name': 'Food',
      'type': 'expense',
      'icon': 'restaurant',
      'color': 'orange',
      'is_archived': true,
      'sort_order': 3,
      'created_at': 1,
      'updated_at': 2,
    });
  });

  test('transaction payload writes nulls explicitly, never omits', () {
    final json = transaction.toJson();
    expect(json, {
      'id': 't',
      'type': 'expense',
      'amount': 45000,
      'account_id': 'a',
      'to_account_id': null,
      'category_id': 'c',
      'date': '2026-09-29',
      'time': '12:30',
      'note': null,
      'recurring_rule_id': null,
      'receipt_path': null,
      'created_at': 1,
      'updated_at': 2,
    });
    for (final key in [
      'to_account_id',
      'note',
      'recurring_rule_id',
      'receipt_path',
    ]) {
      expect(json.containsKey(key), isTrue, reason: key);
    }
  });

  test('file payload with format marker and nested lists', () {
    const file = BackupFileDto(
      schemaVersion: 1,
      appVersion: '1.0.0 (1)',
      exportedAt: '2026-09-29T14:00:00.000Z',
      accounts: [account],
      categories: [category],
      transactions: [transaction],
      settings: {'theme_mode': 'dark'},
    );
    final json = file.toJson();
    expect(json['format'], 'expense_tracker_backup');
    expect(json['schema_version'], 1);
    expect(json['app_version'], '1.0.0 (1)');
    expect(json['exported_at'], '2026-09-29T14:00:00.000Z');
    expect(json['settings'], {'theme_mode': 'dark'});
    expect((json['transactions'] as List).single, transaction.toJson());
    expect(BackupFileDto.fromJson(json), file);
  });
}

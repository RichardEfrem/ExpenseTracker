import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/tables/accounts.dart';
import 'package:expense_tracker/core/database/tables/categories.dart';

/// A template transaction plus a schedule (PRD REC-01). Added in schema v2.
@DataClassName('RecurringRuleRow')
class RecurringRules extends Table {
  TextColumn get id => text()();

  // Template.
  /// `income` | `expense` | `transfer`.
  TextColumn get type => text()();
  // Drift's documented CHECK syntax refers to the column itself.
  // ignore: recursive_getters
  IntColumn get amount => integer().check(amount.isBiggerThanValue(0))();
  TextColumn get accountId => text().references(Accounts, #id)();
  TextColumn get toAccountId => text().nullable().references(Accounts, #id)();
  TextColumn get categoryId => text().nullable().references(Categories, #id)();
  TextColumn get note => text().nullable()();

  // Schedule.
  /// `daily` | `weekly` | `monthly` | `yearly`.
  TextColumn get frequency => text()();

  /// Every [interval] days/weeks/months/years; at least 1.
  IntColumn get interval => integer().withDefault(const Constant(1))();

  /// Monthly: 1–31; days past a month's end fall on its last day.
  IntColumn get dayOfMonth => integer().nullable()();

  /// Local dates, `YYYY-MM-DD`.
  TextColumn get startDate => text()();
  TextColumn get endDate => text().nullable()();

  /// Create transactions directly, or as pending items to confirm.
  BoolColumn get autoCreate => boolean().withDefault(const Constant(true))();

  /// Occurrences up to this date have been generated (idempotency).
  TextColumn get lastGeneratedDate => text().nullable()();

  /// UTC epoch milliseconds.
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

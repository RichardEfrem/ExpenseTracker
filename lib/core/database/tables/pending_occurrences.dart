import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/tables/recurring_rules.dart';

/// A due occurrence of a non-auto rule, waiting for confirm or skip
/// (PRD REC-03). Added in schema v2.
@DataClassName('PendingOccurrenceRow')
class PendingOccurrences extends Table {
  TextColumn get id => text()();
  TextColumn get ruleId =>
      text().references(RecurringRules, #id, onDelete: KeyAction.cascade)();

  /// Local date, `YYYY-MM-DD`.
  TextColumn get date => text()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => [
    {ruleId, date},
  ];
}

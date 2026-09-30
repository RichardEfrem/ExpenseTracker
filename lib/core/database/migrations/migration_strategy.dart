import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/uuid.dart';

/// Schema creation, upgrades and per-connection setup. Every version step
/// gets a migration test (drift_schemas/).
MigrationStrategy buildMigrationStrategy(
  AppDatabase db, {
  required Clock clock,
  required IdGenerator ids,
}) {
  return MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
      await seedDefaults(db, clock: clock, ids: ids);
    },
    onUpgrade: (m, from, to) async {
      // One step per version; each has a migration test.
      if (from < 2) {
        // v2: recurring transactions (Phase 8).
        await m.createTable(db.recurringRules);
        await m.createTable(db.pendingOccurrences);
      }
      if (from < 3) {
        // v3: tags (Phase 12).
        await m.createTable(db.tags);
        await m.createTable(db.transactionTags);
        await m.createIndex(db.idxTransactionTagsTag);
      }
    },
    beforeOpen: (details) async {
      await db.customStatement('PRAGMA foreign_keys = ON');
    },
  );
}

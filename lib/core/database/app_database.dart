import 'package:drift/drift.dart';
import 'package:expense_tracker/core/database/connection.dart';
import 'package:expense_tracker/core/database/migrations/migration_strategy.dart';
import 'package:expense_tracker/core/database/tables/accounts.dart';
import 'package:expense_tracker/core/database/tables/categories.dart';
import 'package:expense_tracker/core/database/tables/pending_occurrences.dart';
import 'package:expense_tracker/core/database/tables/recurring_rules.dart';
import 'package:expense_tracker/core/database/tables/settings.dart';
import 'package:expense_tracker/core/database/tables/tags.dart';
import 'package:expense_tracker/core/database/tables/transactions.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:expense_tracker/core/utils/uuid_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Accounts,
    Categories,
    Transactions,
    Settings,
    RecurringRules,
    PendingOccurrences,
    Tags,
    TransactionTags,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(
    super.executor, {
    this.clock = const SystemClock(),
    this.ids = const UuidGenerator(),
  });

  /// Used when seeding a new database.
  final Clock clock;
  final IdGenerator ids;

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration =>
      buildMigrationStrategy(this, clock: clock, ids: ids);
}

/// The app's one database, open for the whole app lifetime.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase(
    openAppConnection(),
    clock: ref.watch(clockProvider),
    ids: ref.watch(idGeneratorProvider),
  );
  ref.onDispose(db.close);
  return db;
}

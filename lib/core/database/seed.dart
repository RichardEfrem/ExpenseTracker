import 'dart:math';

import 'package:drift/drift.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/uuid.dart';
import 'package:flutter/widgets.dart';

typedef SeedCategory = ({
  String Function(AppLocalizations) name,
  String type,
  String icon,
  PaletteColor color,
});

/// Default categories (PRD CAT-03) with DESIGN §4.3 icons and colors.
final List<SeedCategory> defaultCategories = [
  (
    name: (l) => l.seed_food,
    type: 'expense',
    icon: 'restaurant',
    color: PaletteColor.orange,
  ),
  (
    name: (l) => l.seed_transport,
    type: 'expense',
    icon: 'directions_bus',
    color: PaletteColor.blue,
  ),
  (
    name: (l) => l.seed_groceries,
    type: 'expense',
    icon: 'shopping_basket',
    color: PaletteColor.green,
  ),
  (
    name: (l) => l.seed_bills,
    type: 'expense',
    icon: 'receipt_long',
    color: PaletteColor.purple,
  ),
  (
    name: (l) => l.seed_shopping,
    type: 'expense',
    icon: 'shopping_bag',
    color: PaletteColor.pink,
  ),
  (
    name: (l) => l.seed_health,
    type: 'expense',
    icon: 'favorite',
    color: PaletteColor.teal,
  ),
  (
    name: (l) => l.seed_entertainment,
    type: 'expense',
    icon: 'movie',
    color: PaletteColor.violet,
  ),
  (
    name: (l) => l.seed_education,
    type: 'expense',
    icon: 'school',
    color: PaletteColor.amber,
  ),
  (
    name: (l) => l.seed_housing,
    type: 'expense',
    icon: 'home',
    color: PaletteColor.brown,
  ),
  (
    name: (l) => l.seed_other,
    type: 'expense',
    icon: 'more_horiz',
    color: PaletteColor.neutral,
  ),
  (
    name: (l) => l.seed_salary,
    type: 'income',
    icon: 'work',
    color: PaletteColor.emerald,
  ),
  (
    name: (l) => l.seed_freelance,
    type: 'income',
    icon: 'laptop_mac',
    color: PaletteColor.blue,
  ),
  (
    name: (l) => l.seed_gift,
    type: 'income',
    icon: 'redeem',
    color: PaletteColor.pink,
  ),
  (
    name: (l) => l.seed_other,
    type: 'income',
    icon: 'more_horiz',
    color: PaletteColor.neutral,
  ),
];

/// Settings key set to `true` by the seed, so a fresh install (or erased
/// data) shows onboarding once; `false` after it is finished or skipped.
/// Databases from before onboarding existed have no key and never show it.
const onboardingPendingKey = 'onboarding_pending';

/// Inserts the default categories, the "Cash" account (PRD ACC-02) and the
/// onboarding flag. Runs on first launch and after "erase all data".
Future<void> seedDefaults(
  AppDatabase db, {
  required Clock clock,
  required IdGenerator ids,
  bool categories = true,
}) async {
  final l10n = lookupAppLocalizations(const Locale('en'));
  final now = clock.now().toUtc().millisecondsSinceEpoch;
  await db.batch((batch) {
    if (categories) {
      final order = <String, int>{};
      batch.insertAll(db.categories, [
        for (final c in defaultCategories)
          CategoriesCompanion.insert(
            id: ids.newId(),
            name: c.name(l10n),
            type: c.type,
            icon: c.icon,
            color: c.color.name,
            sortOrder: order.update(c.type, (i) => i + 1, ifAbsent: () => 0),
            createdAt: now,
            updatedAt: now,
          ),
      ]);
    }
    batch.insert(
      db.accounts,
      AccountsCompanion.insert(
        id: ids.newId(),
        name: l10n.seed_cash,
        type: 'cash',
        icon: 'payments',
        color: PaletteColor.emerald.name,
        sortOrder: 0,
        createdAt: now,
        updatedAt: now,
      ),
    );
    batch.insert(
      db.settings,
      SettingsCompanion.insert(key: onboardingPendingKey, value: 'true'),
    );
  });
}

/// Inserts [count] random income/expense transactions dated over the
/// [days] days up to [end], deterministic for a given [seed]. For
/// performance tests, backup round-trips and demo data.
Future<void> seedRandomTransactions(
  AppDatabase db, {
  required int count,
  required LocalDate end,
  int days = 730,
  int seed = 1,
  IdGenerator ids = const UuidGenerator(),
}) async {
  final random = Random(seed);
  final categories = await db.select(db.categories).get();
  final expense = categories.where((c) => c.type == 'expense').toList();
  final income = categories.where((c) => c.type == 'income').toList();
  final accounts = await db.select(db.accounts).get();
  const notes = [null, null, 'Lunch', 'Coffee', 'Groceries run', 'Taxi home'];
  const batchSize = 5000;
  for (var offset = 0; offset < count; offset += batchSize) {
    await db.batch((batch) {
      batch.insertAll(db.transactions, [
        for (var i = offset; i < offset + batchSize && i < count; i++)
          () {
            final isIncome = random.nextInt(10) == 0;
            final category = isIncome
                ? income[random.nextInt(income.length)]
                : expense[random.nextInt(expense.length)];
            final date = end.addDays(-random.nextInt(days));
            final created = date.toDateTime().millisecondsSinceEpoch;
            return TransactionsCompanion.insert(
              id: ids.newId(),
              type: isIncome ? 'income' : 'expense',
              amount: (random.nextInt(isIncome ? 5000 : 500) + 1) * 1000,
              accountId: accounts[random.nextInt(accounts.length)].id,
              categoryId: Value(category.id),
              date: date.toIso(),
              time:
                  '${random.nextInt(24).toString().padLeft(2, '0')}:'
                  '${random.nextInt(60).toString().padLeft(2, '0')}',
              note: Value(notes[random.nextInt(notes.length)]),
              createdAt: created,
              updatedAt: created,
            );
          }(),
      ]);
    });
  }
}

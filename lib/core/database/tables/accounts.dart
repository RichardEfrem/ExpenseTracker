import 'package:drift/drift.dart';

/// Wallets: cash, bank, e-wallet (PRD §6.2).
@DataClassName('AccountRow')
class Accounts extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// `cash` | `bank` | `ewallet` | `other`.
  TextColumn get type => text()();

  /// Icon key (see `CategoryIcons`).
  TextColumn get icon => text()();

  /// [PaletteColor] name.
  TextColumn get color => text()();
  IntColumn get openingBalance => integer().withDefault(const Constant(0))();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer()();

  /// UTC epoch milliseconds.
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

import 'package:drift/drift.dart';

/// Income and expense categories, one level only (PRD §4.2).
@DataClassName('CategoryRow')
class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// `income` | `expense`.
  TextColumn get type => text()();

  /// Icon key (see `CategoryIcons`).
  TextColumn get icon => text()();

  /// [PaletteColor] name.
  TextColumn get color => text()();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
  IntColumn get sortOrder => integer()();

  /// UTC epoch milliseconds.
  IntColumn get createdAt => integer()();
  IntColumn get updatedAt => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

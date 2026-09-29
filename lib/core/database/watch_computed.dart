import 'package:drift/drift.dart';

/// Runs [compute] now and again whenever any of [tables] changes — for
/// results built from several queries (e.g. report statistics).
Stream<T> watchComputed<T>(
  GeneratedDatabase db,
  Iterable<TableInfo<Table, Object?>> tables,
  Future<T> Function() compute,
) async* {
  yield await compute();
  await for (final _ in db.tableUpdates(TableUpdateQuery.onAllTables(tables))) {
    yield await compute();
  }
}

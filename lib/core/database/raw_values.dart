import 'package:drift/drift.dart';

/// Turns a `{column: value}` payload (an Input's `toJson`) into a drift
/// insertable. A present `null` writes NULL; an absent key is left alone.
Insertable<T> rawValues<T>(Map<String, Object?> json) => RawValuesInsertable({
  for (final MapEntry(:key, :value) in json.entries)
    key: Variable<Object>(value),
});

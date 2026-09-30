import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

/// A label across categories, e.g. `trip-bali` (PRD US-15), with how many
/// transactions carry it.
@freezed
abstract class Tag with _$Tag {
  const factory Tag({
    required String id,
    required String name,
    required DateTime createdAt,

    /// Transactions carrying it; 0 where not counted.
    @Default(0) int usage,
  }) = _Tag;

  const Tag._();

  static const maxLength = 32;
  static const maxPerTransaction = 10;

  static final _separators = RegExp(r'[\s,]+');
  static final _dashes = RegExp('-{2,}');

  /// The stored form of a typed tag: lowercase, without a leading `#`,
  /// spaces and commas turned into `-` (so a CSV list stays unambiguous).
  /// Null when nothing is left.
  static String? normalize(String raw) {
    final name = raw
        .trim()
        .replaceFirst(RegExp('^#+'), '')
        .toLowerCase()
        .replaceAll(_separators, '-')
        .replaceAll(_dashes, '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
    return name.isEmpty ? null : name;
  }
}

import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';

/// Income and expense categories are separate sets (PRD CAT-01).
enum CategoryType { expense, income }

@freezed
abstract class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required CategoryType type,

    /// Icon key (see `CategoryIcons`).
    required String icon,
    required PaletteColor color,
    required bool isArchived,
    required int sortOrder,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _Category;
}

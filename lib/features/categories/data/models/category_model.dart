import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';

extension CategoryRowMapper on CategoryRow {
  Category toEntity() => Category(
    id: id,
    name: name,
    type: CategoryType.values.byName(type),
    icon: icon,
    color: PaletteColor.fromName(color),
    isArchived: isArchived,
    sortOrder: sortOrder,
    createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt, isUtc: true),
    updatedAt: DateTime.fromMillisecondsSinceEpoch(updatedAt, isUtc: true),
  );
}

extension CategoryInputJson on CategoryInput {
  /// The write payload, keyed by `categories` column.
  ///
  /// On update, `type` is omitted: a category never changes type, since its
  /// transactions would change direction.
  Map<String, Object?> toJson({bool forUpdate = false}) => {
    'name': name,
    if (!forUpdate) 'type': type.name,
    'icon': icon,
    'color': color.name,
  };
}

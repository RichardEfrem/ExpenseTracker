import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_input.freezed.dart';

/// What the user can set on a category. [type] is fixed after creation.
@freezed
abstract class CategoryInput with _$CategoryInput {
  const factory CategoryInput({
    required String name,
    required CategoryType type,
    required String icon,
    required PaletteColor color,
  }) = _CategoryInput;

  const CategoryInput._();

  static const maxNameLength = 40;

  /// The input with a trimmed name, or why it is invalid.
  Either<ValidationReason, CategoryInput> validated() {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return const Left(ValidationReason.nameEmpty);
    if (trimmed.length > maxNameLength) {
      return const Left(ValidationReason.nameTooLong);
    }
    return Right(copyWith(name: trimmed));
  }
}

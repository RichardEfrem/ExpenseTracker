import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_total.freezed.dart';

/// A category's total and transaction count in a scope.
@Freezed(copyWith: false)
abstract class CategoryTotal with _$CategoryTotal {
  const factory CategoryTotal({
    required Category category,
    required int amount,
    required int count,
  }) = _CategoryTotal;
}

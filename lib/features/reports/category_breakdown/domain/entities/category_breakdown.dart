import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/category_total.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_breakdown.freezed.dart';

/// One donut slice: a category, or "Other (n)" grouping the rest.
@Freezed(copyWith: false)
abstract class DonutSlice with _$DonutSlice {
  const factory DonutSlice({
    /// Null for "Other".
    Category? category,
    required int amount,
    required double share,

    /// Categories behind the slice, for drill-down.
    required Set<String> categoryIds,

    /// How many categories "Other" groups (0 for a single category).
    @Default(0) int otherCount,
  }) = _DonutSlice;

  const DonutSlice._();

  bool get isOther => category == null;
}

/// Where the money went, by category (PRD RPT-01).
@Freezed(copyWith: false)
abstract class CategoryBreakdown with _$CategoryBreakdown {
  const factory CategoryBreakdown({
    required CategoryType type,

    /// Largest first.
    required List<CategoryTotal> totals,
  }) = _CategoryBreakdown;

  const CategoryBreakdown._();

  /// Beyond 6 hues colors stop being distinguishable (DESIGN §4.3).
  static const maxSlices = 6;

  int get total => totals.fold(0, (sum, t) => sum + t.amount);

  double shareOf(int amount) => total == 0 ? 0 : amount / total;

  /// Up to [maxSlices] slices: the top ones, plus "Other (n)" when more
  /// categories exist than fit.
  List<DonutSlice> get donut {
    DonutSlice single(CategoryTotal t) => DonutSlice(
      category: t.category,
      amount: t.amount,
      share: shareOf(t.amount),
      categoryIds: {t.category.id},
    );
    if (totals.length <= maxSlices) return [for (final t in totals) single(t)];
    final top = totals.take(maxSlices - 1).toList();
    final rest = totals.skip(maxSlices - 1).toList();
    final restAmount = rest.fold(0, (sum, t) => sum + t.amount);
    return [
      for (final t in top) single(t),
      DonutSlice(
        amount: restAmount,
        share: shareOf(restAmount),
        categoryIds: {for (final t in rest) t.category.id},
        otherCount: rest.length,
      ),
    ];
  }
}

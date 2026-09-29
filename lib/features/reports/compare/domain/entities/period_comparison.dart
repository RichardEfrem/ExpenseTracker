import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'period_comparison.freezed.dart';

/// One category in both periods (PRD RPT-05).
@Freezed(copyWith: false)
abstract class CategoryChange with _$CategoryChange {
  const factory CategoryChange({
    required Category category,
    required int current,
    required int previous,
  }) = _CategoryChange;

  const CategoryChange._();

  int get delta => current - previous;

  /// Δ as a fraction of the previous total; null when there was none.
  double? get deltaShare => previous == 0 ? null : delta / previous;
}

/// This period against the one before, per category (PRD RPT-05).
@Freezed(copyWith: false)
abstract class PeriodComparison with _$PeriodComparison {
  const factory PeriodComparison({
    required CategoryType type,
    required Period current,
    required Period previous,

    /// Largest |Δ| first.
    required List<CategoryChange> changes,
  }) = _PeriodComparison;

  const PeriodComparison._();

  /// Joins both periods' totals; a category in only one period gets 0 in
  /// the other. Sorted by |Δ| (ties: larger current, then name).
  factory PeriodComparison.of({
    required CategoryType type,
    required Period current,
    required Period previous,
    required List<(Category, int)> currentTotals,
    required List<(Category, int)> previousTotals,
  }) {
    final categories = {
      for (final (category, _) in [...previousTotals, ...currentTotals])
        category.id: category,
    };
    int amountIn(List<(Category, int)> totals, String id) =>
        totals.where((t) => t.$1.id == id).firstOrNull?.$2 ?? 0;
    final changes =
        [
          for (final category in categories.values)
            CategoryChange(
              category: category,
              current: amountIn(currentTotals, category.id),
              previous: amountIn(previousTotals, category.id),
            ),
        ]..sort((a, b) {
          final byDelta = b.delta.abs().compareTo(a.delta.abs());
          if (byDelta != 0) return byDelta;
          final byCurrent = b.current.compareTo(a.current);
          if (byCurrent != 0) return byCurrent;
          return a.category.name.compareTo(b.category.name);
        });
    return PeriodComparison(
      type: type,
      current: current,
      previous: previous,
      changes: changes,
    );
  }

  int get currentTotal => changes.fold(0, (sum, c) => sum + c.current);
  int get previousTotal => changes.fold(0, (sum, c) => sum + c.previous);

  bool get isEmpty => changes.isEmpty;
}

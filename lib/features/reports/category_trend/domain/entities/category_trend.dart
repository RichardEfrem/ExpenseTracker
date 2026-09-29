import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_trend.freezed.dart';

/// One category's total per month.
@Freezed(copyWith: false)
abstract class CategorySeries with _$CategorySeries {
  const factory CategorySeries({
    required Category category,

    /// One per month, oldest first; 0 for months without data.
    required List<int> amounts,
  }) = _CategorySeries;

  const CategorySeries._();

  int get total => amounts.fold(0, (sum, a) => sum + a);
}

/// Category totals over months, one line per category (PRD RPT-04).
@Freezed(copyWith: false)
abstract class CategoryTrend with _$CategoryTrend {
  const factory CategoryTrend({
    required List<Period> months,

    /// Every category with data: expense first, then income; each largest
    /// total first.
    required List<CategorySeries> series,
  }) = _CategoryTrend;

  const CategoryTrend._();

  /// More lines than this stop being readable (DESIGN §8.5).
  static const maxLines = 4;

  /// Lines shown before the user picks.
  static const defaultLines = 3;

  /// [rows] are (month index, category, total).
  factory CategoryTrend.of(
    List<Period> months,
    List<(int, Category, int)> rows,
  ) {
    final categories = <String, Category>{};
    final amounts = <String, List<int>>{};
    for (final (month, category, amount) in rows) {
      categories[category.id] = category;
      amounts.putIfAbsent(
        category.id,
        () => List.filled(months.length, 0),
      )[month] = amount;
    }
    final series =
        [
          for (final MapEntry(:key, :value) in categories.entries)
            CategorySeries(category: value, amounts: amounts[key]!),
        ]..sort((a, b) {
          final byType = a.category.type.index.compareTo(b.category.type.index);
          if (byType != 0) return byType;
          final byTotal = b.total.compareTo(a.total);
          if (byTotal != 0) return byTotal;
          return a.category.name.compareTo(b.category.name);
        });
    return CategoryTrend(months: months, series: series);
  }

  /// The top expense categories, or the top income ones when nothing was
  /// spent.
  Set<String> get defaultSelection {
    final expense = series.where(
      (s) => s.category.type == CategoryType.expense,
    );
    return {
      for (final s in (expense.isEmpty ? series : expense).take(defaultLines))
        s.category.id,
    };
  }

  /// Series for [ids], in [series] order.
  List<CategorySeries> selected(Set<String> ids) => [
    for (final s in series)
      if (ids.contains(s.category.id)) s,
  ];
}

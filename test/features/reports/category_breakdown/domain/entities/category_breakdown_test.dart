import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/category_total.dart';
import 'package:flutter_test/flutter_test.dart';

CategoryTotal total(String id, int amount) => CategoryTotal(
  category: Category(
    id: id,
    name: id,
    type: CategoryType.expense,
    icon: 'restaurant',
    color: PaletteColor.orange,
    isArchived: false,
    sortOrder: 0,
    createdAt: DateTime.utc(2026),
    updatedAt: DateTime.utc(2026),
  ),
  amount: amount,
  count: 1,
);

CategoryBreakdown breakdown(List<int> amounts) => CategoryBreakdown(
  type: CategoryType.expense,
  totals: [for (final (i, a) in amounts.indexed) total('c$i', a)],
);

void main() {
  test('six or fewer categories are all slices', () {
    final slices = breakdown([60, 20, 10, 5, 3, 2]).donut;
    expect(slices, hasLength(6));
    expect(slices.any((s) => s.isOther), isFalse);
    expect(slices.first.share, 0.6);
  });

  test('more than six → top 5 + "Other (n)"', () {
    final b = breakdown([50, 20, 10, 8, 5, 3, 2, 2]);
    final slices = b.donut;
    expect(slices, hasLength(6));
    expect(slices.take(5).map((s) => s.category!.id), [
      'c0',
      'c1',
      'c2',
      'c3',
      'c4',
    ]);
    final other = slices.last;
    expect(other.isOther, isTrue);
    expect(other.otherCount, 3);
    expect(other.amount, 7);
    expect(other.categoryIds, {'c5', 'c6', 'c7'});
    expect(other.share, 0.07);
    expect(slices.fold<int>(0, (s, x) => s + x.amount), b.total);
  });

  test('empty breakdown has no slices and zero shares', () {
    final b = breakdown([]);
    expect(b.donut, isEmpty);
    expect(b.shareOf(10), 0);
  });
}

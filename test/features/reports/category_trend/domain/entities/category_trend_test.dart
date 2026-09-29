import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:flutter_test/flutter_test.dart';

Category category(String name, [CategoryType type = CategoryType.expense]) =>
    Category(
      id: name,
      name: name,
      type: type,
      icon: 'restaurant',
      color: PaletteColor.orange,
      isArchived: false,
      sortOrder: 0,
      createdAt: DateTime.utc(2026),
      updatedAt: DateTime.utc(2026),
    );

void main() {
  final months = [
    Period.monthContaining(LocalDate(2026, 7, 1)),
    Period.monthContaining(LocalDate(2026, 8, 1)),
    Period.monthContaining(LocalDate(2026, 9, 1)),
  ];
  final food = category('Food');
  final transport = category('Transport');
  final shopping = category('Shopping');
  final health = category('Health');
  final salary = category('Salary', CategoryType.income);

  test('one series per category, zeros for months without data', () {
    final trend = CategoryTrend.of(months, [
      (0, food, 100),
      (2, food, 300),
      (1, salary, 5000),
      (1, transport, 50),
    ]);
    expect(
      [
        for (final s in trend.series) [s.category.name, ...s.amounts],
      ],
      [
        ['Food', 100, 0, 300],
        ['Transport', 0, 50, 0],
        ['Salary', 0, 5000, 0],
      ],
      reason: 'expense first, then income; largest total first',
    );
  });

  test('default: top 3 expense categories; picks keep series order', () {
    final trend = CategoryTrend.of(months, [
      (0, food, 400),
      (0, transport, 300),
      (0, shopping, 200),
      (0, health, 100),
      (0, salary, 9000),
    ]);
    expect(trend.defaultSelection, {'Food', 'Transport', 'Shopping'});
    expect(trend.selected({'Health', 'Food'}).map((s) => s.category.name), [
      'Food',
      'Health',
    ]);
  });

  test('default falls back to income when nothing was spent', () {
    final trend = CategoryTrend.of(months, [(1, salary, 9000)]);
    expect(trend.defaultSelection, {'Salary'});
    expect(CategoryTrend.of(months, []).defaultSelection, isEmpty);
  });
}

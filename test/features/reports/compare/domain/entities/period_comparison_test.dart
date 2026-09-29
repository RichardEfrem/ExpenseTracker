import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:flutter_test/flutter_test.dart';

Category category(String name) => Category(
  id: name,
  name: name,
  type: CategoryType.expense,
  icon: 'restaurant',
  color: PaletteColor.orange,
  isArchived: false,
  sortOrder: 0,
  createdAt: DateTime.utc(2026),
  updatedAt: DateTime.utc(2026),
);

void main() {
  final sep = Period.monthContaining(LocalDate(2026, 9, 1));
  final food = category('Food');
  final transport = category('Transport');
  final gift = category('Gift');
  final shopping = category('Shopping');
  final health = category('Health');

  PeriodComparison compare(
    List<(Category, int)> current,
    List<(Category, int)> previous,
  ) => PeriodComparison.of(
    type: CategoryType.expense,
    current: sep,
    previous: sep.previous(),
    currentTotals: current,
    previousTotals: previous,
  );

  List<(String, int, int, int)> rows(PeriodComparison c) => [
    for (final change in c.changes)
      (change.category.name, change.current, change.previous, change.delta),
  ];

  test('categories in only one period get 0 in the other', () {
    final c = compare(
      [(food, 1000000), (gift, 250000)],
      [(food, 800000), (shopping, 400000)],
    );
    expect(rows(c), [
      ('Shopping', 0, 400000, -400000),
      ('Gift', 250000, 0, 250000),
      ('Food', 1000000, 800000, 200000),
    ]);
    final gifts = c.changes.firstWhere((x) => x.category == gift);
    expect(gifts.deltaShare, isNull, reason: 'nothing before: no %');
    final gone = c.changes.firstWhere((x) => x.category == shopping);
    expect(gone.deltaShare, -1.0);
  });

  test('sorted by |Δ|, ties by larger current then name', () {
    final c = compare(
      [(food, 300), (transport, 100), (health, 100)],
      [(food, 200), (transport, 0), (health, 0)],
    );
    expect(rows(c).map((r) => r.$1), ['Food', 'Health', 'Transport']);
    final d = compare(
      [(food, 500), (transport, 100)],
      [(food, 400), (transport, 200)],
    );
    expect(rows(d).map((r) => r.$1), ['Food', 'Transport']);
  });

  test('Δ share and totals', () {
    final c = compare([(food, 1250000)], [(food, 1000000)]);
    expect(c.changes.single.deltaShare, 0.25);
    expect((c.currentTotal, c.previousTotal), (1250000, 1000000));
    expect(compare([], []).isEmpty, isTrue);
  });
}

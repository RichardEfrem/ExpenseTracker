import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/features/transactions/activity/presentation/providers/filter_query_codec.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final full = TransactionFilter(
    text: 'lunch & dinner',
    types: {TransactionType.expense, TransactionType.income},
    categoryIds: {'b', 'a'},
    accountIds: {'cash'},
    tags: {'trip-bali', 'food'},
    from: LocalDate(2026, 9, 1),
    to: LocalDate(2026, 9, 30),
    minAmount: 1000,
    maxAmount: 50000,
  );

  test('round-trips every field through a URL', () {
    final uri = Uri.parse(FilterQueryCodec.location(full));
    expect(uri.path, '/activity');
    expect(FilterQueryCodec.decode(uri.queryParameters), full);
  });

  test('encodes stably (sorted lists)', () {
    expect(FilterQueryCodec.encode(full), {
      'q': 'lunch & dinner',
      'type': 'expense,income',
      'category': 'a,b',
      'account': 'cash',
      'tag': 'food,trip-bali',
      'from': '2026-09-01',
      'to': '2026-09-30',
      'min': '1000',
      'max': '50000',
    });
  });

  test('no filter → bare path', () {
    expect(FilterQueryCodec.location(TransactionFilter.none), '/activity');
    expect(FilterQueryCodec.decode(const {}), TransactionFilter.none);
  });

  test('malformed values are ignored', () {
    expect(
      FilterQueryCodec.decode({
        'type': 'expense,bogus',
        'from': '2026-13-01',
        'min': '-5',
        'max': 'abc',
        'category': ',,',
      }),
      const TransactionFilter(types: {TransactionType.expense}),
    );
  });

  test('isActive', () {
    expect(TransactionFilter.none.isActive, isFalse);
    expect(const TransactionFilter(text: '  ').isActive, isFalse);
    expect(const TransactionFilter(text: 'x').isActive, isTrue);
    expect(const TransactionFilter(minAmount: 1).isActive, isTrue);
  });
}

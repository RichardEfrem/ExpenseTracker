import 'package:expense_tracker/core/pagination/paged_result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('equal when items (deep) and hasMore are equal', () {
    // A fresh, non-const list proves equality is by content, not identity.
    final copy = PagedResult(items: List.of([1, 2]), hasMore: true);
    expect(const PagedResult(items: [1, 2], hasMore: true), copy);
    expect(
      const PagedResult(items: [1, 2], hasMore: true).hashCode,
      copy.hashCode,
    );
  });

  test('differs on items or hasMore', () {
    const base = PagedResult(items: [1, 2], hasMore: true);
    expect(base, isNot(const PagedResult(items: [1], hasMore: true)));
    expect(base, isNot(const PagedResult(items: [1, 2], hasMore: false)));
  });

  test('empty has no items and no more pages', () {
    final empty = PagedResult.empty<String>();
    expect(empty.items, isEmpty);
    expect(empty.hasMore, isFalse);
  });
}

import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('normalize', () {
    final cases = <String, String?>{
      'trip-bali': 'trip-bali',
      'Trip Bali': 'trip-bali',
      '  #Food  ': 'food',
      '##food': 'food',
      'a,b': 'a-b',
      'a , b': 'a-b',
      'a--b': 'a-b',
      '-edge-': 'edge',
      'kopi   susu': 'kopi-susu',
      'Café': 'café',
      '': null,
      '   ': null,
      '#': null,
      '---': null,
    };
    for (final MapEntry(key: raw, value: expected) in cases.entries) {
      test('"$raw" → $expected', () => expect(Tag.normalize(raw), expected));
    }
  });

  test('never contains a comma (the CSV separator)', () {
    expect(Tag.normalize('x, y, z'), isNot(contains(',')));
  });
}

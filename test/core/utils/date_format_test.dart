import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('weekdayShort maps 1…7 to Mon…Sun', () {
    expect(
      [for (var d = 1; d <= 7; d++) AppDateFormat.weekdayShort(d)],
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
    );
  });
}

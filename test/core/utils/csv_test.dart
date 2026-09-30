import 'package:expense_tracker/core/utils/csv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('field (RFC 4180)', () {
    final cases = {
      'plain': 'plain',
      '': '',
      'a,b': '"a,b"',
      'say "hi"': '"say ""hi"""',
      '"': '""""',
      'line\nbreak': '"line\nbreak"',
      'cr\rlf': '"cr\rlf"',
      'ünïcode ✓ 日本': 'ünïcode ✓ 日本',
      '  spaces kept  ': '  spaces kept  ',
    };
    for (final MapEntry(key: input, value: expected) in cases.entries) {
      test('${input.replaceAll('\n', r'\n')} → $expected', () {
        expect(Csv.field(input), expected);
      });
    }
  });

  group('text (formula injection)', () {
    for (final risky in ['=SUM(A1)', '+1', '-2', '@cmd', '\tx', '\rx']) {
      test('prefixes ${risky.codeUnitAt(0)}', () {
        expect(Csv.text(risky), "'$risky");
      });
    }
    test('leaves ordinary text alone', () {
      expect(Csv.text('Lunch = 45k'), 'Lunch = 45k');
      expect(Csv.text(''), '');
    });
  });

  test('encode: BOM, commas, CRLF after every line', () {
    expect(
      Csv.encode([
        ['a', 'b'],
        ['1,5', 'x\ny'],
      ]),
      '\uFEFFa,b\r\n"1,5","x\ny"\r\n',
    );
  });

  test('encode of nothing is just the BOM', () {
    expect(Csv.encode([]), Csv.bom);
  });
}

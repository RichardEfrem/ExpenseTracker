import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:flutter_test/flutter_test.dart';

const m = '−';

void main() {
  test('minus is U+2212, not a hyphen', () {
    expect(MoneyFormat.minus.codeUnits, [0x2212]);
    expect(MoneyFormat.full(-1), isNot(contains('-')));
  });

  group('full', () {
    for (final (input, expected) in [
      (0, 'Rp 0'),
      (999, 'Rp 999'),
      (1000, 'Rp 1.000'),
      (45000, 'Rp 45.000'),
      (1250000, 'Rp 1.250.000'),
      (12500000, 'Rp 12.500.000'),
      (1000000000, 'Rp 1.000.000.000'),
      (-310000, '${m}Rp 310.000'),
    ]) {
      test(
        '$input → $expected',
        () => expect(MoneyFormat.full(input), expected),
      );
    }
  });

  group('ofKind (DESIGN §5)', () {
    for (final (amount, kind, expected) in [
      (45000, AmountKind.expense, '${m}Rp 45.000'),
      (8500000, AmountKind.income, '+Rp 8.500.000'),
      (500000, AmountKind.transfer, 'Rp 500.000'),
      (2150000, AmountKind.net, '+Rp 2.150.000'),
      (-310000, AmountKind.net, '${m}Rp 310.000'),
      (0, AmountKind.net, 'Rp 0'),
      (0, AmountKind.expense, 'Rp 0'),
      (-5, AmountKind.plain, '${m}Rp 5'),
    ]) {
      test('$amount as ${kind.name} → $expected', () {
        expect(MoneyFormat.ofKind(amount, kind), expected);
      });
    }
  });

  group('compact', () {
    for (final (input, expected) in [
      (0, 'Rp 0'),
      (999, 'Rp 999'),
      (1000, 'Rp 1K'),
      (1049, 'Rp 1K'),
      (1050, 'Rp 1,1K'),
      (12500, 'Rp 12,5K'),
      (212000, 'Rp 212K'),
      (250000, 'Rp 250K'),
      (999949, 'Rp 999,9K'),
      (999950, 'Rp 1M'),
      (1000000, 'Rp 1M'),
      (6400000, 'Rp 6,4M'),
      (12500000, 'Rp 12,5M'),
      (12450000, 'Rp 12,5M'),
      (999950000, 'Rp 1B'),
      (1234000000, 'Rp 1,2B'),
      (12345000000000, 'Rp 12.345B'),
      (-12500000, '${m}Rp 12,5M'),
    ]) {
      test(
        '$input → $expected',
        () => expect(MoneyFormat.compact(input), expected),
      );
    }

    test('compactOfKind signs per kind', () {
      expect(
        MoneyFormat.compactOfKind(250000, AmountKind.expense),
        '${m}Rp 250K',
      );
      expect(MoneyFormat.compactOfKind(250000, AmountKind.income), '+Rp 250K');
      expect(MoneyFormat.compactOfKind(-128000, AmountKind.net), '${m}Rp 128K');
    });
  });

  group('change', () {
    for (final (current, previous, expected) in [
      (1124, 1000, '▲ 12,4%'),
      (979, 1000, '▼ 2,1%'),
      (1000, 1000, '0,0%'),
      (2000, 1000, '▲ 100,0%'),
      (5000, 0, null),
      (-50, -100, '▲ 50,0%'),
      (123450, 10, '▲ 1.234.400,0%'),
    ]) {
      test('$previous → $current = $expected', () {
        expect(MoneyFormat.change(current, previous), expected);
      });
    }
  });

  test('percent', () {
    expect(MoneyFormat.percent(0.253), '25,3%');
    expect(MoneyFormat.percent(0.42, decimals: 0), '42%');
    expect(MoneyFormat.percent(0), '0,0%');
    expect(MoneyFormat.percent(-0.12), '${m}12,0%');
  });

  group('spokenParts', () {
    test('45.000', () {
      expect(MoneyFormat.spokenParts(45000), [(45, MoneyScale.thousand)]);
    });
    test('1.250.000', () {
      expect(MoneyFormat.spokenParts(1250000), [
        (1, MoneyScale.million),
        (250, MoneyScale.thousand),
      ]);
    });
    test('37.500 and sign ignored', () {
      expect(MoneyFormat.spokenParts(-37500), [
        (37, MoneyScale.thousand),
        (500, null),
      ]);
    });
    test('zero', () => expect(MoneyFormat.spokenParts(0), [(0, null)]));
    test('2.000.000.007', () {
      expect(MoneyFormat.spokenParts(2000000007), [
        (2, MoneyScale.billion),
        (7, null),
      ]);
    });
  });
}

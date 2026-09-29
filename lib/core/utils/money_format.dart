/// How an amount is signed and colored (DESIGN §5).
enum AmountKind {
  /// No forced sign; negative values show `−`. Default text color.
  plain,

  /// Money out: always `−`, default text color.
  expense,

  /// Money in: always `+`, income green.
  income,

  /// Between own accounts: no sign, transfer gray.
  transfer,

  /// Can be either: sign from the value, green if ≥ 0, red if < 0.
  net,
}

/// A number word scale used to read amounts aloud.
enum MoneyScale { billion, million, thousand }

/// The only place amounts become text (IDR, no minor unit).
abstract final class MoneyFormat {
  /// True minus (U+2212), as wide as `+` in tabular figures.
  static const minus = '−';
  static const symbol = 'Rp';

  /// `1250000` → `1.250.000` (absolute value).
  static String group(int value) {
    final digits = value.abs().toString();
    final out = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) out.write('.');
      out.write(digits[i]);
    }
    return out.toString();
  }

  /// `Rp 1.250.000`; negative values get `−`.
  static String full(int amount) =>
      '${amount < 0 ? minus : ''}$symbol ${group(amount)}';

  /// `+Rp 2.150.000` / `−Rp 310.000` / `Rp 0`.
  static String signed(int amount) =>
      '${_sign(amount)}$symbol ${group(amount)}';

  /// Full amount signed per [kind]. Expense/income amounts are magnitudes.
  static String ofKind(int amount, AmountKind kind) => switch (kind) {
    AmountKind.plain => full(amount),
    AmountKind.expense => '${amount == 0 ? '' : minus}$symbol ${group(amount)}',
    AmountKind.income => '${amount == 0 ? '' : '+'}$symbol ${group(amount)}',
    AmountKind.transfer => '$symbol ${group(amount)}',
    AmountKind.net => signed(amount),
  };

  /// Compact per [kind]: `Rp 250K`, `−Rp 12,5M`.
  static String compactOfKind(int amount, AmountKind kind) {
    final sign = switch (kind) {
      AmountKind.plain => amount < 0 ? minus : '',
      AmountKind.expense => amount == 0 ? '' : minus,
      AmountKind.income => amount == 0 ? '' : '+',
      AmountKind.transfer => '',
      AmountKind.net => _sign(amount),
    };
    return '$sign$symbol ${compactNumber(amount.abs())}';
  }

  /// `Rp 250K`, `Rp 12,5M`, `Rp 999`; negative values get `−`.
  static String compact(int amount) =>
      '${amount < 0 ? minus : ''}$symbol ${compactNumber(amount.abs())}';

  /// Compact number without currency: `250K`, `12,5M`, `1,2B`.
  /// One decimal max, `,` decimal separator, half-up rounding.
  static String compactNumber(int value) {
    final sign = value < 0 ? minus : '';
    final a = value.abs();
    if (a < 1000) return '$sign$a';
    const units = [(1000, 'K'), (1000000, 'M'), (1000000000, 'B')];
    for (var i = 0; i < units.length; i++) {
      final (unit, suffix) = units[i];
      final tenths = (a * 10 + unit ~/ 2) ~/ unit;
      final isLast = i == units.length - 1;
      if (tenths >= 10000 && !isLast) continue;
      return '$sign${_decimal(tenths)}$suffix';
    }
    throw StateError('unreachable');
  }

  /// Compact number with its sign, no currency: `+300K`, `−128K`, `0`.
  /// For dense cells (compare table, calendar).
  static String compactSigned(int value) =>
      '${value > 0 ? '+' : ''}${compactNumber(value)}';

  /// `▲ 12,4%` / `▼ 2,1%` / `0,0%`; null when [previous] is zero (no base).
  static String? change(int current, int previous) {
    if (previous == 0) return null;
    final tenths = ((current - previous) * 1000 / previous.abs()).round();
    final arrow = tenths > 0
        ? '▲ '
        : tenths < 0
        ? '▼ '
        : '';
    return '$arrow${_decimal(tenths.abs(), keepZero: true)}%';
  }

  /// `0.253` → `25,3%`; with [decimals] 0 → `25%`. Negative gets `−`.
  static String percent(double fraction, {int decimals = 1}) {
    final sign = fraction < 0 ? minus : '';
    if (decimals == 0) return '$sign${(fraction.abs() * 100).round()}%';
    return '$sign${_decimal((fraction.abs() * 1000).round(), keepZero: true)}%';
  }

  /// Splits |[amount]| into scale chunks for reading aloud:
  /// 1250000 → `[(1, million), (250, thousand)]`, 37500 → `[(37, thousand),
  /// (500, null)]`, 0 → `[(0, null)]`.
  static List<(int, MoneyScale?)> spokenParts(int amount) {
    var rest = amount.abs();
    if (rest == 0) return const [(0, null)];
    final parts = <(int, MoneyScale?)>[];
    for (final (size, scale) in const [
      (1000000000, MoneyScale.billion),
      (1000000, MoneyScale.million),
      (1000, MoneyScale.thousand),
    ]) {
      if (rest >= size) {
        parts.add((rest ~/ size, scale));
        rest %= size;
      }
    }
    if (rest > 0) parts.add((rest, null));
    return parts;
  }

  static String _sign(int amount) => amount > 0
      ? '+'
      : amount < 0
      ? minus
      : '';

  /// Tenths → `12,5`; drops `,0` unless [keepZero].
  static String _decimal(int tenths, {bool keepZero = false}) {
    final whole = group(tenths ~/ 10);
    final frac = tenths % 10;
    return frac == 0 && !keepZero ? whole : '$whole,$frac';
  }
}

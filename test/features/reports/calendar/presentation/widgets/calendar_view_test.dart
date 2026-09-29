import 'dart:math' as math;

import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/calendar/presentation/widgets/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

double contrast(Color a, Color b) {
  final (la, lb) = (a.computeLuminance(), b.computeLuminance());
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  final l10n = lookupAppLocalizations(const Locale('en'));

  test('day labels read the net aloud (DESIGN §9)', () {
    expect(
      calendarDayLabel(l10n, LocalDate(2026, 9, 28), -128000),
      '28 September, net minus 128 thousand rupiah',
    );
    expect(
      calendarDayLabel(l10n, LocalDate(2026, 9, 1), 8500000),
      '1 September, net plus 8 million 500 thousand rupiah',
    );
    expect(
      calendarDayLabel(l10n, LocalDate(2026, 9, 2), null),
      '2 September, nothing recorded',
    );
  });

  for (final (name, theme) in [
    ('light', AppTheme.light),
    ('dark', AppTheme.dark),
  ]) {
    testWidgets('every $name tint keeps its text at 4.5:1 or more', (
      tester,
    ) async {
      late BuildContext context;
      await tester.pumpWidget(
        MaterialApp(
          theme: theme,
          home: Builder(
            builder: (c) {
              context = c;
              return const SizedBox();
            },
          ),
        ),
      );
      for (var step = -5; step <= 5; step++) {
        final background = calendarTint(context, step);
        expect(
          contrast(onTint(background), background),
          greaterThanOrEqualTo(4.5),
          reason: 'step $step',
        );
      }
      // Stronger steps are visibly different from weaker ones.
      expect(calendarTint(context, 5), isNot(calendarTint(context, 1)));
    });
  }
}

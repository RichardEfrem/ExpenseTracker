import 'dart:math' as math;

import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// WCAG 2.x contrast ratio.
double contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

void main() {
  for (final palette in [AppPalette.light, AppPalette.dark]) {
    final theme = palette.brightness.name;
    final surfaces = {
      'surface': palette.surface,
      'background': palette.background,
      'surfaceContainer': palette.surfaceContainer,
    };

    group('$theme text ≥ 4.5:1', () {
      final texts = {
        'onSurface': palette.onSurface,
        'onSurfaceVariant': palette.onSurfaceVariant,
        'primary': palette.primary,
        'income': palette.income,
        'expense': palette.expense,
        'transfer': palette.transfer,
        'warning': palette.warning,
      };
      for (final MapEntry(key: textName, value: text) in texts.entries) {
        for (final MapEntry(key: surfaceName, value: surface)
            in surfaces.entries) {
          test('$textName on $surfaceName', () {
            expect(contrast(text, surface), greaterThanOrEqualTo(4.5));
          });
        }
      }

      final pairs = {
        'onPrimary on primary': (palette.onPrimary, palette.primary),
        'onPrimaryContainer on primaryContainer': (
          palette.onPrimaryContainer,
          palette.primaryContainer,
        ),
        'onExpense on expense': (palette.onExpense, palette.expense),
        'onExpenseContainer on expenseContainer': (
          palette.onExpenseContainer,
          palette.expenseContainer,
        ),
        'warning on warningContainer': (
          palette.warning,
          palette.warningContainer,
        ),
        'onInverseSurface on inverseSurface (snackbar)': (
          palette.onInverseSurface,
          palette.inverseSurface,
        ),
        'inversePrimary on inverseSurface (snackbar action)': (
          palette.inversePrimary,
          palette.inverseSurface,
        ),
      };
      for (final MapEntry(key: name, value: (fg, bg)) in pairs.entries) {
        test(name, () => expect(contrast(fg, bg), greaterThanOrEqualTo(4.5)));
      }
    });

    group('$theme category colors ≥ 3:1', () {
      final categories = FinanceColors.from(palette).palette;
      for (final MapEntry(key: name, value: color) in categories.entries) {
        test('${name.name} vs surface', () {
          expect(contrast(color, palette.surface), greaterThanOrEqualTo(3));
        });
        test('${name.name} glyph on its circle', () {
          final dark = palette.brightness == Brightness.dark;
          final circle = dark
              ? Color.alphaBlend(color.withValues(alpha: 0.24), palette.surface)
              : color;
          final glyph = dark ? color : palette.categoryGlyph;
          expect(contrast(glyph, circle), greaterThanOrEqualTo(3));
        });
      }
    });
  }

  test('contrast() matches known WCAG values', () {
    expect(contrast(Colors.black, Colors.white), closeTo(21, 0.01));
    expect(
      contrast(const Color(0xFF14171C), const Color(0xFFFFFFFF)),
      closeTo(17.9, 0.1),
    );
  });
}

import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Semantic colors Material has no slot for (DESIGN §10). Money direction and
/// category colors never follow dynamic color, so their meaning is stable.
@immutable
class FinanceColors extends ThemeExtension<FinanceColors> {
  const FinanceColors({
    required this.income,
    required this.expense,
    required this.transfer,
    required this.warning,
    required this.warningContainer,
    required this.categoryGlyph,
    required this.palette,
  });

  factory FinanceColors.from(AppPalette p) => FinanceColors(
    income: p.income,
    expense: p.expense,
    transfer: p.transfer,
    warning: p.warning,
    warningContainer: p.warningContainer,
    categoryGlyph: p.categoryGlyph,
    palette: p.brightness == Brightness.light ? lightCategory : darkCategory,
  );

  final Color income;
  final Color expense;
  final Color transfer;
  final Color warning;
  final Color warningContainer;
  final Color categoryGlyph;
  final Map<PaletteColor, Color> palette;

  Color category(PaletteColor color) => palette[color]!;

  static FinanceColors of(BuildContext context) =>
      Theme.of(context).extension<FinanceColors>()!;

  /// DESIGN §4.3, light theme.
  static const lightCategory = {
    PaletteColor.orange: Color(0xFFE8590C),
    PaletteColor.blue: Color(0xFF1971C2),
    PaletteColor.green: Color(0xFF2B8A3E),
    PaletteColor.purple: Color(0xFF9C36B5),
    PaletteColor.pink: Color(0xFFC2255C),
    PaletteColor.teal: Color(0xFF0C8599),
    PaletteColor.violet: Color(0xFF6741D9),
    PaletteColor.amber: Color(0xFFB07A00),
    PaletteColor.brown: Color(0xFF8C5A2B),
    PaletteColor.emerald: Color(0xFF0B7552),
    PaletteColor.neutral: Color(0xFF697180),
  };

  /// DESIGN §4.3, dark theme.
  static const darkCategory = {
    PaletteColor.orange: Color(0xFFFF9A5C),
    PaletteColor.blue: Color(0xFF74B3F0),
    PaletteColor.green: Color(0xFF69C97D),
    PaletteColor.purple: Color(0xFFD08BE6),
    PaletteColor.pink: Color(0xFFF57FA8),
    PaletteColor.teal: Color(0xFF4FC6D6),
    PaletteColor.violet: Color(0xFFA48BF5),
    PaletteColor.amber: Color(0xFFE6B84A),
    PaletteColor.brown: Color(0xFFD1A073),
    PaletteColor.emerald: Color(0xFF4CC99A),
    PaletteColor.neutral: Color(0xFF9AA1AD),
  };

  @override
  FinanceColors copyWith({
    Color? income,
    Color? expense,
    Color? transfer,
    Color? warning,
    Color? warningContainer,
    Color? categoryGlyph,
    Map<PaletteColor, Color>? palette,
  }) => FinanceColors(
    income: income ?? this.income,
    expense: expense ?? this.expense,
    transfer: transfer ?? this.transfer,
    warning: warning ?? this.warning,
    warningContainer: warningContainer ?? this.warningContainer,
    categoryGlyph: categoryGlyph ?? this.categoryGlyph,
    palette: palette ?? this.palette,
  );

  @override
  FinanceColors lerp(FinanceColors? other, double t) {
    if (other == null) return this;
    return FinanceColors(
      income: Color.lerp(income, other.income, t)!,
      expense: Color.lerp(expense, other.expense, t)!,
      transfer: Color.lerp(transfer, other.transfer, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      warningContainer: Color.lerp(
        warningContainer,
        other.warningContainer,
        t,
      )!,
      categoryGlyph: Color.lerp(categoryGlyph, other.categoryGlyph, t)!,
      palette: {
        for (final c in PaletteColor.values)
          c: Color.lerp(palette[c], other.palette[c], t)!,
      },
    );
  }
}

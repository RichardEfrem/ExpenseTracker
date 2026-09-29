import 'package:flutter/material.dart';

/// Raw color tokens for one theme (DESIGN §4.1–4.2).
class AppPalette {
  const AppPalette({
    required this.brightness,
    required this.background,
    required this.surface,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.outline,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.primary,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.income,
    required this.expense,
    required this.onExpense,
    required this.expenseContainer,
    required this.onExpenseContainer,
    required this.transfer,
    required this.warning,
    required this.warningContainer,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.inversePrimary,
    required this.categoryGlyph,
  });

  final Brightness brightness;
  final Color background;
  final Color surface;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color outline;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color primary;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color income;
  final Color expense;
  final Color onExpense;
  final Color expenseContainer;
  final Color onExpenseContainer;
  final Color transfer;
  final Color warning;
  final Color warningContainer;
  final Color inverseSurface;
  final Color onInverseSurface;
  final Color inversePrimary;

  /// Glyph color on a light-theme category circle (dark theme uses the
  /// category color itself on a tint).
  final Color categoryGlyph;

  static const light = AppPalette(
    brightness: Brightness.light,
    background: Color(0xFFF6F7F9),
    surface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFEEF0F4),
    surfaceContainerHigh: Color(0xFFE7EAEF),
    surfaceContainerHighest: Color(0xFFE1E4EA),
    outline: Color(0xFFDDE1E7),
    onSurface: Color(0xFF14171C),
    onSurfaceVariant: Color(0xFF5C6370),
    primary: Color(0xFF4353D6),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFE0E3FA),
    onPrimaryContainer: Color(0xFF1B2687),
    income: Color(0xFF0B7552),
    expense: Color(0xFFC8372D),
    onExpense: Color(0xFFFFFFFF),
    expenseContainer: Color(0xFFFBE3E1),
    onExpenseContainer: Color(0xFF7A1D16),
    transfer: Color(0xFF5C6370),
    warning: Color(0xFF9A5B00),
    warningContainer: Color(0xFFFFF1D6),
    inverseSurface: Color(0xFF2A2E35),
    onInverseSurface: Color(0xFFECEEF2),
    inversePrimary: Color(0xFFA9B4FF),
    categoryGlyph: Color(0xFFFFFFFF),
  );

  static const dark = AppPalette(
    brightness: Brightness.dark,
    background: Color(0xFF0F1115),
    surface: Color(0xFF181B21),
    surfaceContainer: Color(0xFF20242C),
    surfaceContainerHigh: Color(0xFF262B34),
    surfaceContainerHighest: Color(0xFF2C313B),
    outline: Color(0xFF2C313B),
    onSurface: Color(0xFFECEEF2),
    onSurfaceVariant: Color(0xFFA0A6B1),
    primary: Color(0xFFA9B4FF),
    onPrimary: Color(0xFF101A5C),
    primaryContainer: Color(0xFF2A3480),
    onPrimaryContainer: Color(0xFFE0E3FA),
    income: Color(0xFF4CC99A),
    expense: Color(0xFFFF8A7E),
    onExpense: Color(0xFF3B0906),
    expenseContainer: Color(0xFF5C1A14),
    onExpenseContainer: Color(0xFFFFDAD5),
    transfer: Color(0xFFA0A6B1),
    warning: Color(0xFFF2B84B),
    warningContainer: Color(0xFF3A2A08),
    inverseSurface: Color(0xFFECEEF2),
    onInverseSurface: Color(0xFF181B21),
    inversePrimary: Color(0xFF4353D6),
    categoryGlyph: Color(0xFF0F1115),
  );
}

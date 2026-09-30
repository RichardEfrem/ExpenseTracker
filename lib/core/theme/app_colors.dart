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
    background: Color(0xFFF4F7F8),
    surface: Color(0xFFFFFFFF),
    surfaceContainer: Color(0xFFEBF1F3),
    surfaceContainerHigh: Color(0xFFE3EBEE),
    surfaceContainerHighest: Color(0xFFDBE4E8),
    outline: Color(0xFFD9E2E6),
    onSurface: Color(0xFF121A1E),
    onSurfaceVariant: Color(0xFF56646B),
    primary: Color(0xFF00718A),
    onPrimary: Color(0xFFFFFFFF),
    primaryContainer: Color(0xFFCDEEF5),
    onPrimaryContainer: Color(0xFF003642),
    income: Color(0xFF067550),
    expense: Color(0xFFC8372D),
    onExpense: Color(0xFFFFFFFF),
    expenseContainer: Color(0xFFFBE3E1),
    onExpenseContainer: Color(0xFF7A1D16),
    transfer: Color(0xFF56646B),
    warning: Color(0xFF965800),
    warningContainer: Color(0xFFFFF0D2),
    inverseSurface: Color(0xFF263035),
    onInverseSurface: Color(0xFFEAF0F2),
    inversePrimary: Color(0xFF7FD3E6),
    categoryGlyph: Color(0xFFFFFFFF),
  );

  static const dark = AppPalette(
    brightness: Brightness.dark,
    background: Color(0xFF0D1316),
    surface: Color(0xFF151D21),
    surfaceContainer: Color(0xFF1D272C),
    surfaceContainerHigh: Color(0xFF243036),
    surfaceContainerHighest: Color(0xFF2B383F),
    outline: Color(0xFF2E3B42),
    onSurface: Color(0xFFE8EFF1),
    onSurfaceVariant: Color(0xFF9FAEB5),
    primary: Color(0xFF6FD0E6),
    onPrimary: Color(0xFF00333F),
    primaryContainer: Color(0xFF004E60),
    onPrimaryContainer: Color(0xFFCDEEF5),
    income: Color(0xFF4CC99A),
    expense: Color(0xFFFF8A7E),
    onExpense: Color(0xFF3B0906),
    expenseContainer: Color(0xFF5C1A14),
    onExpenseContainer: Color(0xFFFFDAD5),
    transfer: Color(0xFF9FAEB5),
    warning: Color(0xFFF2B84B),
    warningContainer: Color(0xFF3A2A08),
    inverseSurface: Color(0xFFE8EFF1),
    onInverseSurface: Color(0xFF151D21),
    inversePrimary: Color(0xFF00718A),
    categoryGlyph: Color(0xFF0D1316),
  );
}

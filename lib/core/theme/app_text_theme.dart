import 'package:flutter/material.dart';

/// Inter text theme (DESIGN §4.4).
abstract final class AppTextTheme {
  static const fontFamily = 'Inter';

  static TextTheme build(Color onSurface) {
    TextStyle style(double size, double lineHeight, FontWeight weight) =>
        TextStyle(
          fontFamily: fontFamily,
          fontSize: size,
          height: lineHeight / size,
          letterSpacing: 0,
        ).withWeight(weight);

    return TextTheme(
      displayLarge: style(57, 64, FontWeight.w400),
      displayMedium: style(45, 52, FontWeight.w400),
      displaySmall: style(36, 44, FontWeight.w600),
      headlineLarge: style(32, 40, FontWeight.w600),
      headlineMedium: style(28, 36, FontWeight.w600),
      headlineSmall: style(24, 32, FontWeight.w600),
      titleLarge: style(22, 28, FontWeight.w600),
      titleMedium: style(16, 24, FontWeight.w600),
      titleSmall: style(14, 20, FontWeight.w600),
      bodyLarge: style(16, 24, FontWeight.w400),
      bodyMedium: style(14, 20, FontWeight.w400),
      bodySmall: style(12, 16, FontWeight.w400),
      labelLarge: style(14, 20, FontWeight.w500),
      labelMedium: style(12, 16, FontWeight.w500),
      labelSmall: style(11, 16, FontWeight.w500),
    ).apply(bodyColor: onSurface, displayColor: onSurface);
  }
}

extension AppTextStyle on TextStyle {
  /// Sets the weight on both [fontWeight] and the variable font's `wght`
  /// axis. Inter is a variable font, which ignores [fontWeight] alone.
  TextStyle withWeight(FontWeight weight) => copyWith(
    fontWeight: weight,
    fontVariations: [FontVariation.weight(weight.value.toDouble())],
  );

  /// Tabular figures, so columns of amounts line up (DESIGN §4.4).
  TextStyle get tabular =>
      copyWith(fontFeatures: const [FontFeature.tabularFigures()]);
}

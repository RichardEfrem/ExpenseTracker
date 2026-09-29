import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/theme/motion.dart';
import 'package:flutter/material.dart';

/// Light and dark [ThemeData] built from the DESIGN §4 tokens.
abstract final class AppTheme {
  static ThemeData get light => build(AppPalette.light);
  static ThemeData get dark => build(AppPalette.dark);

  static ThemeData build(AppPalette p) {
    final scheme = ColorScheme(
      brightness: p.brightness,
      primary: p.primary,
      onPrimary: p.onPrimary,
      primaryContainer: p.primaryContainer,
      onPrimaryContainer: p.onPrimaryContainer,
      secondary: p.onSurfaceVariant,
      onSecondary: p.surface,
      secondaryContainer: p.primaryContainer,
      onSecondaryContainer: p.onPrimaryContainer,
      tertiary: p.income,
      onTertiary: p.surface,
      error: p.expense,
      onError: p.onExpense,
      errorContainer: p.expenseContainer,
      onErrorContainer: p.onExpenseContainer,
      surface: p.surface,
      onSurface: p.onSurface,
      onSurfaceVariant: p.onSurfaceVariant,
      surfaceDim: p.background,
      surfaceBright: p.surface,
      surfaceContainerLowest: p.surface,
      surfaceContainerLow: p.background,
      surfaceContainer: p.surfaceContainer,
      surfaceContainerHigh: p.surfaceContainerHigh,
      surfaceContainerHighest: p.surfaceContainerHighest,
      outline: p.outline,
      outlineVariant: p.outline,
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: p.inverseSurface,
      onInverseSurface: p.onInverseSurface,
      inversePrimary: p.inversePrimary,
      surfaceTint: Colors.transparent,
    );
    final text = AppTextTheme.build(p.onSurface);
    const small = BorderRadius.all(Radius.circular(Dimens.radiusSmall));
    const medium = BorderRadius.all(Radius.circular(Dimens.radiusMedium));
    const largeTop = BorderRadius.vertical(
      top: Radius.circular(Dimens.radiusLarge),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: p.brightness,
      fontFamily: AppTextTheme.fontFamily,
      textTheme: text,
      scaffoldBackgroundColor: p.background,
      canvasColor: p.background,
      dividerColor: p.outline,
      extensions: [FinanceColors.from(p)],
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: VerticalSharedAxisTransitionsBuilder(),
        },
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleTextStyle: text.titleLarge,
        centerTitle: false,
      ),
      cardTheme: CardThemeData(
        color: p.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: medium,
          side: BorderSide(color: p.outline, width: Dimens.outlineWidth),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      dividerTheme: DividerThemeData(
        color: p.outline,
        thickness: Dimens.outlineWidth,
        space: Dimens.outlineWidth,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.primary,
        foregroundColor: p.onPrimary,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusFab)),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: p.surface,
        modalBackgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 6,
        modalElevation: 6,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(borderRadius: largeTop),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(Dimens.radiusLarge)),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: p.surfaceContainer,
        selectedColor: p.primaryContainer,
        side: BorderSide.none,
        shape: const RoundedRectangleBorder(borderRadius: small),
        labelStyle: text.labelLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surfaceContainer,
        border: const OutlineInputBorder(
          borderRadius: medium,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: medium,
          borderSide: BorderSide(color: p.primary, width: 2),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: p.primaryContainer,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? text.labelMedium!
                    .withWeight(FontWeight.w600)
                    .copyWith(color: p.onSurface)
              : text.labelMedium!.copyWith(color: p.onSurfaceVariant),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: small),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: p.onSurfaceVariant,
        minVerticalPadding: Dimens.space2,
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(textStyle: WidgetStatePropertyAll(text.labelLarge)),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, Dimens.minTouchTarget),
          textStyle: text.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, Dimens.minTouchTarget),
          textStyle: text.labelLarge,
          side: BorderSide(color: p.onSurfaceVariant),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(48, Dimens.minTouchTarget),
          textStyle: text.labelLarge,
        ),
      ),
    );
  }
}

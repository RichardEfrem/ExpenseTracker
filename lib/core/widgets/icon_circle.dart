import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:flutter/material.dart';

/// Category/account icon: 20 dp glyph on a 36 dp circle; solid color with a
/// white glyph in light theme, 24% tint with a colored glyph in dark
/// (DESIGN §4.3).
class IconCircle extends StatelessWidget {
  const IconCircle({
    required this.icon,
    required this.color,
    this.size = Dimens.iconCircle,
    this.semanticLabel,
    super.key,
  });

  final IconData icon;
  final Color color;
  final double size;

  /// What the icon means, e.g. the category name.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final glyph = dark ? color : FinanceColors.of(context).categoryGlyph;
    return Semantics(
      label: semanticLabel,
      excludeSemantics: true,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: dark ? color.withValues(alpha: 0.24) : color,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: size * Dimens.iconGlyph / Dimens.iconCircle,
          color: glyph,
        ),
      ),
    );
  }
}

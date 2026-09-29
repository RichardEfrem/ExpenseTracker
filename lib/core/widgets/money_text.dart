import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/count_up_text.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:flutter/material.dart';

/// The one widget that renders amounts: tabular figures, sign and color per
/// [kind], and a spoken screen-reader label (DESIGN §5, §10).
class MoneyText extends StatelessWidget {
  const MoneyText(
    this.amount, {
    this.kind = AmountKind.plain,
    this.style,
    this.color,
    this.compact = false,
    this.hero = false,
    this.countUp = false,
    this.textAlign,
    this.alignment = AlignmentDirectional.centerStart,
    super.key,
  });

  final int amount;
  final AmountKind kind;

  /// Defaults to `bodyLarge` 600 (row amount), or `displaySmall` for [hero].
  final TextStyle? style;

  /// Overrides the [kind] color.
  final Color? color;

  /// `Rp 12,5M` instead of `Rp 12.500.000`.
  final bool compact;

  /// Hero amount: shrinks to fit instead of wrapping.
  final bool hero;

  /// Counts up from the previous value when [amount] changes.
  final bool countUp;
  final TextAlign? textAlign;

  /// Where a [hero] amount sits when it is narrower than its box.
  final AlignmentGeometry alignment;

  /// The color [kind] gives [amount] in the current theme; null means the
  /// default text color.
  static Color? colorOf(BuildContext context, int amount, AmountKind kind) {
    final finance = FinanceColors.of(context);
    return switch (kind) {
      AmountKind.income => finance.income,
      AmountKind.transfer => finance.transfer,
      AmountKind.net => amount >= 0 ? finance.income : finance.expense,
      AmountKind.plain || AmountKind.expense => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final base =
        style ??
        (hero
            ? textTheme.displaySmall!
            : textTheme.bodyLarge!.withWeight(FontWeight.w600));
    final effective = base
        .copyWith(color: color ?? colorOf(context, amount, kind))
        .tabular;

    Widget text(BuildContext context, int value) => Text(
      compact
          ? MoneyFormat.compactOfKind(value, kind)
          : MoneyFormat.ofKind(value, kind),
      style: effective,
      maxLines: 1,
      softWrap: false,
      textAlign: textAlign,
    );

    Widget child = countUp
        ? CountUpText(value: amount, builder: text)
        : text(context, amount);
    if (hero) {
      child = FittedBox(
        fit: BoxFit.scaleDown,
        alignment: alignment,
        child: child,
      );
    }
    return Semantics(
      label: moneySemantics(AppLocalizations.of(context), amount, kind),
      excludeSemantics: true,
      child: child,
    );
  }
}

import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/money_format.dart';

/// Screen-reader text for an amount: "minus 45 thousand rupiah", never
/// "dash R p 45 dot 000" (DESIGN §9).
String moneySemantics(
  AppLocalizations l10n,
  int amount, [
  AmountKind kind = AmountKind.plain,
]) {
  final words = MoneyFormat.spokenParts(amount)
      .map(
        (part) => switch (part) {
          (final n, MoneyScale.billion) => l10n.money_scale_billion('$n'),
          (final n, MoneyScale.million) => l10n.money_scale_million('$n'),
          (final n, MoneyScale.thousand) => l10n.money_scale_thousand('$n'),
          (final n, null) => '$n',
        },
      )
      .join(' ');
  final negative = switch (kind) {
    AmountKind.expense => amount != 0,
    AmountKind.plain || AmountKind.net => amount < 0,
    AmountKind.income || AmountKind.transfer => false,
  };
  final positive = switch (kind) {
    AmountKind.income => amount != 0,
    AmountKind.net => amount > 0,
    _ => false,
  };
  if (negative) return l10n.money_spoken_negative(words);
  if (positive) return l10n.money_spoken_positive(words);
  return l10n.money_spoken(words);
}

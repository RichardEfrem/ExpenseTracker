import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/relative_day.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/evaluate_amount_expression.dart';

/// How a transaction's amount is signed and colored (DESIGN §5).
AmountKind amountKindOf(TransactionType type) => switch (type) {
  TransactionType.expense => AmountKind.expense,
  TransactionType.income => AmountKind.income,
  TransactionType.transfer => AmountKind.transfer,
  TransactionType.adjustment => AmountKind.net,
};

String transactionTypeLabel(AppLocalizations l10n, TransactionType type) =>
    switch (type) {
      TransactionType.expense => l10n.type_expense,
      TransactionType.income => l10n.type_income,
      TransactionType.transfer => l10n.type_transfer,
      TransactionType.adjustment => l10n.type_adjustment,
    };

/// Row title: the category name, or the type for transfers/adjustments.
String transactionTitle(AppLocalizations l10n, TransactionView view) =>
    view.category?.name ?? transactionTypeLabel(l10n, view.transaction.type);

/// `Today · 12:30`.
String transactionWhen(
  AppLocalizations l10n,
  TransactionView view,
  LocalDate today,
) =>
    '${relativeDayLabel(l10n, view.transaction.date, today)} · '
    '${view.transaction.time.format()}';

/// `25000+12500` → `25.000 + 12.500`.
String formatExpression(String expression) {
  final tokens = EvaluateAmountExpression.tokenize(expression) ?? const [];
  return tokens
      .map(
        (t) => ExpressionOperator.all.contains(t)
            ? t
            : MoneyFormat.group(int.parse(t)),
      )
      .join(' ');
}

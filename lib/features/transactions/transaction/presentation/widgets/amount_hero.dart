import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/evaluate_amount_expression.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_labels.dart';
import 'package:flutter/material.dart';

/// The amount being typed on the keypad, colored by [type], with the
/// expression and its result below while it has an operator (DESIGN §8.2).
class AmountHero extends StatelessWidget {
  const AmountHero({
    required this.type,
    required this.expression,
    required this.amount,
    super.key,
  });

  final TransactionType type;
  final String expression;
  final int? amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final color = switch (type) {
      TransactionType.income => finance.income,
      TransactionType.transfer => finance.transfer,
      _ => theme.colorScheme.onSurface,
    };
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
          child: MoneyText(
            key: const ValueKey('amount-hero'),
            amount ?? 0,
            hero: true,
            color: color,
            alignment: Alignment.center,
          ),
        ),
        if (EvaluateAmountExpression.hasOperator(expression))
          Padding(
            padding: const EdgeInsets.only(top: Dimens.space1),
            child: Text(
              amount == null
                  ? formatExpression(expression)
                  : '${formatExpression(expression)} = '
                        '${MoneyFormat.full(amount!)}',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

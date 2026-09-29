import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:flutter/material.dart';

/// `Expense | Income | Transfer` at the top of the Add screen (DESIGN
/// §8.2). Null [onChanged] disables it (e.g. while editing).
class TransactionTypeSelector extends StatelessWidget {
  const TransactionTypeSelector({
    required this.selected,
    required this.onChanged,
    super.key,
  });

  final TransactionType selected;
  final ValueChanged<TransactionType>? onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      width: double.infinity,
      child: SegmentedButton<TransactionType>(
        showSelectedIcon: false,
        segments: [
          ButtonSegment(
            value: TransactionType.expense,
            label: Text(l10n.type_expense),
          ),
          ButtonSegment(
            value: TransactionType.income,
            label: Text(l10n.type_income),
          ),
          ButtonSegment(
            value: TransactionType.transfer,
            label: Text(l10n.type_transfer),
          ),
        ],
        selected: {selected},
        onSelectionChanged: onChanged == null
            ? null
            : (s) => onChanged!(s.single),
      ),
    );
  }
}

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_view.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/transaction_notifiers.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_feedback.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// All fields of one transaction, a link to the rule that generated it, and
/// Edit, Duplicate and Delete (DESIGN §8.4). A 90%-height bottom sheet.
Future<void> showTransactionDetailSheet(BuildContext context, String id) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.9,
        child: _TransactionDetail(id: id),
      ),
    );

class _TransactionDetail extends ConsumerWidget {
  const _TransactionDetail({required this.id});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = ref.watch(transactionProvider(id));
    return switch (view) {
      AsyncData(value: final view?) => _Content(view: view),
      AsyncData() || AsyncError() => Center(
        child: Text(AppLocalizations.of(context).failure_not_found),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.view});

  final TransactionView view;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final t = view.transaction;
    final created = t.createdAt.toLocal();

    Widget field(String label, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: theme.textTheme.bodyLarge),
          ),
        ],
      ),
    );

    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.screenPadding,
            ),
            children: [
              Row(
                children: [
                  if (view.category case final category?)
                    CategoryIcon(category, size: 48)
                  else
                    IconCircle(
                      icon: Symbols.swap_horiz_rounded,
                      color: FinanceColors.of(context).transfer,
                      size: 48,
                    ),
                  const SizedBox(width: Dimens.space3),
                  Expanded(
                    child: Text(
                      transactionTitle(l10n, view),
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space4),
              MoneyText(t.signedAmount, kind: amountKindOf(t.type), hero: true),
              const SizedBox(height: Dimens.space4),
              field(l10n.detail_type, transactionTypeLabel(l10n, t.type)),
              field(
                l10n.detail_date_time,
                '${AppDateFormat.weekdayDayMonth(t.date)} ${t.date.year} · '
                '${t.time.format()}',
              ),
              field(
                l10n.detail_account,
                view.toAccount == null
                    ? view.account.name
                    : '${view.account.name} → ${view.toAccount!.name}',
              ),
              if (t.note != null) field(l10n.detail_note, t.note!),
              if (t.recurringRuleId case final ruleId?)
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Text(
                        l10n.detail_recurring_rule,
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: TextButton.icon(
                          key: const ValueKey('detail-rule-link'),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          icon: const Icon(Symbols.repeat_rounded),
                          label: Text(l10n.detail_view_rule),
                          onPressed: () {
                            Navigator.pop(context);
                            context.push(AppPaths.editRecurringOf(ruleId));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              field(
                l10n.detail_created,
                '${AppDateFormat.dayMonthYear(LocalDate.fromDateTime(created))}, '
                '${AppDateFormat.time(created)}',
              ),
            ],
          ),
        ),
        SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.all(Dimens.screenPadding),
            child: OverflowBar(
              alignment: MainAxisAlignment.end,
              spacing: Dimens.space2,
              overflowSpacing: Dimens.space2,
              overflowAlignment: OverflowBarAlignment.end,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: FinanceColors.of(context).expense,
                  ),
                  icon: const Icon(Symbols.delete_rounded),
                  label: Text(l10n.common_delete),
                  onPressed: () {
                    Navigator.pop(context);
                    deleteTransactionWithUndo(context, t.id);
                  },
                ),
                // Adjustments are corrected by a new adjustment, not edited.
                if (t.type != TransactionType.adjustment)
                  FilledButton.tonalIcon(
                    icon: const Icon(Symbols.content_copy_rounded),
                    label: Text(l10n.transaction_duplicate),
                    onPressed: () {
                      Navigator.pop(context);
                      duplicateTransaction(context, t.id);
                    },
                  ),
                if (t.type != TransactionType.adjustment)
                  FilledButton.icon(
                    icon: const Icon(Symbols.edit_rounded),
                    label: Text(l10n.transaction_edit),
                    onPressed: () {
                      Navigator.pop(context);
                      context.push(AppPaths.editTransactionOf(t.id));
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

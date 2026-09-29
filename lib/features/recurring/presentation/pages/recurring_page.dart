import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/widgets/adaptive_layout.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/recurring/domain/entities/pending_occurrence.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_notifiers.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/pending_item_card.dart';
import 'package:expense_tracker/features/recurring/presentation/widgets/recurring_labels.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Pending items to confirm, then every rule with its next date (DESIGN
/// §8.9).
class RecurringPage extends ConsumerWidget {
  const RecurringPage({super.key});

  /// Runs [action], then reports its failure or [success].
  Future<void> _resolve(
    BuildContext context,
    Future<Failure?> action,
    String success,
  ) async {
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final failure = await action;
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            failure == null ? success : failureMessage(l10n, failure),
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final rules = ref.watch(recurringRulesProvider);
    final pending = ref.watch(pendingOccurrencesProvider).value ?? const [];
    void create() => context.push(AppPaths.newRecurring);

    Widget header(String text) => Padding(
      padding: const EdgeInsets.fromLTRB(
        Dimens.screenPadding,
        Dimens.space4,
        Dimens.screenPadding,
        Dimens.space2,
      ),
      child: Semantics(
        header: true,
        child: Text(text, style: theme.textTheme.titleMedium),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.more_recurring),
        actions: [
          IconButton(
            tooltip: l10n.recurring_new,
            icon: const Icon(Symbols.add_rounded),
            onPressed: create,
          ),
        ],
      ),
      body: switch (rules) {
        AsyncData(value: final rules) when rules.isEmpty && pending.isEmpty =>
          Center(
            child: EmptyState(
              icon: Symbols.repeat_rounded,
              message: l10n.recurring_empty,
              actionLabel: l10n.recurring_new,
              onAction: create,
            ),
          ),
        AsyncData(value: final rules) => ListView(
          padding: const EdgeInsets.only(bottom: Dimens.space6),
          children: [
            if (pending.isNotEmpty) ...[
              header(l10n.recurring_pending_header),
              for (final item in pending)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimens.screenPadding,
                    vertical: Dimens.space1,
                  ),
                  child: PendingItemCard(
                    key: ValueKey('pending-${item.pending.id}'),
                    item: item,
                    onConfirm: () => _resolve(
                      context,
                      ref
                          .read(recurringActionsProvider.notifier)
                          .confirm(item.pending.id),
                      l10n.recurring_confirmed,
                    ),
                    onSkip: () => _resolve(
                      context,
                      ref
                          .read(recurringActionsProvider.notifier)
                          .skip(item.pending.id),
                      l10n.recurring_skipped,
                    ),
                  ),
                ),
            ],
            if (rules.isNotEmpty) header(l10n.recurring_rules_header),
            for (final view in rules) _RuleRow(view: view),
          ],
        ),
        AsyncError(:final error) => Center(
          child: EmptyState(
            icon: Symbols.error_rounded,
            message: error is Failure
                ? failureMessage(l10n, error)
                : l10n.failure_unexpected,
            actionLabel: l10n.common_retry,
            onAction: () => ref.invalidate(recurringRulesProvider),
          ),
        ),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

/// icon · name · amount · schedule · next date.
class _RuleRow extends StatelessWidget {
  const _RuleRow({required this.view});

  final RuleView view;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final rule = view.rule;
    final next = rule.nextDate;
    final details = [
      ruleScheduleLabel(l10n, view),
      if (next == null)
        l10n.recurring_ended
      else
        l10n.recurring_next(AppDateFormat.dayMonthYear(next)),
      if (!rule.autoCreate) l10n.recurring_needs_confirm,
    ].join(' · ');
    final amount = MoneyText(rule.amount, kind: amountKindOf(rule.type));
    final stacked = useStackedLayout(context);
    return ListTile(
      key: ValueKey('rule-${rule.id}'),
      leading: RuleIcon(view),
      title: Text(
        ruleTitle(l10n, view),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: stacked
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [amount, Text(details)],
            )
          : Text(details),
      trailing: stacked ? null : amount,
      onTap: () => context.push(AppPaths.editRecurringOf(rule.id)),
    );
  }
}

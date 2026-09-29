import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/presentation/providers/accounts_notifier.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_edit_sheet.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_icon.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_labels.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/balance_history_chart.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/money_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Accounts with balances, total and balance over time (DESIGN §8.7).
class AccountsPage extends ConsumerWidget {
  const AccountsPage({super.key});

  static const _historyMonths = 6;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final balances = ref.watch(accountBalancesProvider).value ?? const [];
    final history = ref.watch(balanceHistoryProvider(_historyMonths)).value;
    final active = balances.where((b) => !b.account.isArchived).toList();
    final archived = balances.where((b) => b.account.isArchived).toList();
    final total = active.fold(0, (sum, b) => sum + b.balance);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.more_accounts),
        actions: [
          IconButton(
            tooltip: l10n.accounts_transfer,
            icon: const Icon(Symbols.swap_horiz_rounded),
            onPressed: active.length > 1
                ? () => context.push(AppPaths.addOfType('transfer'))
                : null,
          ),
          IconButton(
            tooltip: l10n.accounts_new,
            icon: const Icon(Symbols.add_rounded),
            onPressed: () => showAccountEditSheet(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(Dimens.screenPadding),
        children: [
          Text(l10n.accounts_total, style: theme.textTheme.labelLarge),
          MoneyText(
            total,
            kind: AmountKind.plain,
            hero: true,
            key: const ValueKey('accounts-total'),
          ),
          const SizedBox(height: Dimens.space4),
          if (history != null && history.accounts.isNotEmpty)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(Dimens.cardPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.accounts_balance_over_time,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: Dimens.space4),
                    BalanceHistoryChart(history: history),
                  ],
                ),
              ),
            ),
          const SizedBox(height: Dimens.cardGap),
          for (final balance in active) ...[
            _AccountCard(balance: balance),
            const SizedBox(height: Dimens.cardGap),
          ],
          if (archived.isNotEmpty)
            ExpansionTile(
              title: Text(l10n.categories_archived(archived.length)),
              children: [
                for (final balance in archived) _AccountCard(balance: balance),
              ],
            ),
        ],
      ),
    );
  }
}

enum _AccountAction { edit, adjust, archive, delete }

class _AccountCard extends ConsumerWidget {
  const _AccountCard({required this.balance});

  final AccountBalance balance;

  void _show(BuildContext context, Failure? failure, [String? success]) {
    final l10n = AppLocalizations.of(context);
    final text = failure == null ? success : failureMessage(l10n, failure);
    if (text == null) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  Future<void> _adjust(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final actual = await showDialog<int>(
      context: context,
      builder: (context) => _AdjustDialog(balance: balance),
    );
    if (actual == null || !context.mounted) return;
    final result = await ref
        .read(accountActionsProvider.notifier)
        .adjust(balance.account.id, actual);
    if (!context.mounted) return;
    result.match(
      (failure) => _show(context, failure),
      (delta) => _show(
        context,
        null,
        delta == 0
            ? l10n.accounts_adjust_none
            : l10n.accounts_adjusted(MoneyFormat.signed(delta)),
      ),
    );
  }

  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.accounts_delete_title(balance.account.name)),
        content: Text(l10n.accounts_delete_body),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.common_delete),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false) || !context.mounted) return;
    final failure = await ref
        .read(accountActionsProvider.notifier)
        .delete(balance.account.id);
    if (context.mounted) _show(context, failure);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final account = balance.account;
    return Card(
      child: InkWell(
        onTap: () => showAccountEditSheet(context, existing: account),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.cardPadding),
          child: Row(
            children: [
              AccountIcon(account),
              const SizedBox(width: Dimens.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(account.name, style: theme.textTheme.titleMedium),
                    Text(
                      accountTypeLabel(l10n, account.type),
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    MoneyText(
                      balance.balance,
                      hero: true,
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              PopupMenuButton<_AccountAction>(
                onSelected: (action) => switch (action) {
                  _AccountAction.edit => showAccountEditSheet(
                    context,
                    existing: account,
                  ),
                  _AccountAction.adjust => _adjust(context, ref),
                  _AccountAction.archive =>
                    ref
                        .read(accountActionsProvider.notifier)
                        .setArchived(account.id, archived: !account.isArchived)
                        .then((f) {
                          if (context.mounted) _show(context, f);
                        }),
                  _AccountAction.delete => _delete(context, ref),
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: _AccountAction.edit,
                    child: Text(l10n.transaction_edit),
                  ),
                  PopupMenuItem(
                    value: _AccountAction.adjust,
                    child: Text(l10n.accounts_adjust),
                  ),
                  PopupMenuItem(
                    value: _AccountAction.archive,
                    child: Text(
                      account.isArchived
                          ? l10n.categories_unarchive
                          : l10n.categories_archive,
                    ),
                  ),
                  PopupMenuItem(
                    value: _AccountAction.delete,
                    child: Text(l10n.common_delete),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Asks for the real balance; owns its text controller so it outlives the
/// closing animation.
class _AdjustDialog extends StatefulWidget {
  const _AdjustDialog({required this.balance});

  final AccountBalance balance;

  @override
  State<_AdjustDialog> createState() => _AdjustDialogState();
}

class _AdjustDialogState extends State<_AdjustDialog> {
  late final _controller = TextEditingController(
    text: MoneyField.initialText(widget.balance.balance),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.accounts_adjust_title(widget.balance.account.name)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.accounts_adjust_body),
          const SizedBox(height: Dimens.space4),
          MoneyField(
            key: const ValueKey('adjust-field'),
            controller: _controller,
            label: l10n.accounts_actual_balance,
            allowNegative: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          key: const ValueKey('adjust-save'),
          onPressed: () =>
              Navigator.pop(context, MoneyField.valueOf(_controller)),
          child: Text(l10n.common_save),
        ),
      ],
    );
  }
}

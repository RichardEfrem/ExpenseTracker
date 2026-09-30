import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account.dart';
import 'package:expense_tracker/features/accounts/domain/entities/account_balance.dart';
import 'package:expense_tracker/features/accounts/presentation/providers/accounts_notifier.dart';
import 'package:expense_tracker/features/accounts/presentation/widgets/account_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Current balance across active accounts, then each account's balance in
/// smaller type when there is more than one (DESIGN §8.1, §8.3). Tapping the
/// total opens Accounts; tapping an account calls [onAccountTap].
class AccountBalancesCard extends ConsumerWidget {
  const AccountBalancesCard({this.onAccountTap, super.key});

  final ValueChanged<Account>? onAccountTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final balances = ref.watch(accountBalancesProvider).value;
    if (balances == null) return const SizedBox.shrink();
    final active = balances.where((b) => !b.account.isArchived).toList();
    final total = active.fold(0, (sum, b) => sum + b.balance);

    return Card(
      key: const ValueKey('account-balances'),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () => context.push(AppPaths.accounts),
            child: Padding(
              padding: const EdgeInsets.all(Dimens.cardPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.accounts_total, style: theme.textTheme.labelLarge),
                  const SizedBox(height: Dimens.space1),
                  MoneyText(
                    total,
                    hero: true,
                    countUp: true,
                    style: theme.textTheme.headlineMedium,
                    key: const ValueKey('account-balances-total'),
                  ),
                ],
              ),
            ),
          ),
          if (active.length > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(
                Dimens.space2,
                0,
                Dimens.space2,
                Dimens.space2,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final balance in active)
                    _AccountTile(
                      balance: balance,
                      onTap: onAccountTap == null
                          ? null
                          : () => onAccountTap!(balance.account),
                    ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Icon, name and balance of one account, compact.
class _AccountTile extends StatelessWidget {
  const _AccountTile({required this.balance, required this.onTap});

  final AccountBalance balance;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final account = balance.account;
    return InkWell(
      key: ValueKey('account-balance-${account.id}'),
      borderRadius: BorderRadius.circular(Dimens.radiusSmall),
      onTap: onTap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: Dimens.minTouchTarget),
        child: Padding(
          padding: const EdgeInsets.all(Dimens.space2),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccountIcon(account, size: 28),
              const SizedBox(width: Dimens.space2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    account.name,
                    style: theme.textTheme.labelMedium!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  MoneyText(balance.balance, style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

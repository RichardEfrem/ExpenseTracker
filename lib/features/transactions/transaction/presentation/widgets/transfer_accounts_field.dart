import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// `From [Cash ▾] → To [BCA ▾]` in place of the category grid (DESIGN
/// §8.2), or a pointer to Accounts when there is only one account.
class TransferAccountsField extends StatelessWidget {
  const TransferAccountsField({
    required this.canTransfer,
    required this.from,
    required this.to,
    required this.onFrom,
    required this.onTo,
    super.key,
  });

  final bool canTransfer;
  final String from;
  final String? to;
  final VoidCallback onFrom;
  final VoidCallback onTo;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!canTransfer) {
      return EmptyState(
        icon: Symbols.swap_horiz_rounded,
        message: l10n.transfer_needs_accounts,
        actionLabel: l10n.more_accounts,
        onAction: () => GoRouter.of(context).push(AppPaths.accounts),
      );
    }
    Widget picker(Key key, String label, String value, VoidCallback onTap) =>
        Expanded(
          child: InputDecorator(
            decoration: InputDecoration(labelText: label),
            child: InkWell(
              key: key,
              onTap: onTap,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(Symbols.arrow_drop_down_rounded),
                ],
              ),
            ),
          ),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
      child: Row(
        children: [
          picker(
            const ValueKey('transfer-from'),
            l10n.transfer_from,
            from,
            onFrom,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.space2),
            child: Icon(Symbols.arrow_forward_rounded),
          ),
          picker(
            const ValueKey('transfer-to'),
            l10n.transfer_to,
            to ?? '',
            onTo,
          ),
        ],
      ),
    );
  }
}

import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/features/recurring/presentation/providers/recurring_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// "⚠ 2 recurring items to confirm · REVIEW" on Home (DESIGN §8.1); takes
/// no space when nothing is pending.
class PendingRecurringBanner extends ConsumerWidget {
  const PendingRecurringBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(
      pendingOccurrencesProvider.select((p) => p.value?.length ?? 0),
    );
    if (count == 0) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final finance = FinanceColors.of(context);
    void review() => context.push(AppPaths.recurring);
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimens.cardGap),
      child: Card(
        key: const ValueKey('pending-recurring'),
        color: finance.warningContainer,
        child: InkWell(
          onTap: review,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.cardPadding,
              Dimens.space1,
              Dimens.space2,
              Dimens.space1,
            ),
            child: Row(
              children: [
                Icon(Symbols.warning_rounded, color: finance.warning),
                const SizedBox(width: Dimens.space3),
                Expanded(
                  child: Text(
                    l10n.recurring_pending_banner(count),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(foregroundColor: finance.warning),
                  onPressed: review,
                  child: Text(l10n.recurring_review),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

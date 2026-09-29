import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/relative_day.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:flutter/material.dart';

/// `Today  −Rp 128.000` (DESIGN §7.4); pinned while its day scrolls.
class DayHeader extends StatelessWidget {
  const DayHeader({
    required this.date,
    required this.today,
    required this.net,
    super.key,
  });

  final LocalDate date;
  final LocalDate today;
  final int net;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      header: true,
      child: ColoredBox(
        color: theme.scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.screenPadding,
            Dimens.space3,
            Dimens.screenPadding,
            Dimens.space1,
          ),
          // Wraps the net under the date when text is scaled up.
          child: SizedBox(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: Dimens.space2,
              children: [
                Text(
                  relativeDayLabel(AppLocalizations.of(context), date, today),
                  style: theme.textTheme.titleMedium,
                ),
                MoneyText(
                  net,
                  kind: AmountKind.net,
                  style: theme.textTheme.bodyMedium,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

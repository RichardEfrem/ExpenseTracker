import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:expense_tracker/features/reports/tags/domain/entities/tag_report.dart';
import 'package:expense_tracker/features/reports/tags/presentation/providers/tag_report_notifier.dart';
import 'package:expense_tracker/features/transactions/transactions_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// "trip-bali: 2,5 million rupiah, 12 transactions" (screen reader).
String tagRowLabel(AppLocalizations l10n, TagTotal total) =>
    l10n.tag_report_row_label(
      total.name,
      moneySemantics(l10n, total.amount),
      total.count,
    );

/// Totals per tag in the period (PRD RPT-08), largest first. Tap a tag to
/// see its transactions.
class TagReportView extends ConsumerStatefulWidget {
  const TagReportView({required this.scope, super.key});

  final ReportScope scope;

  @override
  ConsumerState<TagReportView> createState() => _TagReportViewState();
}

class _TagReportViewState extends ConsumerState<TagReportView> {
  var _type = CategoryType.expense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final report = ref.watch(tagReportProvider(widget.scope, _type)).value;
    return ReportCard(
      title: l10n.tag_report_title,
      trailing: SegmentedButton<CategoryType>(
        showSelectedIcon: false,
        style: const ButtonStyle(visualDensity: VisualDensity.compact),
        segments: [
          ButtonSegment(
            value: CategoryType.expense,
            label: Text(l10n.type_expense),
          ),
          ButtonSegment(
            value: CategoryType.income,
            label: Text(l10n.type_income),
          ),
        ],
        selected: {_type},
        onSelectionChanged: (s) => setState(() => _type = s.single),
      ),
      child: switch (report) {
        null => const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
        TagReport(isEmpty: true) => Padding(
          key: const ValueKey('tag-report-empty'),
          padding: const EdgeInsets.all(Dimens.space6),
          child: Text(l10n.tag_report_empty, textAlign: TextAlign.center),
        ),
        final report => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Dimens.space2),
              child: Text(
                l10n.tag_report_overlap_hint,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            for (final total in report.totals)
              _Row(
                total: total,
                largest: report.largest,
                type: _type,
                onTap: () => drillDown(
                  context,
                  periodFilter(
                    widget.scope.period,
                    types: {
                      _type == CategoryType.expense
                          ? TransactionType.expense
                          : TransactionType.income,
                    },
                    accountIds: widget.scope.accountIds,
                  ).copyWith(tags: {total.name}),
                ),
              ),
          ],
        ),
      },
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({
    required this.total,
    required this.largest,
    required this.type,
    required this.onTap,
  });

  final TagTotal total;
  final int largest;
  final CategoryType type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final color = type == CategoryType.income
        ? finance.income
        : theme.colorScheme.primary;
    return Semantics(
      button: true,
      label: tagRowLabel(l10n, total),
      excludeSemantics: true,
      child: InkWell(
        key: ValueKey('tag-row-${total.name}'),
        onTap: onTap,
        borderRadius: BorderRadius.circular(Dimens.radiusSmall),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '#${total.name}',
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: Dimens.space2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        MoneyFormat.full(total.amount),
                        style: theme.textTheme.bodyMedium!.tabular,
                      ),
                      Text(
                        l10n.tag_report_count(total.count),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Dimens.space1),
              ClipRRect(
                borderRadius: BorderRadius.circular(Dimens.space1),
                child: LinearProgressIndicator(
                  value: largest == 0 ? 0 : total.amount / largest,
                  minHeight: Dimens.space2,
                  color: color,
                  backgroundColor: theme.colorScheme.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

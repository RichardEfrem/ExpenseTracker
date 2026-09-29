import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_text_theme.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/core/widgets/adaptive_layout.dart';
import 'package:expense_tracker/core/widgets/money_semantics.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/compare/presentation/providers/comparison_notifier.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/drill_down.dart';
import 'package:expense_tracker/features/reports/shared/presentation/widgets/report_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// `▲ +300K`: arrow and sign carry the direction; color stays neutral
/// (DESIGN §7.2).
String deltaLabel(int delta) {
  final arrow = delta > 0
      ? '▲ '
      : delta < 0
      ? '▼ '
      : '';
  return '$arrow${MoneyFormat.compactSigned(delta)}';
}

/// `▲ 12,4%`, or "New" when the category had nothing before.
String deltaPercentLabel(AppLocalizations l10n, CategoryChange change) =>
    MoneyFormat.change(change.current, change.previous) ?? l10n.compare_new;

/// "Food & Drinks: 1 million rupiah this period, 800 thousand rupiah the
/// period before. Change plus 200 thousand rupiah, up 25,0%."
String compareRowLabel(
  AppLocalizations l10n,
  String name,
  CategoryChange change,
) {
  final share = change.deltaShare;
  final percent = share == null ? null : MoneyFormat.percent(share.abs());
  return l10n.compare_row_label(
    name,
    moneySemantics(l10n, change.current),
    moneySemantics(l10n, change.previous),
    moneySemantics(l10n, change.delta, AmountKind.net),
    switch (share) {
      null => l10n.compare_change_new,
      0 => l10n.compare_change_same,
      > 0 => l10n.compare_change_up(percent!),
      _ => l10n.compare_change_down(percent!),
    },
  );
}

/// Column header for a period: `Sep` for calendar months, else [fallback].
String _periodHeader(Period period, String fallback) =>
    period.isCalendarMonth ? AppDateFormat.monthShort(period.start) : fallback;

/// This period against the one before, per category (PRD RPT-05): category
/// · this · previous · Δ · Δ%, largest change first.
class CompareView extends ConsumerStatefulWidget {
  const CompareView({required this.scope, super.key});

  final ReportScope scope;

  @override
  ConsumerState<CompareView> createState() => _CompareViewState();
}

class _CompareViewState extends ConsumerState<CompareView> {
  var _type = CategoryType.expense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final comparison = ref.watch(comparisonProvider(widget.scope, _type)).value;
    return ReportCard(
      title: l10n.compare_title,
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
      child: switch (comparison) {
        null => const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()),
        ),
        PeriodComparison(isEmpty: true) => Padding(
          padding: const EdgeInsets.all(Dimens.space6),
          child: Text(l10n.breakdown_empty, textAlign: TextAlign.center),
        ),
        final comparison => _Table(
          comparison: comparison,
          onTap: (change) => drillDown(
            context,
            periodFilter(
              widget.scope.period,
              categoryIds: {change.category.id},
            ),
          ),
        ),
      },
    );
  }
}

class _Table extends StatelessWidget {
  const _Table({required this.comparison, required this.onTap});

  final PeriodComparison comparison;
  final ValueChanged<CategoryChange> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final stacked = useStackedLayout(context);
    final number = theme.textTheme.bodySmall!.tabular;
    final header = theme.textTheme.labelSmall!
        .copyWith(color: theme.colorScheme.onSurfaceVariant)
        .tabular;
    final thisLabel = _periodHeader(comparison.current, l10n.compare_this);
    final previousLabel = _periodHeader(
      comparison.previous,
      l10n.compare_previous,
    );

    Widget cell(String text, TextStyle style) => Padding(
      padding: const EdgeInsets.only(left: Dimens.space1),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        alignment: AlignmentDirectional.centerEnd,
        child: Text(text, style: style, maxLines: 1),
      ),
    );

    Widget row(
      CategoryChange change, {
      required String name,
      Widget? leading,
      VoidCallback? onTap,
      TextStyle? nameStyle,
    }) {
      final values = [
        MoneyFormat.compactNumber(change.current),
        MoneyFormat.compactNumber(change.previous),
        deltaLabel(change.delta),
        deltaPercentLabel(l10n, change),
      ];
      final title = Text(
        name,
        maxLines: stacked ? 2 : 1,
        overflow: TextOverflow.ellipsis,
        style: nameStyle ?? theme.textTheme.bodyMedium,
      );
      return Semantics(
        button: onTap != null,
        label: compareRowLabel(l10n, name, change),
        excludeSemantics: true,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimens.radiusSmall),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space2),
            child: stacked
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ?leading,
                      if (leading != null) const SizedBox(width: Dimens.space2),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            title,
                            Text(
                              '$thisLabel ${values[0]} · '
                              '$previousLabel ${values[1]}',
                              style: number,
                            ),
                            Text('${values[2]} · ${values[3]}', style: number),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(child: title),
                      for (final (i, value) in values.indexed)
                        SizedBox(
                          width: _columnWidths[i],
                          child: cell(value, number),
                        ),
                    ],
                  ),
          ),
        ),
      );
    }

    // Only the amounts of the total are read; the name comes from [row].
    final total = CategoryChange(
      category: comparison.changes.first.category,
      current: comparison.currentTotal,
      previous: comparison.previousTotal,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!stacked)
          ExcludeSemantics(
            child: Row(
              children: [
                Expanded(child: Text(l10n.compare_category, style: header)),
                for (final (i, label) in [
                  thisLabel,
                  previousLabel,
                  l10n.compare_change,
                  '%',
                ].indexed)
                  SizedBox(width: _columnWidths[i], child: cell(label, header)),
              ],
            ),
          ),
        for (final change in comparison.changes)
          row(
            change,
            name: change.category.name,
            leading: CategoryIcon(change.category, size: 24),
            onTap: () => onTap(change),
          ),
        const Divider(),
        row(
          total,
          name: l10n.compare_total,
          nameStyle: theme.textTheme.titleSmall,
        ),
      ],
    );
  }

  /// This · before · Δ · Δ%, sized for compact values like `▲ +1,2M`;
  /// the category name takes the rest.
  static const _columnWidths = [48.0, 48.0, 64.0, 60.0];
}

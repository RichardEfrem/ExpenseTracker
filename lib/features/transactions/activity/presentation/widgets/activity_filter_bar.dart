import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/features/accounts/accounts_presentation.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/tags/tags_presentation.dart';
import 'package:expense_tracker/features/transactions/activity/domain/entities/transaction_filter.dart';
import 'package:expense_tracker/core/widgets/multi_select_sheet.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/widgets/transaction_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Horizontally scrolling filter chips; an active chip shows its value and
/// an × (DESIGN §7.8).
class ActivityFilterBar extends ConsumerWidget {
  const ActivityFilterBar({
    required this.filter,
    required this.onChanged,
    super.key,
  });

  final TransactionFilter filter;
  final ValueChanged<TransactionFilter> onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final expense = ref.watch(
      categoriesProvider(CategoryType.expense, includeArchived: true),
    );
    final income = ref.watch(
      categoriesProvider(CategoryType.income, includeArchived: true),
    );
    final categories = [...?expense.value, ...?income.value];
    final accounts = ref.watch(accountsProvider()).value ?? const [];
    final tags = ref.watch(tagsProvider).value ?? const <Tag>[];
    final types = [
      TransactionType.expense,
      TransactionType.income,
      if (accounts.length > 1) TransactionType.transfer,
    ];

    String names<T>(
      Iterable<T> items,
      bool Function(T) selected,
      String Function(T) name,
    ) => items.where(selected).map(name).join(', ');

    Widget chip({
      required Key key,
      required String label,
      required String? value,
      required VoidCallback onPressed,
      required VoidCallback onClear,
    }) => Padding(
      padding: const EdgeInsets.only(right: Dimens.space2),
      child: InputChip(
        key: key,
        label: Text(
          value == null ? '$label ▾' : l10n.filter_value(label, value),
        ),
        selected: value != null,
        showCheckmark: false,
        onPressed: onPressed,
        onDeleted: value == null ? null : onClear,
        deleteButtonTooltipMessage: l10n.filter_remove(label),
      ),
    );

    final from = filter.from;
    final to = filter.to;
    final dateValue = !filter.hasDateRange
        ? null
        : from != null && to != null
        ? '${AppDateFormat.dayMonth(from)} – ${AppDateFormat.dayMonth(to)}'
        : from != null
        ? l10n.filter_from(AppDateFormat.dayMonth(from))
        : l10n.filter_until(AppDateFormat.dayMonth(to!));
    final min = filter.minAmount;
    final max = filter.maxAmount;
    final amountValue = !filter.hasAmountRange
        ? null
        : min != null && max != null
        ? '${MoneyFormat.full(min)} – ${MoneyFormat.full(max)}'
        : min != null
        ? '≥ ${MoneyFormat.full(min)}'
        : '≤ ${MoneyFormat.full(max!)}';

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: Dimens.screenPadding),
      child: Row(
        children: [
          chip(
            key: const ValueKey('filter-type'),
            label: l10n.filter_type,
            value: filter.types.isEmpty
                ? null
                : names(
                    types,
                    filter.types.contains,
                    (t) => transactionTypeLabel(l10n, t),
                  ),
            onPressed: () async {
              final picked = await showMultiSelectSheet(
                context,
                title: l10n.filter_type,
                selected: filter.types,
                options: [
                  for (final t in types)
                    (
                      value: t,
                      label: transactionTypeLabel(l10n, t),
                      leading: null,
                    ),
                ],
              );
              if (picked != null) onChanged(filter.copyWith(types: picked));
            },
            onClear: () => onChanged(filter.copyWith(types: const {})),
          ),
          chip(
            key: const ValueKey('filter-category'),
            label: l10n.filter_category,
            value: filter.categoryIds.isEmpty
                ? null
                : names(
                    categories,
                    (c) => filter.categoryIds.contains(c.id),
                    (c) => c.name,
                  ),
            onPressed: () async {
              final picked = await showMultiSelectSheet(
                context,
                title: l10n.filter_category,
                selected: filter.categoryIds,
                options: [
                  for (final c in categories)
                    (value: c.id, label: c.name, leading: CategoryIcon(c)),
                ],
              );
              if (picked != null) {
                onChanged(filter.copyWith(categoryIds: picked));
              }
            },
            onClear: () => onChanged(filter.copyWith(categoryIds: const {})),
          ),
          if (accounts.length > 1 || filter.accountIds.isNotEmpty)
            chip(
              key: const ValueKey('filter-account'),
              label: l10n.filter_account,
              value: filter.accountIds.isEmpty
                  ? null
                  : names(
                      accounts,
                      (a) => filter.accountIds.contains(a.id),
                      (a) => a.name,
                    ),
              onPressed: () async {
                final picked = await showMultiSelectSheet(
                  context,
                  title: l10n.filter_account,
                  selected: filter.accountIds,
                  options: [
                    for (final a in accounts)
                      (value: a.id, label: a.name, leading: null),
                  ],
                );
                if (picked != null) {
                  onChanged(filter.copyWith(accountIds: picked));
                }
              },
              onClear: () => onChanged(filter.copyWith(accountIds: const {})),
            ),
          if (tags.isNotEmpty || filter.tags.isNotEmpty)
            chip(
              key: const ValueKey('filter-tag'),
              label: l10n.filter_tag,
              value: filter.tags.isEmpty
                  ? null
                  : tagsLabel(filter.tags.toList()..sort()),
              onPressed: () async {
                final picked = await showMultiSelectSheet(
                  context,
                  title: l10n.filter_tag,
                  selected: filter.tags,
                  options: [
                    for (final t in tags)
                      (value: t.name, label: '#${t.name}', leading: null),
                  ],
                );
                if (picked != null) onChanged(filter.copyWith(tags: picked));
              },
              onClear: () => onChanged(filter.copyWith(tags: const {})),
            ),
          chip(
            key: const ValueKey('filter-date'),
            label: l10n.filter_date,
            value: dateValue,
            onPressed: () async {
              final range = await showDateRangePicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime(ref.read(clockProvider).now().year + 5),
                initialDateRange: from != null && to != null
                    ? DateTimeRange(
                        start: from.toDateTime(),
                        end: to.toDateTime(),
                      )
                    : null,
              );
              if (range == null) return;
              onChanged(
                filter.copyWith(
                  from: LocalDate.fromDateTime(range.start),
                  to: LocalDate.fromDateTime(range.end),
                ),
              );
            },
            onClear: () => onChanged(filter.copyWith(from: null, to: null)),
          ),
          chip(
            key: const ValueKey('filter-amount'),
            label: l10n.filter_amount,
            value: amountValue,
            onPressed: () async {
              final picked = await _showAmountDialog(context, min, max);
              if (picked == null) return;
              onChanged(
                filter.copyWith(minAmount: picked.$1, maxAmount: picked.$2),
              );
            },
            onClear: () =>
                onChanged(filter.copyWith(minAmount: null, maxAmount: null)),
          ),
        ],
      ),
    );
  }

  static Future<(int?, int?)?> _showAmountDialog(
    BuildContext context,
    int? min,
    int? max,
  ) => showDialog<(int?, int?)>(
    context: context,
    builder: (context) => _AmountRangeDialog(min: min, max: max),
  );
}

/// Minimum/maximum amount; owns its text controllers so they outlive the
/// closing animation.
class _AmountRangeDialog extends StatefulWidget {
  const _AmountRangeDialog({this.min, this.max});

  final int? min;
  final int? max;

  @override
  State<_AmountRangeDialog> createState() => _AmountRangeDialogState();
}

class _AmountRangeDialogState extends State<_AmountRangeDialog> {
  late final _min = TextEditingController(text: widget.min?.toString());
  late final _max = TextEditingController(text: widget.max?.toString());

  @override
  void dispose() {
    _min.dispose();
    _max.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    InputDecoration decoration(String label) =>
        InputDecoration(labelText: label, prefixText: '${MoneyFormat.symbol} ');
    return AlertDialog(
      title: Text(l10n.filter_amount),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const ValueKey('amount-min'),
            controller: _min,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: decoration(l10n.filter_amount_min),
          ),
          const SizedBox(height: Dimens.space3),
          TextField(
            key: const ValueKey('amount-max'),
            controller: _max,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: decoration(l10n.filter_amount_max),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.common_cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, (
            int.tryParse(_min.text),
            int.tryParse(_max.text),
          )),
          child: Text(l10n.filter_apply),
        ),
      ],
    );
  }
}

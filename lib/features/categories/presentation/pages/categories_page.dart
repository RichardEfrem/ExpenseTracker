import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/widgets/empty_state.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/presentation/providers/categories_notifier.dart';
import 'package:expense_tracker/features/categories/presentation/widgets/category_edit_sheet.dart';
import 'package:expense_tracker/features/categories/presentation/widgets/category_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Manage categories: Expense/Income tabs, drag to reorder, edit, archive,
/// merge, delete (DESIGN §8.8, PRD CAT-01…07).
class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var _type = CategoryType.expense;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.more_categories),
        actions: [
          IconButton(
            tooltip: l10n.categories_new_title,
            icon: const Icon(Symbols.add_rounded),
            onPressed: () => showCategoryEditSheet(context, type: _type),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Dimens.screenPadding,
              Dimens.space2,
              Dimens.screenPadding,
              Dimens.space2,
            ),
            child: SizedBox(
              width: double.infinity,
              child: SegmentedButton<CategoryType>(
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
                showSelectedIcon: false,
                onSelectionChanged: (s) => setState(() => _type = s.single),
              ),
            ),
          ),
          Expanded(
            child: _CategoryList(key: ValueKey(_type), type: _type),
          ),
        ],
      ),
    );
  }
}

class _CategoryList extends ConsumerStatefulWidget {
  const _CategoryList({required this.type, super.key});

  final CategoryType type;

  @override
  ConsumerState<_CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends ConsumerState<_CategoryList> {
  /// Optimistic order while a reorder is being written.
  List<Category>? _pendingOrder;

  void _showFailure(Failure? failure) {
    if (failure == null || !mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(failureMessage(AppLocalizations.of(context), failure)),
      ),
    );
  }

  Future<void> _reorder(List<Category> active, int from, int to) async {
    final list = [...active];
    list.insert(to, list.removeAt(from));
    setState(() => _pendingOrder = list);
    final failure = await ref.read(categoryActionsProvider.notifier).reorder([
      for (final c in list) c.id,
    ]);
    if (mounted) setState(() => _pendingOrder = null);
    _showFailure(failure);
  }

  Future<void> _delete(Category category) async {
    final l10n = AppLocalizations.of(context);
    final actions = ref.read(categoryActionsProvider.notifier);
    final failure = await actions.delete(category.id);
    if (!mounted) return;
    if (failure case ValidationFailure(
      reason: ValidationReason.categoryInUse,
    )) {
      // In use: offer archive instead (PRD CAT-05).
      final archive = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(l10n.categories_in_use_title),
          content: Text(l10n.categories_in_use_body(category.name)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.common_cancel),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.categories_archive),
            ),
          ],
        ),
      );
      if (archive ?? false) _showFailure(await actions.archive(category.id));
      return;
    }
    _showFailure(failure);
  }

  Future<void> _merge(Category from, List<Category> candidates) async {
    final l10n = AppLocalizations.of(context);
    final into = await showModalBottomSheet<Category>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        builder: (context, controller) => ListView(
          controller: controller,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.screenPadding),
              child: Text(
                l10n.categories_merge_title(from.name),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (final c in candidates)
              ListTile(
                leading: CategoryIcon(c),
                title: Text(c.name),
                onTap: () => Navigator.pop(context, c),
              ),
          ],
        ),
      ),
    );
    if (into == null || !mounted) return;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.categories_merge_confirm_title),
        content: Text(l10n.categories_merge_confirm_body(from.name, into.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.common_cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.categories_merge),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;
    _showFailure(
      await ref
          .read(categoryActionsProvider.notifier)
          .merge(fromId: from.id, intoId: into.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final categories = ref.watch(
      categoriesProvider(widget.type, includeArchived: true),
    );
    final usage = ref.watch(categoryUsageProvider).value ?? const {};

    return switch (categories) {
      AsyncData(:final value) => () {
        final active =
            _pendingOrder ?? value.where((c) => !c.isArchived).toList();
        final archived = value.where((c) => c.isArchived).toList();
        if (value.isEmpty) {
          return Center(
            child: EmptyState(
              icon: Symbols.category_rounded,
              message: l10n.categories_empty,
              actionLabel: l10n.categories_new_title,
              onAction: () => showCategoryEditSheet(context, type: widget.type),
            ),
          );
        }
        Widget row(
          Category c, {
          required int index,
          required bool isArchived,
        }) => _CategoryRow(
          key: ValueKey(c.id),
          category: c,
          count: usage[c.id] ?? 0,
          index: isArchived ? null : index,
          onEdit: () =>
              showCategoryEditSheet(context, type: widget.type, existing: c),
          onArchiveToggle: () async {
            final actions = ref.read(categoryActionsProvider.notifier);
            _showFailure(
              await (isArchived
                  ? actions.unarchive(c.id)
                  : actions.archive(c.id)),
            );
          },
          onMerge: active.any((o) => o.id != c.id)
              ? () => _merge(c, [
                  for (final o in active)
                    if (o.id != c.id) o,
                ])
              : null,
          onDelete: () => _delete(c),
        );

        return ReorderableListView.builder(
          buildDefaultDragHandles: false,
          padding: const EdgeInsets.only(bottom: Dimens.space8),
          itemCount: active.length,
          onReorderItem: (from, to) => _reorder(active, from, to),
          itemBuilder: (context, i) =>
              row(active[i], index: i, isArchived: false),
          footer: archived.isEmpty
              ? null
              : ExpansionTile(
                  key: const ValueKey('archived'),
                  title: Text(l10n.categories_archived(archived.length)),
                  children: [
                    for (final (i, c) in archived.indexed)
                      row(c, index: i, isArchived: true),
                  ],
                ),
        );
      }(),
      AsyncError(:final error) => Center(
        child: EmptyState(
          icon: Symbols.error_rounded,
          message: error is Failure
              ? failureMessage(l10n, error)
              : l10n.failure_unexpected,
        ),
      ),
      _ => const Center(child: CircularProgressIndicator()),
    };
  }
}

enum _RowAction { archive, merge, delete }

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.count,
    required this.index,
    required this.onEdit,
    required this.onArchiveToggle,
    required this.onMerge,
    required this.onDelete,
    super.key,
  });

  final Category category;
  final int count;

  /// Position in the reorderable list; null for archived rows.
  final int? index;
  final VoidCallback onEdit;
  final VoidCallback onArchiveToggle;
  final VoidCallback? onMerge;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final index = this.index;
    return ListTile(
      minTileHeight: Dimens.rowHeight,
      leading: CategoryIcon(category),
      title: Text(category.name),
      subtitle: Text(l10n.categories_transaction_count(count)),
      onTap: onEdit,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          PopupMenuButton<_RowAction>(
            icon: const Icon(Symbols.more_vert_rounded),
            onSelected: (action) => switch (action) {
              _RowAction.archive => onArchiveToggle(),
              _RowAction.merge => onMerge?.call(),
              _RowAction.delete => onDelete(),
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: _RowAction.archive,
                child: Text(
                  category.isArchived
                      ? l10n.categories_unarchive
                      : l10n.categories_archive,
                ),
              ),
              if (onMerge != null)
                PopupMenuItem(
                  value: _RowAction.merge,
                  child: Text(l10n.categories_merge_into),
                ),
              PopupMenuItem(
                value: _RowAction.delete,
                child: Text(l10n.common_delete),
              ),
            ],
          ),
          if (index != null)
            ReorderableDragStartListener(
              index: index,
              child: Tooltip(
                message: l10n.categories_reorder,
                child: const SizedBox.square(
                  dimension: Dimens.minTouchTarget,
                  child: Icon(Symbols.drag_indicator_rounded),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

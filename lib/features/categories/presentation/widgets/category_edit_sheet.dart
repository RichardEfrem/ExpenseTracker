import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/constants/palette_color.dart';
import 'package:expense_tracker/core/error/failure_message.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/category_icons.dart';
import 'package:expense_tracker/core/theme/finance_colors.dart';
import 'package:expense_tracker/core/widgets/icon_circle.dart';
import 'package:expense_tracker/features/categories/domain/entities/category.dart';
import 'package:expense_tracker/features/categories/domain/entities/category_input.dart';
import 'package:expense_tracker/features/categories/presentation/providers/categories_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Opens the create/edit sheet (DESIGN §8.8). Returns the new category when
/// one was created, so the caller can select it.
Future<Category?> showCategoryEditSheet(
  BuildContext context, {
  required CategoryType type,
  Category? existing,
}) => showModalBottomSheet<Category>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) => _CategoryEditSheet(type: type, existing: existing),
);

class _CategoryEditSheet extends ConsumerStatefulWidget {
  const _CategoryEditSheet({required this.type, this.existing});

  final CategoryType type;
  final Category? existing;

  @override
  ConsumerState<_CategoryEditSheet> createState() => _CategoryEditSheetState();
}

class _CategoryEditSheetState extends ConsumerState<_CategoryEditSheet> {
  late final _name = TextEditingController(text: widget.existing?.name);
  late String _icon = widget.existing?.icon ?? CategoryIcons.all.keys.first;
  late PaletteColor _color = widget.existing?.color ?? PaletteColor.orange;
  String? _error;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _name.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final input = CategoryInput(
      name: _name.text,
      type: widget.type,
      icon: _icon,
      color: _color,
    );
    final actions = ref.read(categoryActionsProvider.notifier);
    setState(() => _saving = true);
    final existing = widget.existing;
    if (existing == null) {
      final result = await actions.create(input);
      if (!mounted) return;
      result.match(
        (failure) => setState(() {
          _saving = false;
          _error = failureMessage(l10n, failure);
        }),
        (created) => Navigator.pop(context, created),
      );
    } else {
      final failure = await actions.update(existing.id, input);
      if (!mounted) return;
      if (failure == null) {
        Navigator.pop(context);
      } else {
        setState(() {
          _saving = false;
          _error = failureMessage(l10n, failure);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final finance = FinanceColors.of(context);
    final canSave = _name.text.trim().isNotEmpty && !_saving;

    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Dimens.screenPadding,
          0,
          Dimens.screenPadding,
          Dimens.screenPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.existing == null
                  ? l10n.categories_new_title
                  : l10n.categories_edit_title,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: Dimens.space4),
            Row(
              children: [
                IconCircle(
                  icon: CategoryIcons.of(_icon),
                  color: finance.category(_color),
                  size: 48,
                ),
                const SizedBox(width: Dimens.space3),
                Expanded(
                  child: TextField(
                    key: const ValueKey('category-name'),
                    controller: _name,
                    autofocus: widget.existing == null,
                    maxLength: CategoryInput.maxNameLength,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: l10n.categories_name,
                      errorText: _error,
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space4),
            Text(l10n.categories_color, style: theme.textTheme.titleMedium),
            const SizedBox(height: Dimens.space2),
            Wrap(
              spacing: Dimens.space1,
              runSpacing: Dimens.space1,
              children: [
                for (final color in PaletteColor.values)
                  _Choice(
                    selected: color == _color,
                    label: paletteColorLabel(l10n, color),
                    onTap: () => setState(() => _color = color),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: finance.category(color),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space4),
            Text(l10n.categories_icon, style: theme.textTheme.titleMedium),
            const SizedBox(height: Dimens.space2),
            Wrap(
              spacing: Dimens.space1,
              runSpacing: Dimens.space1,
              children: [
                for (final MapEntry(key: key, value: icon)
                    in CategoryIcons.all.entries)
                  _Choice(
                    selected: key == _icon,
                    label: key.replaceAll('_', ' '),
                    onTap: () => setState(() => _icon = key),
                    child: Icon(
                      icon,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: Dimens.space6),
            SizedBox(
              height: Dimens.primaryButtonHeight,
              child: FilledButton(
                key: const ValueKey('category-save'),
                onPressed: canSave ? _save : null,
                child: Text(l10n.common_save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Choice extends StatelessWidget {
  const _Choice({
    required this.selected,
    required this.label,
    required this.onTap,
    required this.child,
  });

  final bool selected;
  final String label;
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      excludeSemantics: true,
      child: InkResponse(
        onTap: onTap,
        radius: 24,
        child: Container(
          width: Dimens.minTouchTarget,
          height: Dimens.minTouchTarget,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: selected ? primary : Colors.transparent,
              width: Dimens.selectedRingWidth,
            ),
          ),
          child: selected && child is CircleAvatar
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    child,
                    const Icon(
                      Symbols.check_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                )
              : child,
        ),
      ),
    );
  }
}

String paletteColorLabel(AppLocalizations l10n, PaletteColor color) =>
    switch (color) {
      PaletteColor.orange => l10n.color_orange,
      PaletteColor.blue => l10n.color_blue,
      PaletteColor.green => l10n.color_green,
      PaletteColor.purple => l10n.color_purple,
      PaletteColor.pink => l10n.color_pink,
      PaletteColor.teal => l10n.color_teal,
      PaletteColor.violet => l10n.color_violet,
      PaletteColor.amber => l10n.color_amber,
      PaletteColor.brown => l10n.color_brown,
      PaletteColor.emerald => l10n.color_emerald,
      PaletteColor.neutral => l10n.color_neutral,
    };

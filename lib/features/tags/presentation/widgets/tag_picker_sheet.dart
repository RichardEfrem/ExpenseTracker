import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/tags/domain/entities/tag.dart';
import 'package:expense_tracker/features/tags/presentation/providers/tags_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

/// `#trip-bali #food`: how tags read in chips and the detail sheet.
String tagsLabel(List<String> tags) => tags.map((t) => '#$t').join(' ');

/// Picks a transaction's tags: type a new one or tap a suggestion
/// (PRD US-15). Returns the chosen names, or null when dismissed.
Future<List<String>?> showTagPicker(
  BuildContext context, {
  required List<String> selected,
}) => showModalBottomSheet<List<String>>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  builder: (context) => _TagPicker(initial: selected),
);

class _TagPicker extends ConsumerStatefulWidget {
  const _TagPicker({required this.initial});

  final List<String> initial;

  @override
  ConsumerState<_TagPicker> createState() => _TagPickerState();
}

class _TagPickerState extends ConsumerState<_TagPicker> {
  late final _selected = [...widget.initial];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool get _full => _selected.length >= Tag.maxPerTransaction;

  void _add(String raw) {
    final name = Tag.normalize(raw);
    if (name != null &&
        name.length <= Tag.maxLength &&
        !_selected.contains(name) &&
        !_full) {
      setState(() => _selected.add(name));
    }
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final typed = Tag.normalize(_controller.text) ?? '';
    final suggestions = [
      for (final tag in ref.watch(tagsProvider).value ?? const <Tag>[])
        if (!_selected.contains(tag.name) && tag.name.contains(typed)) tag,
    ].take(12);

    return Padding(
      padding: EdgeInsets.fromLTRB(
        Dimens.screenPadding,
        0,
        Dimens.screenPadding,
        Dimens.screenPadding + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(l10n.tags_title, style: theme.textTheme.titleLarge),
            const SizedBox(height: Dimens.space3),
            TextField(
              key: const ValueKey('tag-field'),
              controller: _controller,
              autofocus: true,
              enabled: !_full,
              maxLength: Tag.maxLength,
              textInputAction: TextInputAction.done,
              onSubmitted: _add,
              decoration: InputDecoration(
                hintText: l10n.tags_hint,
                helperText: _full
                    ? l10n.tags_limit(Tag.maxPerTransaction)
                    : null,
                prefixText: '#',
                suffixIcon: typed.isEmpty
                    ? null
                    : IconButton(
                        key: const ValueKey('tag-add'),
                        tooltip: l10n.tags_add,
                        icon: const Icon(Symbols.add_rounded),
                        onPressed: () => _add(_controller.text),
                      ),
              ),
            ),
            if (_selected.isNotEmpty) ...[
              const SizedBox(height: Dimens.space2),
              Wrap(
                spacing: Dimens.space2,
                runSpacing: Dimens.space2,
                children: [
                  for (final name in _selected)
                    InputChip(
                      key: ValueKey('tag-selected-$name'),
                      label: Text('#$name'),
                      onDeleted: () => setState(() => _selected.remove(name)),
                      deleteButtonTooltipMessage: l10n.tags_remove(name),
                    ),
                ],
              ),
            ],
            if (suggestions.isNotEmpty && !_full) ...[
              const SizedBox(height: Dimens.space4),
              Text(
                l10n.tags_suggestions,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: Dimens.space2),
              Wrap(
                spacing: Dimens.space2,
                runSpacing: Dimens.space2,
                children: [
                  for (final tag in suggestions)
                    ActionChip(
                      key: ValueKey('tag-suggestion-${tag.name}'),
                      label: Text('#${tag.name}'),
                      onPressed: () => _add(tag.name),
                    ),
                ],
              ),
            ],
            const SizedBox(height: Dimens.space6),
            FilledButton(
              key: const ValueKey('tags-done'),
              onPressed: () {
                // A typed but not yet added tag counts.
                if (typed.isNotEmpty) _add(_controller.text);
                Navigator.pop(context, _selected);
              },
              child: Text(l10n.common_done),
            ),
          ],
        ),
      ),
    );
  }
}

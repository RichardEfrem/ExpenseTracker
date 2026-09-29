import 'package:expense_tracker/core/constants/dimens.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

typedef SelectOption<T> = ({T value, String label, Widget? leading});

/// A checklist sheet; returns the new selection, or null when dismissed.
Future<Set<T>?> showMultiSelectSheet<T>(
  BuildContext context, {
  required String title,
  required List<SelectOption<T>> options,
  required Set<T> selected,
}) => showModalBottomSheet<Set<T>>(
  context: context,
  isScrollControlled: true,
  useSafeArea: true,
  builder: (context) =>
      _MultiSelectSheet<T>(title: title, options: options, selected: selected),
);

class _MultiSelectSheet<T> extends StatefulWidget {
  const _MultiSelectSheet({
    required this.title,
    required this.options,
    required this.selected,
  });

  final String title;
  final List<SelectOption<T>> options;
  final Set<T> selected;

  @override
  State<_MultiSelectSheet<T>> createState() => _MultiSelectSheetState<T>();
}

class _MultiSelectSheetState<T> extends State<_MultiSelectSheet<T>> {
  late final _selected = {...widget.selected};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      builder: (context, controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.screenPadding,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                TextButton(
                  onPressed: () => setState(_selected.clear),
                  child: Text(l10n.filter_clear),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              controller: controller,
              children: [
                for (final option in widget.options)
                  CheckboxListTile(
                    value: _selected.contains(option.value),
                    secondary: option.leading,
                    title: Text(option.label),
                    onChanged: (checked) => setState(
                      () => checked ?? false
                          ? _selected.add(option.value)
                          : _selected.remove(option.value),
                    ),
                  ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(Dimens.screenPadding),
              child: SizedBox(
                width: double.infinity,
                height: Dimens.minTouchTarget,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context, _selected),
                  child: Text(l10n.filter_apply),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

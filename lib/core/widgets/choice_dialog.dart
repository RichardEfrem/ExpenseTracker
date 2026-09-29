import 'package:flutter/material.dart';

/// A radio list of [values] under [title]; the picked value, or null when
/// dismissed. Picking closes the dialog.
Future<T?> showChoiceDialog<T>(
  BuildContext context, {
  required String title,
  required List<T> values,
  required T current,
  required String Function(T) label,
}) => showDialog<T>(
  context: context,
  builder: (context) => SimpleDialog(
    title: Text(title),
    children: [
      RadioGroup<T>(
        groupValue: current,
        onChanged: (value) => Navigator.pop(context, value),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final value in values)
              RadioListTile<T>(value: value, title: Text(label(value))),
          ],
        ),
      ),
    ],
  ),
);

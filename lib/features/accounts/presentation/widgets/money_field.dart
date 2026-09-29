import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A rupiah text field that groups thousands as you type (`1.250.000`)
/// and allows a leading minus when [allowNegative].
class MoneyField extends StatelessWidget {
  const MoneyField({
    required this.controller,
    required this.label,
    this.allowNegative = false,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool allowNegative;

  /// The typed value; null when empty.
  static int? valueOf(TextEditingController controller) {
    final text = controller.text
        .replaceAll('.', '')
        .replaceAll(MoneyFormat.minus, '-');
    return int.tryParse(text);
  }

  static String initialText(int value) =>
      '${value < 0 ? MoneyFormat.minus : ''}${MoneyFormat.group(value)}';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(signed: allowNegative),
      inputFormatters: [_GroupingFormatter(allowNegative: allowNegative)],
      decoration: InputDecoration(
        labelText: label,
        prefixText: '${MoneyFormat.symbol} ',
      ),
    );
  }
}

class _GroupingFormatter extends TextInputFormatter {
  _GroupingFormatter({required this.allowNegative});

  final bool allowNegative;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final negative =
        allowNegative &&
        (newValue.text.startsWith('-') ||
            newValue.text.startsWith(MoneyFormat.minus));
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final trimmed = digits.length > 15 ? digits.substring(0, 15) : digits;
    final grouped = trimmed.isEmpty
        ? ''
        : MoneyFormat.group(int.parse(trimmed));
    final text = negative ? '${MoneyFormat.minus}$grouped' : grouped;
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}

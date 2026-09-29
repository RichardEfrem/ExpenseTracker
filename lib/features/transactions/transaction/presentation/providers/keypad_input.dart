import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/transactions/transaction/domain/usecases/evaluate_amount_expression.dart';

const _maxDigits = 15;

/// Applies one keypad press to the expression text: no leading zeros, no
/// operator first, a second operator replaces the first, `000` only after a
/// non-zero digit, at most 15 digits per number.
String applyKeypadKey(String expression, KeypadKey key) {
  final lastOperator = expression
      .split('')
      .lastIndexWhere(ExpressionOperator.all.contains);
  final current = expression.substring(lastOperator + 1);
  final endsWithOperator =
      expression.isNotEmpty && lastOperator == expression.length - 1;

  switch (key) {
    case KeypadKey.clear:
      return '';
    case KeypadKey.backspace:
      return expression.isEmpty
          ? expression
          : expression.substring(0, expression.length - 1);
    case KeypadKey.tripleZero:
      if (current.isEmpty || current == '0') return expression;
      if (current.length + 3 > _maxDigits) return expression;
      return '${expression}000';
    case KeypadKey.add ||
        KeypadKey.subtract ||
        KeypadKey.multiply ||
        KeypadKey.divide:
      if (expression.isEmpty) return expression;
      final op = switch (key) {
        KeypadKey.add => ExpressionOperator.add,
        KeypadKey.subtract => ExpressionOperator.subtract,
        KeypadKey.multiply => ExpressionOperator.multiply,
        _ => ExpressionOperator.divide,
      };
      return endsWithOperator
          ? '${expression.substring(0, expression.length - 1)}$op'
          : '$expression$op';
    default:
      final digit = key.digitValue!;
      if (current == '0') {
        return '${expression.substring(0, expression.length - 1)}$digit';
      }
      if (current.length >= _maxDigits) return expression;
      return '$expression$digit';
  }
}

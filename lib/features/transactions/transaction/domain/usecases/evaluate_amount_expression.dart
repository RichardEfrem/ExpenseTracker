import 'package:expense_tracker/features/transactions/transaction/domain/entities/transaction_input.dart';
import 'package:fpdart/fpdart.dart';

enum ExpressionError { empty, invalid, divideByZero, overflow }

/// Keypad operators, as typed and displayed.
abstract final class ExpressionOperator {
  static const add = '+';
  static const subtract = '−';
  static const multiply = '×';
  static const divide = '÷';
  static const all = {add, subtract, multiply, divide};
}

/// Evaluates keypad arithmetic such as `25000+12500×2` (PRD TX-05):
/// integers only, × and ÷ before + and −, ÷ rounds half up. A trailing
/// operator is ignored so the live result shows while typing.
class EvaluateAmountExpression {
  const EvaluateAmountExpression();

  static const _max = TransactionInput.maxAmount;

  /// Splits [expression] into numbers and operators; null if malformed.
  static List<String>? tokenize(String expression) {
    final tokens = <String>[];
    final number = StringBuffer();
    for (final char in expression.split('')) {
      if (ExpressionOperator.all.contains(char)) {
        if (number.isEmpty) return null;
        tokens
          ..add(number.toString())
          ..add(char);
        number.clear();
      } else if (RegExp(r'\d').hasMatch(char)) {
        number.write(char);
      } else if (char.trim().isNotEmpty) {
        return null;
      }
    }
    if (number.isNotEmpty) tokens.add(number.toString());
    return tokens;
  }

  /// True when [expression] contains an operator between two numbers.
  static bool hasOperator(String expression) {
    final tokens = tokenize(expression);
    return tokens != null &&
        tokens.length > 2 &&
        tokens.any(ExpressionOperator.all.contains);
  }

  Either<ExpressionError, int> call(String expression) {
    final tokens = tokenize(expression);
    if (tokens == null) return const Left(ExpressionError.invalid);
    if (tokens.isNotEmpty && ExpressionOperator.all.contains(tokens.last)) {
      tokens.removeLast();
    }
    if (tokens.isEmpty) return const Left(ExpressionError.empty);

    int? parse(String digits) => digits.length > 15 ? null : int.parse(digits);

    // Sum of terms; each term is a ×/÷ chain of non-negative numbers.
    var sum = 0;
    var sign = 1;
    int? term = parse(tokens.first);
    if (term == null) return const Left(ExpressionError.overflow);
    for (var i = 1; i < tokens.length; i += 2) {
      final op = tokens[i];
      final operand = parse(tokens[i + 1]);
      if (operand == null) return const Left(ExpressionError.overflow);
      switch (op) {
        case ExpressionOperator.multiply:
          if (operand != 0 && term! > _max ~/ operand) {
            return const Left(ExpressionError.overflow);
          }
          term = term! * operand;
        case ExpressionOperator.divide:
          if (operand == 0) return const Left(ExpressionError.divideByZero);
          term = (2 * term! + operand) ~/ (2 * operand);
        default:
          sum += sign * term!;
          if (sum.abs() > _max) return const Left(ExpressionError.overflow);
          sign = op == ExpressionOperator.add ? 1 : -1;
          term = operand;
      }
    }
    sum += sign * term!;
    if (sum.abs() > _max) return const Left(ExpressionError.overflow);
    return Right(sum);
  }
}

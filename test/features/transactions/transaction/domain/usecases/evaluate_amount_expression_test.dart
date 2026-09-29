import 'package:expense_tracker/features/transactions/transaction/domain/usecases/evaluate_amount_expression.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

const evaluate = EvaluateAmountExpression();
const minus = '−';

void main() {
  group('valid', () {
    for (final (expression, expected) in [
      ('45000', 45000),
      ('000', 0),
      ('25000+12500', 37500),
      ('10000${minus}2500', 7500),
      ('2+3×4', 14),
      ('20÷4+1', 6),
      ('10${minus}2×3', 4),
      ('100×3÷2', 150),
      ('10÷4', 3),
      ('10÷3', 3),
      ('5÷2', 3),
      ('7÷2÷2', 2),
      ('25000+', 25000),
      ('25000×', 25000),
      ('5${minus}10', -5),
      ('999999999999999', 999999999999999),
    ]) {
      test('$expression = $expected', () {
        expect(evaluate(expression), Right<ExpressionError, int>(expected));
      });
    }
  });

  group('invalid', () {
    for (final (expression, error) in [
      ('', ExpressionError.empty),
      ('+5', ExpressionError.invalid),
      ('5++5', ExpressionError.invalid),
      ('5a', ExpressionError.invalid),
      ('10÷0', ExpressionError.divideByZero),
      ('1000000000000000', ExpressionError.overflow),
      ('999999999999999+1', ExpressionError.overflow),
      ('99999999×99999999', ExpressionError.overflow),
    ]) {
      test('$expression → ${error.name}', () {
        expect(evaluate(expression), Left<ExpressionError, int>(error));
      });
    }
  });

  test('hasOperator only when an operator sits between numbers', () {
    expect(EvaluateAmountExpression.hasOperator('25000'), isFalse);
    expect(EvaluateAmountExpression.hasOperator('25000+'), isFalse);
    expect(EvaluateAmountExpression.hasOperator('25000+1'), isTrue);
  });
}

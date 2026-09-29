import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:expense_tracker/features/transactions/transaction/presentation/providers/keypad_input.dart';
import 'package:flutter_test/flutter_test.dart';

String type(List<KeypadKey> keys, [String start = '']) =>
    keys.fold(start, applyKeypadKey);

KeypadKey d(int n) => KeypadKey.digit(n);

void main() {
  test('digits append; a lone leading zero is replaced', () {
    expect(type([d(4), d(5), KeypadKey.tripleZero]), '45000');
    expect(type([d(0), d(7)]), '7');
  });

  test('000 needs a non-zero number before it', () {
    expect(type([KeypadKey.tripleZero]), '');
    expect(type([d(0), KeypadKey.tripleZero]), '0');
    expect(type([d(5), KeypadKey.add, KeypadKey.tripleZero]), '5+');
  });

  test('no leading operator; a second operator replaces the first', () {
    expect(type([KeypadKey.add]), '');
    expect(type([d(5), KeypadKey.add, KeypadKey.multiply]), '5×');
  });

  test('numbers are capped at 15 digits', () {
    final fifteen = List.filled(15, d(9));
    expect(type([...fifteen, d(9)]), '9' * 15);
    expect(type([...List.filled(13, d(9)), KeypadKey.tripleZero]), '9' * 13);
    expect(type([...fifteen, KeypadKey.add, d(1)]), '${'9' * 15}+1');
  });

  test('backspace and clear', () {
    expect(type([KeypadKey.backspace], '25+'), '25');
    expect(type([KeypadKey.backspace]), '');
    expect(type([KeypadKey.clear], '25+3'), '');
  });
}

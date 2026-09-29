import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/widgets/amount_keypad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Align(alignment: Alignment.bottomCenter, child: child),
  ),
);

void main() {
  testWidgets('each amount key emits its event', (tester) async {
    final keys = <KeypadKey>[];
    await tester.pumpWidget(_harness(AmountKeypad(onKey: keys.add)));

    final expected = KeypadKey.values.where((k) => k != KeypadKey.clear);
    for (final key in expected) {
      await tester.tap(find.byKey(ValueKey(key)));
    }
    expect(keys, expected.toList());
  });

  testWidgets('long-press backspace clears', (tester) async {
    final keys = <KeypadKey>[];
    await tester.pumpWidget(_harness(AmountKeypad(onKey: keys.add)));
    await tester.longPress(find.byKey(const ValueKey(KeypadKey.backspace)));
    expect(keys, [KeypadKey.clear]);
  });

  testWidgets('layout matches DESIGN §7.5', (tester) async {
    await tester.pumpWidget(_harness(AmountKeypad(onKey: (_) {})));
    Offset at(KeypadKey k) => tester.getCenter(find.byKey(ValueKey(k)));
    // Row 1: 7 8 9 ÷; last row: 000 0 ⌫ +.
    expect(at(KeypadKey.digit7).dy, at(KeypadKey.divide).dy);
    expect(at(KeypadKey.digit7).dy, lessThan(at(KeypadKey.digit1).dy));
    expect(at(KeypadKey.tripleZero).dy, at(KeypadKey.add).dy);
    expect(at(KeypadKey.tripleZero).dx, lessThan(at(KeypadKey.digit0).dx));
    expect(at(KeypadKey.backspace).dx, lessThan(at(KeypadKey.add).dx));
    expect(
      tester.getSize(find.byKey(const ValueKey(KeypadKey.digit5))).height,
      greaterThanOrEqualTo(56),
    );
  });

  testWidgets('PIN mode has digits and backspace only', (tester) async {
    await tester.pumpWidget(
      _harness(AmountKeypad(onKey: (_) {}, mode: KeypadMode.pin)),
    );
    for (final k in [KeypadKey.add, KeypadKey.divide, KeypadKey.tripleZero]) {
      expect(find.byKey(ValueKey(k)), findsNothing);
    }
    expect(find.byKey(const ValueKey(KeypadKey.digit0)), findsOneWidget);
    expect(find.byKey(const ValueKey(KeypadKey.backspace)), findsOneWidget);
  });

  testWidgets('non-digit keys have spoken labels', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(_harness(AmountKeypad(onKey: (_) {})));
    for (final label in [
      'Delete',
      'Plus',
      'Minus',
      'Times',
      'Divided by',
      'Triple zero',
    ]) {
      expect(find.bySemanticsLabel(label), findsOneWidget, reason: label);
    }
    handle.dispose();
  });

  test('KeypadKey helpers', () {
    expect(KeypadKey.digit(7), KeypadKey.digit7);
    expect(KeypadKey.digit7.digitValue, 7);
    expect(KeypadKey.tripleZero.digitValue, isNull);
    expect(KeypadKey.add.isOperator, isTrue);
    expect(KeypadKey.backspace.isOperator, isFalse);
  });
}

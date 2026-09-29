import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_colors.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/money_format.dart';
import 'package:expense_tracker/core/widgets/money_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _harness(Widget child, {ThemeData? theme}) => MaterialApp(
  theme: theme ?? AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(body: Center(child: child)),
);

Text _text(WidgetTester tester) => tester.widget<Text>(find.byType(Text));

void main() {
  testWidgets('expense: true minus, default text color, spoken label', (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _harness(const MoneyText(45000, kind: AmountKind.expense)),
    );
    final text = _text(tester);
    expect(text.data, '−Rp 45.000');
    expect(text.style!.color, AppPalette.light.onSurface);
    expect(find.bySemanticsLabel('minus 45 thousand rupiah'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('income: plus sign, income green', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _harness(const MoneyText(8500000, kind: AmountKind.income)),
    );
    expect(_text(tester).data, '+Rp 8.500.000');
    expect(_text(tester).style!.color, AppPalette.light.income);
    expect(
      find.bySemanticsLabel('plus 8 million 500 thousand rupiah'),
      findsOneWidget,
    );
    handle.dispose();
  });

  testWidgets('net: green when ≥ 0, red when < 0 (dark theme)', (tester) async {
    await tester.pumpWidget(
      _harness(
        const MoneyText(-310000, kind: AmountKind.net),
        theme: AppTheme.dark,
      ),
    );
    expect(_text(tester).data, '−Rp 310.000');
    expect(_text(tester).style!.color, AppPalette.dark.expense);

    await tester.pumpWidget(
      _harness(const MoneyText(0, kind: AmountKind.net), theme: AppTheme.dark),
    );
    expect(_text(tester).style!.color, AppPalette.dark.income);
  });

  testWidgets('transfer: no sign, transfer gray', (tester) async {
    await tester.pumpWidget(
      _harness(const MoneyText(500000, kind: AmountKind.transfer)),
    );
    expect(_text(tester).data, 'Rp 500.000');
    expect(_text(tester).style!.color, AppPalette.light.transfer);
  });

  testWidgets('uses tabular figures', (tester) async {
    await tester.pumpWidget(_harness(const MoneyText(1250000)));
    expect(
      _text(tester).style!.fontFeatures,
      contains(const FontFeature.tabularFigures()),
    );
  });

  testWidgets('compact shows K/M but reads the full amount', (tester) async {
    final handle = tester.ensureSemantics();
    await tester.pumpWidget(
      _harness(
        const MoneyText(12500000, kind: AmountKind.expense, compact: true),
      ),
    );
    expect(_text(tester).data, '−Rp 12,5M');
    expect(
      find.bySemanticsLabel('minus 12 million 500 thousand rupiah'),
      findsOneWidget,
    );
    handle.dispose();
  });

  testWidgets('hero shrinks to fit instead of wrapping', (tester) async {
    await tester.pumpWidget(
      _harness(
        const SizedBox(width: 120, child: MoneyText(123456789000, hero: true)),
      ),
    );
    expect(find.byType(FittedBox), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('count-up animates from the old value', (tester) async {
    Widget build(int amount) => _harness(MoneyText(amount, countUp: true));
    await tester.pumpWidget(build(1000));
    expect(_text(tester).data, 'Rp 1.000');

    await tester.pumpWidget(build(2000));
    await tester.pump(const Duration(milliseconds: 100));
    final mid = _text(tester).data;
    expect(mid, isNot('Rp 1.000'));
    expect(mid, isNot('Rp 2.000'));

    await tester.pumpAndSettle();
    expect(_text(tester).data, 'Rp 2.000');
  });

  testWidgets('count-up jumps when animations are disabled', (tester) async {
    Widget build(int amount) => MediaQuery(
      data: const MediaQueryData(disableAnimations: true),
      child: _harness(MoneyText(amount, countUp: true)),
    );
    await tester.pumpWidget(build(1000));
    await tester.pumpWidget(build(2000));
    await tester.pump();
    expect(_text(tester).data, 'Rp 2.000');
  });
}

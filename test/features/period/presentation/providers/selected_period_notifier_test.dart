import 'dart:async';

import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/period/presentation/providers/selected_period_notifier.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSettings extends SettingsNotifier {
  _FakeSettings(this.stream);

  final Stream<AppSettings> stream;

  @override
  Stream<AppSettings> build() => stream;
}

void main() {
  late StreamController<AppSettings> settings;
  late ProviderContainer container;

  setUp(() {
    settings = StreamController();
    container = ProviderContainer(
      overrides: [
        clockProvider.overrideWithValue(FixedClock(DateTime(2026, 9, 29, 10))),
        settingsProvider.overrideWith(() => _FakeSettings(settings.stream)),
      ],
    );
    addTearDown(container.dispose);
    container.listen(selectedPeriodProvider, (_, _) {});
  });

  Period period() => container.read(selectedPeriodProvider);
  SelectedPeriodNotifier notifier() =>
      container.read(selectedPeriodProvider.notifier);

  test('starts at the current calendar month', () {
    expect(period(), Period.monthContaining(LocalDate(2026, 9, 29)));
  });

  test('follows the month start day setting', () async {
    settings.add(const AppSettings(monthStartDay: 25));
    await Future<void>.delayed(Duration.zero);
    expect(period().start, LocalDate(2026, 9, 25));
    expect(period().end, LocalDate(2026, 10, 24));
  });

  test('steps back, cannot step into the future, resets', () {
    notifier().previous();
    expect(period().start, LocalDate(2026, 8, 1));
    notifier().next();
    expect(period().start, LocalDate(2026, 9, 1));
    expect(notifier().canGoNext, isFalse);
    notifier().next();
    expect(period().start, LocalDate(2026, 9, 1));
    notifier()
      ..previous()
      ..previous()
      ..reset();
    expect(period().start, LocalDate(2026, 9, 1));
  });

  test(
    'switching kind keeps the shown date, and survives a settings change',
    () async {
      notifier().setKind(PeriodKind.week);
      expect(period().kind, PeriodKind.week);
      expect(period().start, LocalDate(2026, 9, 28));
      settings.add(const AppSettings(weekStart: DateTime.sunday));
      await Future<void>.delayed(Duration.zero);
      expect(period().kind, PeriodKind.week);
      expect(period().start, LocalDate(2026, 9, 27));
    },
  );

  test('month and year pickers', () {
    notifier().setMonth(2026, 2);
    expect(period(), Period.monthContaining(LocalDate(2026, 2, 1)));
    notifier().setYear(2025);
    expect(
      (period().start, period().end),
      (LocalDate(2025, 1, 1), LocalDate(2025, 12, 31)),
    );
  });
}

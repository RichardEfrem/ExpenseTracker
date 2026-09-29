import 'dart:async';

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/settings/data/settings_providers.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:expense_tracker/features/settings/domain/usecases/update_month_start_day.dart';
import 'package:expense_tracker/features/settings/domain/usecases/update_theme_mode.dart';
import 'package:expense_tracker/features/settings/domain/usecases/watch_settings.dart';
import 'package:expense_tracker/features/settings/presentation/providers/settings_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockWatch extends Mock implements WatchSettings {}

class _MockUpdateTheme extends Mock implements UpdateThemeMode {}

class _MockUpdateMonthStart extends Mock implements UpdateMonthStartDay {}

void main() {
  late StreamController<Either<Failure, AppSettings>> settings;
  late _MockUpdateTheme updateTheme;
  late _MockUpdateMonthStart updateMonthStart;
  late ProviderContainer container;

  setUpAll(() => registerFallbackValue(AppThemeMode.system));

  setUp(() {
    settings = StreamController.broadcast();
    final watch = _MockWatch();
    when(watch.call).thenAnswer((_) => settings.stream);
    updateTheme = _MockUpdateTheme();
    updateMonthStart = _MockUpdateMonthStart();
    container = ProviderContainer(
      overrides: [
        watchSettingsProvider.overrideWithValue(watch),
        updateThemeModeProvider.overrideWithValue(updateTheme),
        updateMonthStartDayProvider.overrideWithValue(updateMonthStart),
      ],
    );
    addTearDown(container.dispose);
  });

  test('exposes settings from the use case stream', () async {
    final sub = container.listen(settingsProvider, (_, _) {});
    expect(container.read(settingsProvider), isA<AsyncLoading<AppSettings>>());
    settings.add(const Right(AppSettings(monthStartDay: 25)));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(settingsProvider).value?.monthStartDay, 25);
    sub.close();
  });

  test('a failure becomes AsyncError carrying the Failure', () async {
    final sub = container.listen(settingsProvider, (_, _) {});
    settings.add(const Left(Failure.database()));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(settingsProvider).error, const Failure.database());
    sub.close();
  });

  test('theme mode follows settings, defaulting while loading', () async {
    final sub = container.listen(appThemeModeProvider, (_, _) {});
    expect(container.read(appThemeModeProvider), AppThemeMode.system);
    settings.add(const Right(AppSettings(themeMode: AppThemeMode.dark)));
    await Future<void>.delayed(Duration.zero);
    expect(container.read(appThemeModeProvider), AppThemeMode.dark);
    sub.close();
  });

  test('setters call the use case and return its failure', () async {
    when(() => updateTheme(any())).thenAnswer((_) async => const Right(unit));
    when(() => updateMonthStart(any())).thenAnswer(
      (_) async => const Left(
        Failure.validation(ValidationReason.monthStartDayOutOfRange),
      ),
    );
    final notifier = container.read(settingsProvider.notifier);
    expect(await notifier.setThemeMode(AppThemeMode.light), isNull);
    verify(() => updateTheme(AppThemeMode.light)).called(1);
    expect(
      await notifier.setMonthStartDay(40),
      const Failure.validation(ValidationReason.monthStartDayOutOfRange),
    );
  });
}

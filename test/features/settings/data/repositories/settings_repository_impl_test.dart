import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:expense_tracker/features/settings/data/models/app_settings_model.dart';
import 'package:expense_tracker/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppDatabase db;
  late SettingsRepositoryImpl repo;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    repo = SettingsRepositoryImpl(SettingsLocalDataSource(db));
  });
  tearDown(() => db.close());

  Future<AppSettings> current() async =>
      (await repo.watch().first).getOrElse((f) => fail('$f'));

  test('defaults on a fresh install', () async {
    expect(await current(), const AppSettings());
  });

  test('writes persist and survive reopening the repository', () async {
    await repo.setThemeMode(AppThemeMode.dark);
    await repo.setMonthStartDay(25);
    await repo.setWeekStart(DateTime.sunday);
    await repo.setLastBackupAt(DateTime.utc(2026, 9, 28, 21, 4));

    final reopened = SettingsRepositoryImpl(SettingsLocalDataSource(db));
    final settings = (await reopened.watch().first).getOrElse(
      (f) => fail('$f'),
    );
    expect(settings.themeMode, AppThemeMode.dark);
    expect(settings.monthStartDay, 25);
    expect(settings.weekStart, DateTime.sunday);
    expect(settings.lastBackupAt, DateTime.utc(2026, 9, 28, 21, 4));
  });

  test('watch emits on change', () async {
    final emitted = repo.watch().map((e) => e.toNullable()!.monthStartDay);
    final expectation = expectLater(emitted, emitsInOrder([1, 25]));
    await Future<void>.delayed(Duration.zero);
    await repo.setMonthStartDay(25);
    await expectation;
  });

  test('malformed rows fall back to defaults', () {
    expect(
      appSettingsFromRows({
        SettingsKeys.themeMode: 'purple',
        SettingsKeys.monthStartDay: '45',
        SettingsKeys.weekStart: 'x',
      }),
      const AppSettings(),
    );
  });
}

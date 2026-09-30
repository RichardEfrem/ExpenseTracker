import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_settings_repository.dart';
import 'package:expense_tracker/features/backup/backup/domain/usecases/backup_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class _MockSettings extends Mock implements BackupSettingsRepository {}

void main() {
  late _MockSettings settings;

  setUpAll(() => registerFallbackValue(DateTime(2000)));

  setUp(() {
    settings = _MockSettings();
    when(
      () => settings.setPassword(any()),
    ).thenAnswer((_) async => const Right(unit));
    when(
      () => settings.snoozeReminderUntil(any()),
    ).thenAnswer((_) async => const Right(unit));
  });

  group('SetBackupPassword', () {
    test('rejects fewer than 8 characters', () async {
      expect(
        await SetBackupPassword(settings)('1234567'),
        const Left<Failure, Unit>(
          Failure.validation(ValidationReason.passwordTooShort),
        ),
      );
      verifyNever(() => settings.setPassword(any()));
    });

    test('accepts 8 characters', () async {
      expect((await SetBackupPassword(settings)('12345678')).isRight(), isTrue);
      verify(() => settings.setPassword('12345678')).called(1);
    });

    test('null turns encryption off', () async {
      await SetBackupPassword(settings)(null);
      verify(() => settings.setPassword(null)).called(1);
    });
  });

  test('GetBackupEncryption: on when a password is stored', () async {
    when(settings.readPassword).thenAnswer((_) async => const Right('x'));
    expect(
      await GetBackupEncryption(settings)(),
      const Right<Failure, bool>(true),
    );
    when(settings.readPassword).thenAnswer((_) async => const Right(null));
    expect(
      await GetBackupEncryption(settings)(),
      const Right<Failure, bool>(false),
    );
  });

  test('snooze hides the reminder for 7 days from now', () async {
    final now = DateTime(2026, 9, 30, 21);
    await SnoozeBackupReminder(settings, FixedClock(now))();
    verify(
      () => settings.snoozeReminderUntil(DateTime(2026, 10, 7, 21)),
    ).called(1);
  });
}

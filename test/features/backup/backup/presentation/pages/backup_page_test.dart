import 'dart:async';

import 'package:drift/native.dart';
import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/database/seed.dart';
import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/theme/app_theme.dart';
import 'package:expense_tracker/core/utils/app_info_provider.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/backup/backup/data/backup_providers.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_cipher.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_folder_datasource.dart';
import 'package:expense_tracker/features/backup/backup/presentation/pages/backup_page.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_secret_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drift work is scheduled on the widget test's fake clock, so awaiting it
/// directly never completes: pump until [future] is done instead.
Future<T> pumpUntilDone<T>(WidgetTester tester, Future<T> future) async {
  late T result;
  Object? error;
  var done = false;
  unawaited(
    future.then(
      (value) {
        result = value;
        done = true;
      },
      onError: (Object e) {
        error = e;
        done = true;
      },
    ),
  );
  for (var i = 0; i < 100 && !done; i++) {
    await tester.pump(const Duration(milliseconds: 10));
  }
  if (error != null) throw error!;
  if (!done) fail('future did not complete');
  return result;
}

/// Lets queued drift writes and stream re-queries run, then settles frames.
Future<void> settle(WidgetTester tester) async {
  for (var i = 0; i < 5; i++) {
    await tester.pump(const Duration(milliseconds: 20));
  }
  await tester.pumpAndSettle();
}

/// Stands in for the share sheet and file picker.
class _FakeFiles implements BackupFileDataSource {
  String? lastExport;
  String? toPick;

  @override
  Future<bool> share(
    String contents,
    String fileName, {
    String mimeType = BackupFileDataSource.jsonMimeType,
  }) async {
    lastExport = contents;
    return true;
  }

  @override
  Future<bool> save(
    String contents,
    String fileName, {
    String mimeType = BackupFileDataSource.jsonMimeType,
  }) => share(contents, fileName);

  @override
  Future<String?> pick() async => toPick;
}

/// Keeps the backup password in memory instead of the Keystore.
class _FakeSecrets implements BackupSecretDataSource {
  String? password;

  @override
  Future<String?> readPassword() async => password;

  @override
  Future<void> writePassword(String? value) async => password = value;
}

/// Stands in for the Storage Access Framework folder picker.
class _FakeFolders implements BackupFolderDataSource {
  final written = <String, String>{};

  @override
  Future<({String name, String uri})?> pick() async =>
      (uri: 'content://tree/backups', name: 'Backups');

  @override
  Future<void> write(String uri, String fileName, String contents) async =>
      written[fileName] = contents;

  @override
  Future<void> release(String uri) async {}
}

void main() {
  late AppDatabase db;
  late _FakeFiles files;
  late _FakeSecrets secrets;
  late _FakeFolders folders;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    files = _FakeFiles();
    secrets = _FakeSecrets();
    folders = _FakeFolders();
  });

  Future<void> pumpPage(WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appDatabaseProvider.overrideWithValue(db),
          backupFileDataSourceProvider.overrideWithValue(files),
          backupSecretDataSourceProvider.overrideWithValue(secrets),
          backupFolderDataSourceProvider.overrideWithValue(folders),
          // Few rounds, no isolate: isolates can't finish under fake time.
          backupCipherProvider.overrideWithValue(
            const BackupCipher(iterations: 1000, inBackground: false),
          ),
          appVersionProvider.overrideWith((ref) async => '1.0.0 (1)'),
          clockProvider.overrideWithValue(
            FixedClock(DateTime(2026, 9, 29, 21, 4)),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const BackupPage(),
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    await pumpUntilDone(tester, db.close());
  }

  Future<int> transactionCount(WidgetTester tester) async =>
      (await pumpUntilDone(tester, db.select(db.transactions).get())).length;

  testWidgets('export, then restore it with Replace all', (tester) async {
    await pumpUntilDone(
      tester,
      seedRandomTransactions(db, count: 12, end: LocalDate(2026, 9, 29)),
    );
    await pumpPage(tester);
    expect(find.textContaining('No backup yet'), findsOneWidget);

    await tester.tap(find.byKey(const ValueKey('export')));
    await settle(tester);
    expect(files.lastExport, isNotNull);
    expect(find.text('Last backup: today (29 Sep, 21:04)'), findsOneWidget);

    // Lose some data, then restore.
    await pumpUntilDone(tester, db.delete(db.transactions).go());
    files.toPick = files.lastExport;
    await tester.tap(find.byKey(const ValueKey('restore')));
    await settle(tester);
    expect(
      find.textContaining('12 transactions · 1 account · 14 categories'),
      findsOneWidget,
    );
    await tester.tap(find.byKey(const ValueKey('restore-replace')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('restore-replace-confirm')));
    await settle(tester);
    expect(find.text('Backup restored'), findsOneWidget);
    expect(await transactionCount(tester), 12);
    await dispose(tester);
  });

  testWidgets('a corrupt file shows an error and changes nothing', (
    tester,
  ) async {
    await pumpPage(tester);
    files.toPick = 'not a backup';
    await tester.tap(find.byKey(const ValueKey('restore')));
    await settle(tester);
    expect(find.text("This file isn't a valid backup."), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('erase needs two confirmations', (tester) async {
    await pumpUntilDone(
      tester,
      seedRandomTransactions(db, count: 5, end: LocalDate(2026, 9, 29)),
    );
    await pumpPage(tester);
    await tester.scrollUntilVisible(find.byKey(const ValueKey('erase')), 200);
    await tester.ensureVisible(find.byKey(const ValueKey('erase')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('erase')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('erase-1')));
    await settle(tester);
    expect(await transactionCount(tester), 5, reason: 'not yet');
    await tester.tap(find.byKey(const ValueKey('erase-2')));
    await settle(tester);
    expect(await transactionCount(tester), 0);
    expect(find.text('All data erased'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('encrypted backup: export, then restore with the password', (
    tester,
  ) async {
    await pumpUntilDone(
      tester,
      seedRandomTransactions(db, count: 3, end: LocalDate(2026, 9, 29)),
    );
    await pumpPage(tester);

    // Turn encryption on: the password must be entered twice.
    await tester.tap(find.byKey(const ValueKey('encrypt')));
    await settle(tester);
    await tester.enterText(
      find.byKey(const ValueKey('backup-password')),
      'pass',
    );
    await tester.tap(find.byKey(const ValueKey('backup-password-ok')));
    await settle(tester);
    expect(find.text('Use at least 8 characters.'), findsOneWidget);
    await tester.enterText(
      find.byKey(const ValueKey('backup-password')),
      'pass1234',
    );
    await tester.enterText(
      find.byKey(const ValueKey('backup-password-again')),
      'pass1234',
    );
    await tester.tap(find.byKey(const ValueKey('backup-password-ok')));
    await settle(tester);
    expect(secrets.password, 'pass1234');

    await tester.tap(find.byKey(const ValueKey('export')));
    await settle(tester);
    expect(files.lastExport, contains('expense_tracker_backup_encrypted'));
    expect(files.lastExport, isNot(contains('Cash')));

    // Restore: a wrong password asks again, the right one opens it.
    files.toPick = files.lastExport;
    await tester.tap(find.byKey(const ValueKey('restore')));
    await settle(tester);
    await tester.enterText(
      find.byKey(const ValueKey('backup-password')),
      'wrong pass',
    );
    await tester.tap(find.byKey(const ValueKey('backup-password-ok')));
    await settle(tester);
    expect(
      find.text(
        'Wrong password, or the file was changed after it was exported.',
      ),
      findsOneWidget,
    );
    await tester.enterText(
      find.byKey(const ValueKey('backup-password')),
      'pass1234',
    );
    await tester.tap(find.byKey(const ValueKey('backup-password-ok')));
    await settle(tester);
    expect(find.textContaining('3 transactions'), findsOneWidget);
    await tester.tap(find.byKey(const ValueKey('restore-merge')));
    await settle(tester);
    expect(find.text('Backup restored'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('choosing a folder writes the first auto-backup at once', (
    tester,
  ) async {
    await pumpPage(tester);
    await tester.tap(find.byKey(const ValueKey('auto-backup')));
    await settle(tester);
    expect(folders.written.keys, ['expense-tracker-backup-2026-09-29.json']);
    expect(find.text('To Backups · last 29 Sep'), findsOneWidget);
    expect(find.text('Last backup: today (29 Sep, 21:04)'), findsOneWidget);
    await dispose(tester);
  });

  testWidgets('the reminder can be turned off', (tester) async {
    await pumpPage(tester);
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('reminder')),
      200,
    );
    await tester.ensureVisible(find.byKey(const ValueKey('reminder')));
    await settle(tester);
    await tester.tap(find.byKey(const ValueKey('reminder')));
    await settle(tester);
    final rows = await pumpUntilDone(tester, db.select(db.settings).get());
    expect(rows.where((r) => r.key == 'backup_reminder').single.value, 'false');
    await dispose(tester);
  });
}

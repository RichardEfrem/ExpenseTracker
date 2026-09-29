import 'dart:convert';

import 'package:expense_tracker/core/database/app_database.dart';
import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/clock.dart';
import 'package:expense_tracker/features/accounts/accounts_data.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_file_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/datasources/backup_local_datasource.dart';
import 'package:expense_tracker/features/backup/backup/data/models/backup_dto.dart';
import 'package:expense_tracker/features/backup/backup/domain/entities/backup_file.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/settings/settings_data.dart';
import 'package:expense_tracker/features/transactions/transactions_data.dart';
import 'package:fpdart/fpdart.dart';

class BackupRepositoryImpl implements BackupRepository {
  const BackupRepositoryImpl(this._local, this._files, this._clock);

  final BackupLocalDataSource _local;
  final BackupFileDataSource _files;
  final Clock _clock;

  static Never _corrupt([Object? detail]) => throw FailureException(
    Failure.backup(BackupProblem.corruptFile, detail?.toString()),
  );

  @override
  Future<Either<Failure, BackupFile>> snapshot({required String appVersion}) =>
      guard(() async {
        final rows = await _local.readAll();
        return BackupFile(
          schemaVersion: BackupFile.currentSchemaVersion,
          appVersion: appVersion,
          exportedAt: _clock.now().toUtc(),
          accounts: [for (final r in rows.accounts) r.toEntity()],
          categories: [for (final r in rows.categories) r.toEntity()],
          transactions: [for (final r in rows.transactions) r.toEntity()],
          settings: {for (final r in rows.settings) r.key: r.value},
        );
      });

  @override
  Either<Failure, String> encode(BackupFile file) => guardSync(
    () => jsonEncode(
      BackupFileDto(
        schemaVersion: file.schemaVersion,
        appVersion: file.appVersion,
        exportedAt: file.exportedAt.toUtc().toIso8601String(),
        accounts: [for (final a in file.accounts) AccountDto.fromEntity(a)],
        categories: [
          for (final c in file.categories) CategoryDto.fromEntity(c),
        ],
        transactions: [
          for (final t in file.transactions) TransactionDto.fromEntity(t),
        ],
        settings: file.settings,
      ).toJson(),
    ),
  );

  @override
  Either<Failure, BackupFile> decode(String contents) => guardSync(() {
    if (contents.trim().isEmpty) {
      throw const FailureException(Failure.backup(BackupProblem.emptyFile));
    }
    final Object? json;
    try {
      json = jsonDecode(contents);
    } on FormatException catch (e) {
      _corrupt(e);
    }
    if (json is! Map<String, dynamic> || json['format'] != backupFormat) {
      _corrupt('not a backup');
    }
    final version = json['schema_version'];
    if (version is! int) _corrupt('schema_version');
    if (version > BackupFile.currentSchemaVersion) {
      throw FailureException(
        Failure.backup(BackupProblem.unsupportedVersion, '$version'),
      );
    }
    try {
      final dto = BackupFileDto.fromJson(json);
      _checkReferences(dto);
      return BackupFile(
        schemaVersion: dto.schemaVersion,
        appVersion: dto.appVersion,
        exportedAt: DateTime.parse(dto.exportedAt).toUtc(),
        accounts: [for (final a in dto.accounts) a.toRow().toEntity()],
        categories: [for (final c in dto.categories) c.toRow().toEntity()],
        transactions: [for (final t in dto.transactions) t.toRow().toEntity()],
        settings: dto.settings,
      );
    } on FailureException {
      rethrow;
    } catch (e) {
      // Missing fields, wrong types, bad dates or unknown enum values.
      _corrupt(e);
    }
  });

  /// Every transaction must point at accounts and categories in the file.
  static void _checkReferences(BackupFileDto dto) {
    final accounts = {for (final a in dto.accounts) a.id};
    final categories = {for (final c in dto.categories) c.id};
    for (final t in dto.transactions) {
      final ok =
          accounts.contains(t.accountId) &&
          (t.toAccountId == null || accounts.contains(t.toAccountId)) &&
          (t.categoryId == null || categories.contains(t.categoryId));
      if (!ok) _corrupt('transaction ${t.id} references a missing row');
    }
  }

  @override
  Future<Either<Failure, Unit>> restore(BackupFile file, RestoreMode mode) =>
      guard(() async {
        final all = (
          accounts: [
            for (final a in file.accounts) AccountDto.fromEntity(a).toRow(),
          ],
          categories: [
            for (final c in file.categories) CategoryDto.fromEntity(c).toRow(),
          ],
          transactions: [
            for (final t in file.transactions)
              TransactionDto.fromEntity(t).toRow(),
          ],
          settings: [
            for (final MapEntry(:key, :value) in file.settings.entries)
              SettingRow(key: key, value: value),
          ],
        );
        await switch (mode) {
          RestoreMode.replace => _local.replaceAll(all),
          RestoreMode.merge => _local.mergeAll(all),
        };
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> eraseAll() => guard(() async {
    await _local.eraseAll();
    return unit;
  });

  @override
  Future<Either<Failure, bool>> deliver(
    String contents,
    String fileName,
    ExportTarget target,
  ) => guard(
    () => switch (target) {
      ExportTarget.share => _files.share(contents, fileName),
      ExportTarget.saveToDevice => _files.save(contents, fileName),
    },
  );

  @override
  Future<Either<Failure, String?>> pickFile() => guard(_files.pick);

  @override
  Future<Either<Failure, Unit>> recordBackup(DateTime at) => guard(() async {
    await _local.putSetting(
      SettingsKeys.lastBackupAt,
      '${at.toUtc().millisecondsSinceEpoch}',
    );
    return unit;
  });
}

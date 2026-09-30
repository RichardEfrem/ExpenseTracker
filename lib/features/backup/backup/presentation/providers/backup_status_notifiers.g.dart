// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_status_notifiers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Last backup, reminder and auto-backup state; updates itself.

@ProviderFor(BackupStatusNotifier)
final backupStatusProvider = BackupStatusNotifierProvider._();

/// Last backup, reminder and auto-backup state; updates itself.
final class BackupStatusNotifierProvider
    extends $StreamNotifierProvider<BackupStatusNotifier, BackupStatus> {
  /// Last backup, reminder and auto-backup state; updates itself.
  BackupStatusNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupStatusNotifierHash();

  @$internal
  @override
  BackupStatusNotifier create() => BackupStatusNotifier();
}

String _$backupStatusNotifierHash() =>
    r'4b7dba5d592b737980a36db838a05df7d328b404';

/// Last backup, reminder and auto-backup state; updates itself.

abstract class _$BackupStatusNotifier extends $StreamNotifier<BackupStatus> {
  Stream<BackupStatus> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BackupStatus>, BackupStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<BackupStatus>, BackupStatus>,
              AsyncValue<BackupStatus>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Whether new backups are encrypted with a password (PRD BAK-03).

@ProviderFor(BackupEncryption)
final backupEncryptionProvider = BackupEncryptionProvider._();

/// Whether new backups are encrypted with a password (PRD BAK-03).
final class BackupEncryptionProvider
    extends $AsyncNotifierProvider<BackupEncryption, bool> {
  /// Whether new backups are encrypted with a password (PRD BAK-03).
  BackupEncryptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupEncryptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupEncryptionHash();

  @$internal
  @override
  BackupEncryption create() => BackupEncryption();
}

String _$backupEncryptionHash() => r'31112821fedb25cd6e264f7ebb4b119b2cf8f715';

/// Whether new backups are encrypted with a password (PRD BAK-03).

abstract class _$BackupEncryption extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Writes the weekly auto-backup when due (PRD BAK-05). Runs when the app
/// first listens (app open) and again on [run] (resume, or a new folder).

@ProviderFor(AutoBackupRunner)
final autoBackupRunnerProvider = AutoBackupRunnerProvider._();

/// Writes the weekly auto-backup when due (PRD BAK-05). Runs when the app
/// first listens (app open) and again on [run] (resume, or a new folder).
final class AutoBackupRunnerProvider
    extends $AsyncNotifierProvider<AutoBackupRunner, AutoBackupOutcome> {
  /// Writes the weekly auto-backup when due (PRD BAK-05). Runs when the app
  /// first listens (app open) and again on [run] (resume, or a new folder).
  AutoBackupRunnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'autoBackupRunnerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$autoBackupRunnerHash();

  @$internal
  @override
  AutoBackupRunner create() => AutoBackupRunner();
}

String _$autoBackupRunnerHash() => r'f6f44f012e2eb8d83ff43e1e6fdb86c2da2c8edd';

/// Writes the weekly auto-backup when due (PRD BAK-05). Runs when the app
/// first listens (app open) and again on [run] (resume, or a new folder).

abstract class _$AutoBackupRunner extends $AsyncNotifier<AutoBackupOutcome> {
  FutureOr<AutoBackupOutcome> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AutoBackupOutcome>, AutoBackupOutcome>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AutoBackupOutcome>, AutoBackupOutcome>,
              AsyncValue<AutoBackupOutcome>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

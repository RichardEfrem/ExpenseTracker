// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(backupLocalDataSource)
final backupLocalDataSourceProvider = BackupLocalDataSourceProvider._();

final class BackupLocalDataSourceProvider
    extends
        $FunctionalProvider<
          BackupLocalDataSource,
          BackupLocalDataSource,
          BackupLocalDataSource
        >
    with $Provider<BackupLocalDataSource> {
  BackupLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<BackupLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupLocalDataSource create(Ref ref) {
    return backupLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupLocalDataSource>(value),
    );
  }
}

String _$backupLocalDataSourceHash() =>
    r'7d259c85dc15a09574947cda7a718365948e52eb';

@ProviderFor(backupFileDataSource)
final backupFileDataSourceProvider = BackupFileDataSourceProvider._();

final class BackupFileDataSourceProvider
    extends
        $FunctionalProvider<
          BackupFileDataSource,
          BackupFileDataSource,
          BackupFileDataSource
        >
    with $Provider<BackupFileDataSource> {
  BackupFileDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupFileDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupFileDataSourceHash();

  @$internal
  @override
  $ProviderElement<BackupFileDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupFileDataSource create(Ref ref) {
    return backupFileDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupFileDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupFileDataSource>(value),
    );
  }
}

String _$backupFileDataSourceHash() =>
    r'd2c3f2e5c3058f6a88bbbc036634aae7bfe5851f';

@ProviderFor(backupFolderDataSource)
final backupFolderDataSourceProvider = BackupFolderDataSourceProvider._();

final class BackupFolderDataSourceProvider
    extends
        $FunctionalProvider<
          BackupFolderDataSource,
          BackupFolderDataSource,
          BackupFolderDataSource
        >
    with $Provider<BackupFolderDataSource> {
  BackupFolderDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupFolderDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupFolderDataSourceHash();

  @$internal
  @override
  $ProviderElement<BackupFolderDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupFolderDataSource create(Ref ref) {
    return backupFolderDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupFolderDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupFolderDataSource>(value),
    );
  }
}

String _$backupFolderDataSourceHash() =>
    r'f876f9d870b4aa0efefa2d4e4df96811ac269c9d';

@ProviderFor(backupSecretDataSource)
final backupSecretDataSourceProvider = BackupSecretDataSourceProvider._();

final class BackupSecretDataSourceProvider
    extends
        $FunctionalProvider<
          BackupSecretDataSource,
          BackupSecretDataSource,
          BackupSecretDataSource
        >
    with $Provider<BackupSecretDataSource> {
  BackupSecretDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupSecretDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupSecretDataSourceHash();

  @$internal
  @override
  $ProviderElement<BackupSecretDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupSecretDataSource create(Ref ref) {
    return backupSecretDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupSecretDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupSecretDataSource>(value),
    );
  }
}

String _$backupSecretDataSourceHash() =>
    r'12f77f6c3ffa785cc2dae63702219f30002fde33';

@ProviderFor(backupCipher)
final backupCipherProvider = BackupCipherProvider._();

final class BackupCipherProvider
    extends $FunctionalProvider<BackupCipher, BackupCipher, BackupCipher>
    with $Provider<BackupCipher> {
  BackupCipherProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupCipherProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupCipherHash();

  @$internal
  @override
  $ProviderElement<BackupCipher> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupCipher create(Ref ref) {
    return backupCipher(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupCipher value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupCipher>(value),
    );
  }
}

String _$backupCipherHash() => r'261e2b68128cd1c434840b4ca7d69a85cde64319';

@ProviderFor(backupRepository)
final backupRepositoryProvider = BackupRepositoryProvider._();

final class BackupRepositoryProvider
    extends
        $FunctionalProvider<
          BackupRepository,
          BackupRepository,
          BackupRepository
        >
    with $Provider<BackupRepository> {
  BackupRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupRepositoryHash();

  @$internal
  @override
  $ProviderElement<BackupRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BackupRepository create(Ref ref) {
    return backupRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupRepository>(value),
    );
  }
}

String _$backupRepositoryHash() => r'3552315fad778ecadf9586d3247d3dd60d4fc2fd';

@ProviderFor(backupSettingsRepository)
final backupSettingsRepositoryProvider = BackupSettingsRepositoryProvider._();

final class BackupSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          BackupSettingsRepository,
          BackupSettingsRepository,
          BackupSettingsRepository
        >
    with $Provider<BackupSettingsRepository> {
  BackupSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupSettingsRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<BackupSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  BackupSettingsRepository create(Ref ref) {
    return backupSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BackupSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BackupSettingsRepository>(value),
    );
  }
}

String _$backupSettingsRepositoryHash() =>
    r'e0335811e2464d1f84c2f591e864bc97150cafcb';

@ProviderFor(encodeBackup)
final encodeBackupProvider = EncodeBackupProvider._();

final class EncodeBackupProvider
    extends $FunctionalProvider<EncodeBackup, EncodeBackup, EncodeBackup>
    with $Provider<EncodeBackup> {
  EncodeBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'encodeBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$encodeBackupHash();

  @$internal
  @override
  $ProviderElement<EncodeBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EncodeBackup create(Ref ref) {
    return encodeBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EncodeBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EncodeBackup>(value),
    );
  }
}

String _$encodeBackupHash() => r'fa78a69b21bb31d96aec7ef519461449d33c296d';

@ProviderFor(exportBackup)
final exportBackupProvider = ExportBackupProvider._();

final class ExportBackupProvider
    extends $FunctionalProvider<ExportBackup, ExportBackup, ExportBackup>
    with $Provider<ExportBackup> {
  ExportBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportBackupHash();

  @$internal
  @override
  $ProviderElement<ExportBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExportBackup create(Ref ref) {
    return exportBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportBackup>(value),
    );
  }
}

String _$exportBackupHash() => r'a06c81a535a038cbe039574fa0582e163e71da66';

@ProviderFor(previewBackup)
final previewBackupProvider = PreviewBackupProvider._();

final class PreviewBackupProvider
    extends $FunctionalProvider<PreviewBackup, PreviewBackup, PreviewBackup>
    with $Provider<PreviewBackup> {
  PreviewBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'previewBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$previewBackupHash();

  @$internal
  @override
  $ProviderElement<PreviewBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PreviewBackup create(Ref ref) {
    return previewBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PreviewBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PreviewBackup>(value),
    );
  }
}

String _$previewBackupHash() => r'e9728541904ed2fc9678b801e44f3fb52eb11d09';

@ProviderFor(unlockBackup)
final unlockBackupProvider = UnlockBackupProvider._();

final class UnlockBackupProvider
    extends $FunctionalProvider<UnlockBackup, UnlockBackup, UnlockBackup>
    with $Provider<UnlockBackup> {
  UnlockBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'unlockBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$unlockBackupHash();

  @$internal
  @override
  $ProviderElement<UnlockBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UnlockBackup create(Ref ref) {
    return unlockBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UnlockBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UnlockBackup>(value),
    );
  }
}

String _$unlockBackupHash() => r'd0751b3957e7f2dc38b7c80722a0d74ca94b64f1';

@ProviderFor(restoreBackup)
final restoreBackupProvider = RestoreBackupProvider._();

final class RestoreBackupProvider
    extends $FunctionalProvider<RestoreBackup, RestoreBackup, RestoreBackup>
    with $Provider<RestoreBackup> {
  RestoreBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'restoreBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$restoreBackupHash();

  @$internal
  @override
  $ProviderElement<RestoreBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RestoreBackup create(Ref ref) {
    return restoreBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RestoreBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RestoreBackup>(value),
    );
  }
}

String _$restoreBackupHash() => r'95bdb7c6071b6caf7b020f0b84b9ef6f9ff971fb';

@ProviderFor(eraseAllData)
final eraseAllDataProvider = EraseAllDataProvider._();

final class EraseAllDataProvider
    extends $FunctionalProvider<EraseAllData, EraseAllData, EraseAllData>
    with $Provider<EraseAllData> {
  EraseAllDataProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eraseAllDataProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eraseAllDataHash();

  @$internal
  @override
  $ProviderElement<EraseAllData> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EraseAllData create(Ref ref) {
    return eraseAllData(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EraseAllData value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EraseAllData>(value),
    );
  }
}

String _$eraseAllDataHash() => r'2c49d36585068ee9f1c3f9b39d167f67c2790af8';

@ProviderFor(watchBackupStatus)
final watchBackupStatusProvider = WatchBackupStatusProvider._();

final class WatchBackupStatusProvider
    extends
        $FunctionalProvider<
          WatchBackupStatus,
          WatchBackupStatus,
          WatchBackupStatus
        >
    with $Provider<WatchBackupStatus> {
  WatchBackupStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchBackupStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchBackupStatusHash();

  @$internal
  @override
  $ProviderElement<WatchBackupStatus> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WatchBackupStatus create(Ref ref) {
    return watchBackupStatus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchBackupStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchBackupStatus>(value),
    );
  }
}

String _$watchBackupStatusHash() => r'7226f254643754397989123e6a78e3bd4269659d';

@ProviderFor(setBackupReminder)
final setBackupReminderProvider = SetBackupReminderProvider._();

final class SetBackupReminderProvider
    extends
        $FunctionalProvider<
          SetBackupReminder,
          SetBackupReminder,
          SetBackupReminder
        >
    with $Provider<SetBackupReminder> {
  SetBackupReminderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setBackupReminderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setBackupReminderHash();

  @$internal
  @override
  $ProviderElement<SetBackupReminder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetBackupReminder create(Ref ref) {
    return setBackupReminder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetBackupReminder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetBackupReminder>(value),
    );
  }
}

String _$setBackupReminderHash() => r'60b2c528247f022083cb602ac21b5129e96c91d5';

@ProviderFor(snoozeBackupReminder)
final snoozeBackupReminderProvider = SnoozeBackupReminderProvider._();

final class SnoozeBackupReminderProvider
    extends
        $FunctionalProvider<
          SnoozeBackupReminder,
          SnoozeBackupReminder,
          SnoozeBackupReminder
        >
    with $Provider<SnoozeBackupReminder> {
  SnoozeBackupReminderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'snoozeBackupReminderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$snoozeBackupReminderHash();

  @$internal
  @override
  $ProviderElement<SnoozeBackupReminder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SnoozeBackupReminder create(Ref ref) {
    return snoozeBackupReminder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SnoozeBackupReminder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SnoozeBackupReminder>(value),
    );
  }
}

String _$snoozeBackupReminderHash() =>
    r'2c9578714133adf49024a6912f09c75445ce1147';

@ProviderFor(getBackupEncryption)
final getBackupEncryptionProvider = GetBackupEncryptionProvider._();

final class GetBackupEncryptionProvider
    extends
        $FunctionalProvider<
          GetBackupEncryption,
          GetBackupEncryption,
          GetBackupEncryption
        >
    with $Provider<GetBackupEncryption> {
  GetBackupEncryptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getBackupEncryptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getBackupEncryptionHash();

  @$internal
  @override
  $ProviderElement<GetBackupEncryption> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetBackupEncryption create(Ref ref) {
    return getBackupEncryption(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetBackupEncryption value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetBackupEncryption>(value),
    );
  }
}

String _$getBackupEncryptionHash() =>
    r'5b711727fede67250c3849ea1d761870f06c98bd';

@ProviderFor(setBackupPassword)
final setBackupPasswordProvider = SetBackupPasswordProvider._();

final class SetBackupPasswordProvider
    extends
        $FunctionalProvider<
          SetBackupPassword,
          SetBackupPassword,
          SetBackupPassword
        >
    with $Provider<SetBackupPassword> {
  SetBackupPasswordProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'setBackupPasswordProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$setBackupPasswordHash();

  @$internal
  @override
  $ProviderElement<SetBackupPassword> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SetBackupPassword create(Ref ref) {
    return setBackupPassword(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SetBackupPassword value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SetBackupPassword>(value),
    );
  }
}

String _$setBackupPasswordHash() => r'b75eb7cd7e6be939a8b71129402042afbf5bb84a';

@ProviderFor(chooseAutoBackupFolder)
final chooseAutoBackupFolderProvider = ChooseAutoBackupFolderProvider._();

final class ChooseAutoBackupFolderProvider
    extends
        $FunctionalProvider<
          ChooseAutoBackupFolder,
          ChooseAutoBackupFolder,
          ChooseAutoBackupFolder
        >
    with $Provider<ChooseAutoBackupFolder> {
  ChooseAutoBackupFolderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chooseAutoBackupFolderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chooseAutoBackupFolderHash();

  @$internal
  @override
  $ProviderElement<ChooseAutoBackupFolder> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ChooseAutoBackupFolder create(Ref ref) {
    return chooseAutoBackupFolder(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChooseAutoBackupFolder value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChooseAutoBackupFolder>(value),
    );
  }
}

String _$chooseAutoBackupFolderHash() =>
    r'6dbb4cf7ee94ef2ac1a78458500d4796aee822c5';

@ProviderFor(turnOffAutoBackup)
final turnOffAutoBackupProvider = TurnOffAutoBackupProvider._();

final class TurnOffAutoBackupProvider
    extends
        $FunctionalProvider<
          TurnOffAutoBackup,
          TurnOffAutoBackup,
          TurnOffAutoBackup
        >
    with $Provider<TurnOffAutoBackup> {
  TurnOffAutoBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'turnOffAutoBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$turnOffAutoBackupHash();

  @$internal
  @override
  $ProviderElement<TurnOffAutoBackup> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TurnOffAutoBackup create(Ref ref) {
    return turnOffAutoBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TurnOffAutoBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TurnOffAutoBackup>(value),
    );
  }
}

String _$turnOffAutoBackupHash() => r'f0eb7620a68765bd67e5130f8615f97d4893023b';

@ProviderFor(runAutoBackup)
final runAutoBackupProvider = RunAutoBackupProvider._();

final class RunAutoBackupProvider
    extends $FunctionalProvider<RunAutoBackup, RunAutoBackup, RunAutoBackup>
    with $Provider<RunAutoBackup> {
  RunAutoBackupProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'runAutoBackupProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$runAutoBackupHash();

  @$internal
  @override
  $ProviderElement<RunAutoBackup> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  RunAutoBackup create(Ref ref) {
    return runAutoBackup(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RunAutoBackup value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RunAutoBackup>(value),
    );
  }
}

String _$runAutoBackupHash() => r'bbcdd7aadea613d747dcef8720d8aa2943aad738';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backup_actions.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Backup, restore and erase. Each returns its result for the page to show.

@ProviderFor(BackupActions)
final backupActionsProvider = BackupActionsProvider._();

/// Backup, restore and erase. Each returns its result for the page to show.
final class BackupActionsProvider
    extends $NotifierProvider<BackupActions, void> {
  /// Backup, restore and erase. Each returns its result for the page to show.
  BackupActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'backupActionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$backupActionsHash();

  @$internal
  @override
  BackupActions create() => BackupActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$backupActionsHash() => r'3bd694edcd28a10b7d1e14d08b165af857a0c2d8';

/// Backup, restore and erase. Each returns its result for the page to show.

abstract class _$BackupActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

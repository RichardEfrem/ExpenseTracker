// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The user's preferences. Deliberately app-lifetime: theme and periods
/// depend on it everywhere.

@ProviderFor(SettingsNotifier)
final settingsProvider = SettingsNotifierProvider._();

/// The user's preferences. Deliberately app-lifetime: theme and periods
/// depend on it everywhere.
final class SettingsNotifierProvider
    extends $StreamNotifierProvider<SettingsNotifier, AppSettings> {
  /// The user's preferences. Deliberately app-lifetime: theme and periods
  /// depend on it everywhere.
  SettingsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsNotifierHash();

  @$internal
  @override
  SettingsNotifier create() => SettingsNotifier();
}

String _$settingsNotifierHash() => r'd8cc4fc8aa1cb46dad1c073a5a71c592d024ee6f';

/// The user's preferences. Deliberately app-lifetime: theme and periods
/// depend on it everywhere.

abstract class _$SettingsNotifier extends $StreamNotifier<AppSettings> {
  Stream<AppSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AppSettings>, AppSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<AppSettings>, AppSettings>,
              AsyncValue<AppSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The theme to show; the default while settings load, so the first frame
/// never waits on the database.

@ProviderFor(AppThemeModeNotifier)
final appThemeModeProvider = AppThemeModeNotifierProvider._();

/// The theme to show; the default while settings load, so the first frame
/// never waits on the database.
final class AppThemeModeNotifierProvider
    extends $NotifierProvider<AppThemeModeNotifier, AppThemeMode> {
  /// The theme to show; the default while settings load, so the first frame
  /// never waits on the database.
  AppThemeModeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeModeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeModeNotifierHash();

  @$internal
  @override
  AppThemeModeNotifier create() => AppThemeModeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppThemeMode>(value),
    );
  }
}

String _$appThemeModeNotifierHash() =>
    r'4c4141b72f4c863f4e5dc72fefe5b9dc7e6b6f5b';

/// The theme to show; the default while settings load, so the first frame
/// never waits on the database.

abstract class _$AppThemeModeNotifier extends $Notifier<AppThemeMode> {
  AppThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppThemeMode, AppThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppThemeMode, AppThemeMode>,
              AppThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

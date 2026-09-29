// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_scope_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The scope all reports and the Home dashboard show: the shared period
/// and the chosen accounts. App-lifetime, like the period it follows.

@ProviderFor(ReportScopeNotifier)
final reportScopeProvider = ReportScopeNotifierProvider._();

/// The scope all reports and the Home dashboard show: the shared period
/// and the chosen accounts. App-lifetime, like the period it follows.
final class ReportScopeNotifierProvider
    extends $NotifierProvider<ReportScopeNotifier, ReportScope> {
  /// The scope all reports and the Home dashboard show: the shared period
  /// and the chosen accounts. App-lifetime, like the period it follows.
  ReportScopeNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportScopeProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportScopeNotifierHash();

  @$internal
  @override
  ReportScopeNotifier create() => ReportScopeNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportScope value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportScope>(value),
    );
  }
}

String _$reportScopeNotifierHash() =>
    r'e89e187e8415303c9e187b22cb5fa4cf171c25f3';

/// The scope all reports and the Home dashboard show: the shared period
/// and the chosen accounts. App-lifetime, like the period it follows.

abstract class _$ReportScopeNotifier extends $Notifier<ReportScope> {
  ReportScope build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ReportScope, ReportScope>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ReportScope, ReportScope>,
              ReportScope,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

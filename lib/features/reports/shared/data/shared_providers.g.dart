// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(reportsLocalDataSource)
final reportsLocalDataSourceProvider = ReportsLocalDataSourceProvider._();

final class ReportsLocalDataSourceProvider
    extends
        $FunctionalProvider<
          ReportsLocalDataSource,
          ReportsLocalDataSource,
          ReportsLocalDataSource
        >
    with $Provider<ReportsLocalDataSource> {
  ReportsLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportsLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportsLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<ReportsLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ReportsLocalDataSource create(Ref ref) {
    return reportsLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportsLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportsLocalDataSource>(value),
    );
  }
}

String _$reportsLocalDataSourceHash() =>
    r'241c7aa04f8ad0b5e492964dd1336dd7eb648b7c';

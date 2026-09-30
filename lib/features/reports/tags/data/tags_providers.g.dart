// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagReportRepository)
final tagReportRepositoryProvider = TagReportRepositoryProvider._();

final class TagReportRepositoryProvider
    extends
        $FunctionalProvider<
          TagReportRepository,
          TagReportRepository,
          TagReportRepository
        >
    with $Provider<TagReportRepository> {
  TagReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagReportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagReportRepositoryHash();

  @$internal
  @override
  $ProviderElement<TagReportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TagReportRepository create(Ref ref) {
    return tagReportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagReportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagReportRepository>(value),
    );
  }
}

String _$tagReportRepositoryHash() =>
    r'5d3e81a2924823fd3e2716b94acf27fe2b6104fe';

@ProviderFor(watchTagReport)
final watchTagReportProvider = WatchTagReportProvider._();

final class WatchTagReportProvider
    extends $FunctionalProvider<WatchTagReport, WatchTagReport, WatchTagReport>
    with $Provider<WatchTagReport> {
  WatchTagReportProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTagReportProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTagReportHash();

  @$internal
  @override
  $ProviderElement<WatchTagReport> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTagReport create(Ref ref) {
    return watchTagReport(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTagReport value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTagReport>(value),
    );
  }
}

String _$watchTagReportHash() => r'5b9a4555dc45515f435fecfd47a17cd10cfdc15b';

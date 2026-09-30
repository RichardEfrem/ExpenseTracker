// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(tagLocalDataSource)
final tagLocalDataSourceProvider = TagLocalDataSourceProvider._();

final class TagLocalDataSourceProvider
    extends
        $FunctionalProvider<
          TagLocalDataSource,
          TagLocalDataSource,
          TagLocalDataSource
        >
    with $Provider<TagLocalDataSource> {
  TagLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<TagLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  TagLocalDataSource create(Ref ref) {
    return tagLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagLocalDataSource>(value),
    );
  }
}

String _$tagLocalDataSourceHash() =>
    r'c7a5975c75d9b66dc2a7f141ffff0044aad5b0de';

@ProviderFor(tagRepository)
final tagRepositoryProvider = TagRepositoryProvider._();

final class TagRepositoryProvider
    extends $FunctionalProvider<TagRepository, TagRepository, TagRepository>
    with $Provider<TagRepository> {
  TagRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagRepositoryHash();

  @$internal
  @override
  $ProviderElement<TagRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TagRepository create(Ref ref) {
    return tagRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TagRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TagRepository>(value),
    );
  }
}

String _$tagRepositoryHash() => r'92c9d6475230f8d6e7d32a1418d82ff1222d2274';

@ProviderFor(watchTags)
final watchTagsProvider = WatchTagsProvider._();

final class WatchTagsProvider
    extends $FunctionalProvider<WatchTags, WatchTags, WatchTags>
    with $Provider<WatchTags> {
  WatchTagsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'watchTagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$watchTagsHash();

  @$internal
  @override
  $ProviderElement<WatchTags> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WatchTags create(Ref ref) {
    return watchTags(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WatchTags value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WatchTags>(value),
    );
  }
}

String _$watchTagsHash() => r'7b5c4117642ed0eebbbd514be42e67861541d75f';

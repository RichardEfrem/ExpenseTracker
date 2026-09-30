// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Every tag in use, most used first.

@ProviderFor(TagsNotifier)
final tagsProvider = TagsNotifierProvider._();

/// Every tag in use, most used first.
final class TagsNotifierProvider
    extends $StreamNotifierProvider<TagsNotifier, List<Tag>> {
  /// Every tag in use, most used first.
  TagsNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tagsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tagsNotifierHash();

  @$internal
  @override
  TagsNotifier create() => TagsNotifier();
}

String _$tagsNotifierHash() => r'b4db69ec153c0d3fcb00dba1817479b38cab68db';

/// Every tag in use, most used first.

abstract class _$TagsNotifier extends $StreamNotifier<List<Tag>> {
  Stream<List<Tag>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Tag>>, List<Tag>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Tag>>, List<Tag>>,
              AsyncValue<List<Tag>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

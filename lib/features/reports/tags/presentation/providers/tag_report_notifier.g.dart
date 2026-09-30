// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_report_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TagReportNotifier)
final tagReportProvider = TagReportNotifierFamily._();

final class TagReportNotifierProvider
    extends $StreamNotifierProvider<TagReportNotifier, TagReport> {
  TagReportNotifierProvider._({
    required TagReportNotifierFamily super.from,
    required (ReportScope, CategoryType) super.argument,
  }) : super(
         retry: null,
         name: r'tagReportProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tagReportNotifierHash();

  @override
  String toString() {
    return r'tagReportProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  TagReportNotifier create() => TagReportNotifier();

  @override
  bool operator ==(Object other) {
    return other is TagReportNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tagReportNotifierHash() => r'0a5bb16a740d33c6c1e38d301ec545b5c4294318';

final class TagReportNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          TagReportNotifier,
          AsyncValue<TagReport>,
          TagReport,
          Stream<TagReport>,
          (ReportScope, CategoryType)
        > {
  TagReportNotifierFamily._()
    : super(
        retry: null,
        name: r'tagReportProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TagReportNotifierProvider call(ReportScope scope, CategoryType type) =>
      TagReportNotifierProvider._(argument: (scope, type), from: this);

  @override
  String toString() => r'tagReportProvider';
}

abstract class _$TagReportNotifier extends $StreamNotifier<TagReport> {
  late final _$args = ref.$arg as (ReportScope, CategoryType);
  ReportScope get scope => _$args.$1;
  CategoryType get type => _$args.$2;

  Stream<TagReport> build(ReportScope scope, CategoryType type);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<TagReport>, TagReport>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<TagReport>, TagReport>,
              AsyncValue<TagReport>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args.$1, _$args.$2));
  }
}

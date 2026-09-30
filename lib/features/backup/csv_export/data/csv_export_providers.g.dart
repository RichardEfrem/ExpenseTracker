// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_export_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(csvExportLocalDataSource)
final csvExportLocalDataSourceProvider = CsvExportLocalDataSourceProvider._();

final class CsvExportLocalDataSourceProvider
    extends
        $FunctionalProvider<
          CsvExportLocalDataSource,
          CsvExportLocalDataSource,
          CsvExportLocalDataSource
        >
    with $Provider<CsvExportLocalDataSource> {
  CsvExportLocalDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'csvExportLocalDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$csvExportLocalDataSourceHash();

  @$internal
  @override
  $ProviderElement<CsvExportLocalDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CsvExportLocalDataSource create(Ref ref) {
    return csvExportLocalDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CsvExportLocalDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CsvExportLocalDataSource>(value),
    );
  }
}

String _$csvExportLocalDataSourceHash() =>
    r'16e5d275a09023056cd59aca27925eb271b528fb';

@ProviderFor(csvExportRepository)
final csvExportRepositoryProvider = CsvExportRepositoryProvider._();

final class CsvExportRepositoryProvider
    extends
        $FunctionalProvider<
          CsvExportRepository,
          CsvExportRepository,
          CsvExportRepository
        >
    with $Provider<CsvExportRepository> {
  CsvExportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'csvExportRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$csvExportRepositoryHash();

  @$internal
  @override
  $ProviderElement<CsvExportRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CsvExportRepository create(Ref ref) {
    return csvExportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CsvExportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CsvExportRepository>(value),
    );
  }
}

String _$csvExportRepositoryHash() =>
    r'7505e08c80f7046192aabb49d641333274d3068d';

@ProviderFor(exportCsv)
final exportCsvProvider = ExportCsvProvider._();

final class ExportCsvProvider
    extends $FunctionalProvider<ExportCsv, ExportCsv, ExportCsv>
    with $Provider<ExportCsv> {
  ExportCsvProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exportCsvProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exportCsvHash();

  @$internal
  @override
  $ProviderElement<ExportCsv> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ExportCsv create(Ref ref) {
    return exportCsv(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExportCsv value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExportCsv>(value),
    );
  }
}

String _$exportCsvHash() => r'539c8432e84ed736211b26db3ea2e0eac0f5086f';

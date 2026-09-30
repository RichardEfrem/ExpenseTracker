// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'csv_export_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The CSV export page's range choice and its export action.

@ProviderFor(CsvExportFormNotifier)
final csvExportFormProvider = CsvExportFormNotifierProvider._();

/// The CSV export page's range choice and its export action.
final class CsvExportFormNotifierProvider
    extends $NotifierProvider<CsvExportFormNotifier, CsvExportForm> {
  /// The CSV export page's range choice and its export action.
  CsvExportFormNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'csvExportFormProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$csvExportFormNotifierHash();

  @$internal
  @override
  CsvExportFormNotifier create() => CsvExportFormNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CsvExportForm value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CsvExportForm>(value),
    );
  }
}

String _$csvExportFormNotifierHash() =>
    r'7586c08142d05185eb7f0107f810ab768e66cac5';

/// The CSV export page's range choice and its export action.

abstract class _$CsvExportFormNotifier extends $Notifier<CsvExportForm> {
  CsvExportForm build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CsvExportForm, CsvExportForm>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CsvExportForm, CsvExportForm>,
              CsvExportForm,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

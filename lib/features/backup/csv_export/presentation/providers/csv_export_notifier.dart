import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/backup/backup/domain/repositories/backup_repository.dart';
import 'package:expense_tracker/features/backup/csv_export/data/csv_export_providers.dart';
import 'package:expense_tracker/features/backup/csv_export/domain/usecases/export_csv.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'csv_export_notifier.freezed.dart';
part 'csv_export_notifier.g.dart';

/// Date ranges offered for a CSV export (DESIGN §8.10).
enum CsvRangePreset {
  thisMonth,
  lastMonth,
  thisYear,
  lastYear,
  allTime,
  custom,
}

@freezed
abstract class CsvExportForm with _$CsvExportForm {
  const factory CsvExportForm({
    @Default(CsvRangePreset.thisYear) CsvRangePreset preset,

    /// The picked range while [preset] is custom.
    Period? custom,
  }) = _CsvExportForm;

  const CsvExportForm._();

  /// The range to export on [today]; null for all time. Months honour
  /// [monthStartDay].
  Period? range(LocalDate today, {required int monthStartDay}) =>
      switch (preset) {
        CsvRangePreset.thisMonth => Period.monthContaining(
          today,
          startDay: monthStartDay,
        ),
        CsvRangePreset.lastMonth => Period.monthContaining(
          today,
          startDay: monthStartDay,
        ).previous(),
        CsvRangePreset.thisYear => Period.yearContaining(today),
        CsvRangePreset.lastYear => Period.yearContaining(today).previous(),
        CsvRangePreset.allTime => null,
        CsvRangePreset.custom => custom ?? Period.custom(today, today),
      };
}

/// The CSV export page's range choice and its export action.
@riverpod
class CsvExportFormNotifier extends _$CsvExportFormNotifier {
  @override
  CsvExportForm build() => const CsvExportForm();

  void setPreset(CsvRangePreset preset) =>
      state = state.copyWith(preset: preset);

  void setCustom(Period range) =>
      state = state.copyWith(preset: CsvRangePreset.custom, custom: range);

  /// The selected range right now; null for all time.
  Period? currentRange() => state.range(
    LocalDate.today(ref.read(clockProvider)),
    monthStartDay: ref.read(settingsProvider).value?.monthStartDay ?? 1,
  );

  Future<Either<Failure, CsvExportResult>> export(ExportTarget target) =>
      ref.read(exportCsvProvider)(currentRange(), target);
}

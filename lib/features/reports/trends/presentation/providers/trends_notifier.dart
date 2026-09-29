import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/trends/data/trends_providers.dart';
import 'package:expense_tracker/features/reports/trends/domain/entities/month_totals.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'trends_notifier.g.dart';

@riverpod
class TrendsNotifier extends _$TrendsNotifier {
  @override
  Stream<List<MonthTotals>> build(ReportScope scope, int monthCount) {
    final startDay =
        ref.watch(settingsProvider).value?.monthStartDay ??
        const AppSettings().monthStartDay;
    return ref
        .watch(watchTrendsProvider)(
          scope,
          monthCount: monthCount,
          monthStartDay: startDay,
        )
        .unwrap();
  }
}

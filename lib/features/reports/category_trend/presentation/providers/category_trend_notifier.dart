import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/reports/category_trend/data/category_trend_providers.dart';
import 'package:expense_tracker/features/reports/category_trend/domain/entities/category_trend.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_trend_notifier.g.dart';

@riverpod
class CategoryTrendNotifier extends _$CategoryTrendNotifier {
  @override
  Stream<CategoryTrend> build(ReportScope scope, int monthCount) {
    final startDay =
        ref.watch(settingsProvider).value?.monthStartDay ??
        const AppSettings().monthStartDay;
    return ref
        .watch(watchCategoryTrendProvider)(
          scope,
          monthCount: monthCount,
          monthStartDay: startDay,
        )
        .unwrap();
  }
}

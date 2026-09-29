import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/compare/data/compare_providers.dart';
import 'package:expense_tracker/features/reports/compare/domain/entities/period_comparison.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comparison_notifier.g.dart';

@riverpod
class ComparisonNotifier extends _$ComparisonNotifier {
  @override
  Stream<PeriodComparison> build(ReportScope scope, CategoryType type) =>
      ref.watch(watchComparisonProvider)(scope, type).unwrap();
}

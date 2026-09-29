import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/category_breakdown/data/category_breakdown_providers.dart';
import 'package:expense_tracker/features/reports/category_breakdown/domain/entities/category_breakdown.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'category_breakdown_notifier.g.dart';

@riverpod
class CategoryBreakdownNotifier extends _$CategoryBreakdownNotifier {
  @override
  Stream<CategoryBreakdown> build(ReportScope scope, CategoryType type) =>
      ref.watch(watchCategoryBreakdownProvider)(scope, type).unwrap();
}

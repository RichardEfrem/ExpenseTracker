import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/features/categories/categories_presentation.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/tags/data/tags_providers.dart';
import 'package:expense_tracker/features/reports/tags/domain/entities/tag_report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'tag_report_notifier.g.dart';

@riverpod
class TagReportNotifier extends _$TagReportNotifier {
  @override
  Stream<TagReport> build(ReportScope scope, CategoryType type) =>
      ref.watch(watchTagReportProvider)(scope, type).unwrap();
}

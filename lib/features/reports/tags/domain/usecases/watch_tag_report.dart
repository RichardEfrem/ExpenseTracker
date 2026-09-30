import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/tags/domain/entities/tag_report.dart';
import 'package:expense_tracker/features/reports/tags/domain/repositories/tag_report_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Totals per tag (PRD RPT-08).
class WatchTagReport {
  const WatchTagReport(this._repository);

  final TagReportRepository _repository;

  Stream<Either<Failure, TagReport>> call(
    ReportScope scope,
    CategoryType type,
  ) => _repository.watch(scope, type);
}

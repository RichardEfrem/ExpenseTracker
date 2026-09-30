import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/features/categories/categories_domain.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/tags/domain/entities/tag_report.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class TagReportRepository {
  Stream<Either<Failure, TagReport>> watch(
    ReportScope scope,
    CategoryType type,
  );
}

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/features/categories/categories_data.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:expense_tracker/features/reports/tags/domain/entities/tag_report.dart';
import 'package:expense_tracker/features/reports/tags/domain/repositories/tag_report_repository.dart';
import 'package:fpdart/fpdart.dart';

class TagReportRepositoryImpl implements TagReportRepository {
  const TagReportRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, TagReport>> watch(
    ReportScope scope,
    CategoryType type,
  ) => guardStream(
    _dataSource.watch(
      () async => TagReport(
        type: type,
        totals: [
          for (final r in await _dataSource.byTag(scope, type.name))
            TagTotal(name: r.name, amount: r.amount, count: r.count),
        ],
      ),
    ),
  );
}

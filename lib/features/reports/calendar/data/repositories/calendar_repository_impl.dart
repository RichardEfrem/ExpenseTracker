import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/error/guard.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/calendar/domain/repositories/calendar_repository.dart';
import 'package:expense_tracker/features/reports/shared/data/datasources/reports_local_datasource.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  const CalendarRepositoryImpl(this._dataSource);

  final ReportsLocalDataSource _dataSource;

  @override
  Stream<Either<Failure, CashFlowCalendar>> watch(
    ReportScope scope,
    LocalDate today,
  ) => guardStream(
    _dataSource.watch(
      () async => CashFlowCalendar(
        period: scope.period,
        today: today,
        netByDay: await _dataSource.dailyNet(scope),
      ),
    ),
  );
}

import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/calendar/domain/repositories/calendar_repository.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

/// Daily net over the scope's period (PRD RPT-06).
class WatchCashFlowCalendar {
  const WatchCashFlowCalendar(this._repository);

  final CalendarRepository _repository;

  Stream<Either<Failure, CashFlowCalendar>> call(
    ReportScope scope,
    LocalDate today,
  ) => _repository.watch(scope, today);
}

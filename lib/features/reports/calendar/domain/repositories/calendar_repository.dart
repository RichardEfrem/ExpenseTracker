import 'package:expense_tracker/core/error/failure.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class CalendarRepository {
  Stream<Either<Failure, CashFlowCalendar>> watch(
    ReportScope scope,
    LocalDate today,
  );
}

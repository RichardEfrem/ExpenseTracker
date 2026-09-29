import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/calendar/data/calendar_providers.dart';
import 'package:expense_tracker/features/reports/calendar/domain/entities/cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cash_flow_calendar_notifier.g.dart';

@riverpod
class CashFlowCalendarNotifier extends _$CashFlowCalendarNotifier {
  @override
  Stream<CashFlowCalendar> build(ReportScope scope) => ref
      .watch(watchCashFlowCalendarProvider)(
        scope,
        LocalDate.today(ref.watch(clockProvider)),
      )
      .unwrap();
}

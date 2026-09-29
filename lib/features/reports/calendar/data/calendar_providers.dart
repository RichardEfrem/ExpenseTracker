import 'package:expense_tracker/features/reports/calendar/data/repositories/calendar_repository_impl.dart';
import 'package:expense_tracker/features/reports/calendar/domain/repositories/calendar_repository.dart';
import 'package:expense_tracker/features/reports/calendar/domain/usecases/watch_cash_flow_calendar.dart';
import 'package:expense_tracker/features/reports/shared/data/shared_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calendar_providers.g.dart';

@riverpod
CalendarRepository calendarRepository(Ref ref) =>
    CalendarRepositoryImpl(ref.watch(reportsLocalDataSourceProvider));

@riverpod
WatchCashFlowCalendar watchCashFlowCalendar(Ref ref) =>
    WatchCashFlowCalendar(ref.watch(calendarRepositoryProvider));

import 'package:expense_tracker/core/error/either_extensions.dart';
import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/features/reports/daily/data/daily_providers.dart';
import 'package:expense_tracker/features/reports/daily/domain/entities/daily_spending.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'daily_spending_notifier.g.dart';

@riverpod
class DailySpendingNotifier extends _$DailySpendingNotifier {
  @override
  Stream<DailySpending> build(ReportScope scope) => ref
      .watch(watchDailySpendingProvider)(
        scope,
        LocalDate.today(ref.watch(clockProvider)),
      )
      .unwrap();
}

import 'package:expense_tracker/features/period/period_presentation.dart';
import 'package:expense_tracker/features/reports/shared/domain/entities/report_scope.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'report_scope_notifier.g.dart';

/// The scope all reports and the Home dashboard show: the shared period
/// and the chosen accounts. App-lifetime, like the period it follows.
@Riverpod(keepAlive: true)
class ReportScopeNotifier extends _$ReportScopeNotifier {
  /// Kept across period changes (the notifier instance survives rebuilds).
  var _accountIds = <String>{};

  @override
  ReportScope build() => ReportScope(
    period: ref.watch(selectedPeriodProvider),
    accountIds: _accountIds,
  );

  /// Limits reports to [ids]; empty means all accounts.
  void setAccounts(Set<String> ids) {
    _accountIds = {...ids};
    state = state.copyWith(accountIds: _accountIds);
  }
}

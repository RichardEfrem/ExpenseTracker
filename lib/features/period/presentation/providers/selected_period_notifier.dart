import 'package:expense_tracker/core/utils/clock_provider.dart';
import 'package:expense_tracker/core/utils/local_date.dart';
import 'package:expense_tracker/core/utils/period.dart';
import 'package:expense_tracker/features/settings/settings_presentation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_period_notifier.g.dart';

/// The period Home, Activity and Reports show (DESIGN §7.1). Deliberately
/// app-lifetime: one choice shared by all three screens.
@Riverpod(keepAlive: true)
class SelectedPeriodNotifier extends _$SelectedPeriodNotifier {
  /// Survives rebuilds (the notifier instance is kept), so a change of
  /// month start day keeps the user's Week/Month/Year choice.
  var _kind = PeriodKind.month;

  @override
  Period build() {
    final settings = ref.watch(settingsProvider).value ?? const AppSettings();
    return Period.of(
      _kind,
      _today,
      monthStartDay: settings.monthStartDay,
      firstWeekday: settings.weekStart,
    );
  }

  LocalDate get _today => LocalDate.today(ref.read(clockProvider));

  AppSettings get _settings =>
      ref.read(settingsProvider).value ?? const AppSettings();

  /// `›` is disabled for periods after the current one.
  bool get canGoNext => !state.next().isFuture(_today);

  void previous() => state = state.previous();

  void next() {
    if (canGoNext) state = state.next();
  }

  /// Switches to the [kind] period around the one shown now (never later
  /// than today).
  void setKind(PeriodKind kind) {
    if (kind == PeriodKind.custom) return;
    _kind = kind;
    final anchor = LocalDate.min(state.end, _today);
    state = Period.of(
      kind,
      anchor,
      monthStartDay: _settings.monthStartDay,
      firstWeekday: _settings.weekStart,
    );
  }

  /// The month period labelled [year]-[month] (the one containing its 15th,
  /// so with start day 25, "September" is 25 Aug – 24 Sep).
  void setMonth(int year, int month) {
    _kind = PeriodKind.month;
    state = Period.monthContaining(
      LocalDate(year, month, 15),
      startDay: _settings.monthStartDay,
    );
  }

  void setYear(int year) {
    _kind = PeriodKind.year;
    state = Period.yearContaining(LocalDate(year, 1, 1));
  }

  void setCustom(LocalDate start, LocalDate end) {
    _kind = PeriodKind.custom;
    state = Period.custom(start, end);
  }

  /// Jumps to [period], e.g. from a report drill-down.
  void goTo(Period period) {
    _kind = period.kind;
    state = period;
  }

  /// Back to the current period of the current kind.
  void reset() {
    if (_kind == PeriodKind.custom) _kind = PeriodKind.month;
    ref.invalidateSelf();
  }
}

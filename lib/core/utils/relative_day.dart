import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/utils/date_format.dart';
import 'package:expense_tracker/core/utils/local_date.dart';

/// `Today`, `Yesterday`, else `Mon, 28 Sep` (DESIGN §5); the year is added
/// for dates outside [today]'s year.
String relativeDayLabel(
  AppLocalizations l10n,
  LocalDate date,
  LocalDate today,
) {
  if (date == today) return l10n.date_today;
  if (date == today.addDays(-1)) return l10n.date_yesterday;
  if (date.year != today.year) return AppDateFormat.dayMonthYear(date);
  return AppDateFormat.weekdayDayMonth(date);
}

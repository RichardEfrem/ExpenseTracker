import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/features/settings/domain/entities/app_settings.dart';

String themeModeLabel(AppLocalizations l10n, AppThemeMode mode) =>
    switch (mode) {
      AppThemeMode.system => l10n.theme_system,
      AppThemeMode.light => l10n.theme_light,
      AppThemeMode.dark => l10n.theme_dark,
    };

String weekdayLabel(AppLocalizations l10n, int weekday) => switch (weekday) {
  DateTime.monday => l10n.weekday_monday,
  DateTime.tuesday => l10n.weekday_tuesday,
  DateTime.wednesday => l10n.weekday_wednesday,
  DateTime.thursday => l10n.weekday_thursday,
  DateTime.friday => l10n.weekday_friday,
  DateTime.saturday => l10n.weekday_saturday,
  _ => l10n.weekday_sunday,
};

/// Week starts offered in the picker.
const weekStartChoices = [DateTime.monday, DateTime.sunday, DateTime.saturday];

/// Every route path in the app. Navigate by these, never by index.
abstract final class AppPaths {
  // Tabs.
  static const home = '/';
  static const activity = '/activity';
  static const reports = '/reports';
  static const more = '/more';

  // Full-screen routes above the shell.
  static const add = '/add';
  static const categories = '/more/categories';
  static const preferences = '/more/preferences';
  static const backup = '/more/backup';
  static const csvExport = '/more/backup/csv';
  static const accounts = '/more/accounts';
  static const recurring = '/more/recurring';
  static const newRecurring = '/more/recurring/new';
  static const editRecurring = '/more/recurring/:id/edit';
  static const appLock = '/more/lock';
  static const pinSetup = '/more/lock/pin';

  /// First-launch onboarding, above everything until finished or skipped.
  static const welcome = '/welcome';

  /// The lock screen, above everything while the app is locked.
  static const lock = '/lock';

  /// The four tab roots in navigation-bar order.
  static const tabs = [home, activity, reports, more];

  /// Tabs that show the add FAB (DESIGN §6).
  static const tabsWithFab = {home, activity};

  static const editTransaction = '/transactions/:id/edit';

  /// `/add?type=expense`.
  static String addOfType(String type) =>
      Uri(path: add, queryParameters: {'type': type}).toString();

  /// `/transactions/<id>/edit`.
  static String editTransactionOf(String id) =>
      '/transactions/${Uri.encodeComponent(id)}/edit';

  /// `/lock?from=<location>`: where to return after unlocking.
  static String lockReturningTo(String location) =>
      Uri(path: lock, queryParameters: {'from': location}).toString();

  /// `/more/lock/pin?mode=<mode>`.
  static String pinSetupFor(String mode) =>
      Uri(path: pinSetup, queryParameters: {'mode': mode}).toString();

  /// `/more/recurring/<id>/edit`.
  static String editRecurringOf(String id) =>
      '/more/recurring/${Uri.encodeComponent(id)}/edit';
}

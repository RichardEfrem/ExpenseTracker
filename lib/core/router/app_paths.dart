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
  static const accounts = '/more/accounts';

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
}

import 'package:go_router/go_router.dart';

/// What one module contributes to the app router: optionally a navigation
/// tab (a shell branch), and routes shown full-screen above the shell.
class ModuleRoutes {
  const ModuleRoutes({this.tab, this.routes = const []});

  final StatefulShellBranch? tab;
  final List<RouteBase> routes;
}

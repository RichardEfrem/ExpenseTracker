import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Where a module sends a navigation instead, or null to let it through.
typedef ModuleRedirect =
    String? Function(BuildContext context, GoRouterState state);

/// What one module contributes to the app router: optionally a navigation
/// tab (a shell branch), routes shown full-screen above the shell, and a
/// redirect applied to every navigation (e.g. the app lock).
class ModuleRoutes {
  const ModuleRoutes({this.tab, this.routes = const [], this.redirect});

  final StatefulShellBranch? tab;
  final List<RouteBase> routes;
  final ModuleRedirect? redirect;
}

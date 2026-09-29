import 'dart:async';

import 'package:expense_tracker/core/l10n/generated/app_localizations.dart';
import 'package:expense_tracker/core/router/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';

/// Bottom navigation (Home · Activity · Reports · More) plus the add FAB on
/// Home and Activity (DESIGN §6). Back from a tab root goes Home, then exits.
class AppShell extends StatelessWidget {
  const AppShell({required this.location, required this.child, super.key});

  /// Current path, e.g. `/activity`.
  final String location;
  final Widget child;

  static int? tabIndexOf(String location) {
    for (final (i, tab) in AppPaths.tabs.indexed) {
      final matches = tab == AppPaths.home
          ? location == tab
          : location == tab || location.startsWith('$tab/');
      if (matches) return i;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destinations = [
      (Symbols.home_rounded, l10n.nav_home),
      (Symbols.receipt_long_rounded, l10n.nav_activity),
      (Symbols.donut_large_rounded, l10n.nav_reports),
      (Symbols.more_horiz_rounded, l10n.nav_more),
    ];
    final isHome = location == AppPaths.home;

    return PopScope(
      canPop: isHome,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) context.go(AppPaths.home);
      },
      child: Scaffold(
        body: child,
        floatingActionButton: AppPaths.tabsWithFab.contains(location)
            ? const _AddFab()
            : null,
        bottomNavigationBar: NavigationBar(
          selectedIndex: tabIndexOf(location) ?? 0,
          onDestinationSelected: (i) => context.go(AppPaths.tabs[i]),
          destinations: [
            for (final (icon, label) in destinations)
              NavigationDestination(
                icon: Icon(icon),
                selectedIcon: Icon(icon, fill: 1),
                label: label,
              ),
          ],
        ),
      ),
    );
  }
}

/// Tap adds an expense; long-press opens Expense · Income · Transfer
/// (DESIGN §6, PRD §7).
class _AddFab extends StatelessWidget {
  const _AddFab();

  Future<void> _showMenu(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    unawaited(HapticFeedback.mediumImpact());
    final box = context.findRenderObject()! as RenderBox;
    final overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final rect = Rect.fromPoints(
      box.localToGlobal(Offset.zero, ancestor: overlay),
      box.localToGlobal(box.size.bottomRight(Offset.zero), ancestor: overlay),
    );
    final type = await showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(rect, Offset.zero & overlay.size),
      items: [
        PopupMenuItem(
          value: 'expense',
          child: ListTile(
            leading: const Icon(Symbols.arrow_upward_rounded),
            title: Text(l10n.type_expense),
          ),
        ),
        PopupMenuItem(
          value: 'income',
          child: ListTile(
            leading: const Icon(Symbols.arrow_downward_rounded),
            title: Text(l10n.type_income),
          ),
        ),
        PopupMenuItem(
          value: 'transfer',
          child: ListTile(
            leading: const Icon(Symbols.swap_horiz_rounded),
            title: Text(l10n.type_transfer),
          ),
        ),
      ],
    );
    if (type != null && context.mounted) {
      await context.push(AppPaths.addOfType(type));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // No tooltip: its long-press would swallow the type menu gesture, so the
    // label goes to semantics instead.
    return Semantics(
      onLongPressHint: l10n.fab_more_types,
      child: GestureDetector(
        onLongPress: () => _showMenu(context),
        child: FloatingActionButton.large(
          key: const ValueKey('add-fab'),
          onPressed: () => context.push(AppPaths.addOfType('expense')),
          child: Icon(
            Symbols.add_rounded,
            size: 36,
            semanticLabel: l10n.fab_add_expense,
          ),
        ),
      ),
    );
  }
}

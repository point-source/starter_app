import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/constants/constants.dart';
import 'package:starter_app/core/l10n/l10n_extensions.dart';
import 'package:starter_app/core/presentation/responsive/responsive.dart';
import 'package:starter_app/features/dashboard/l10n/dashboard_localizations.dart';
import 'package:starter_app/features/profile/l10n/profile_localizations.dart';
import 'package:starter_app/features/settings/l10n/settings_localizations.dart';

/// A scaffold that provides adaptive navigation based on screen size.
///
/// Automatically switches between different navigation patterns:
/// - **Compact** (mobile): Bottom NavigationBar
/// - **Medium** (tablet portrait): NavigationRail
/// - **Expanded** (tablet landscape): Dismissible NavigationDrawer
/// - **Large/Extra Large** (desktop): Permanent NavigationDrawer
///
/// This follows Material Design 3 navigation guidelines and integrates
/// with AutoRoute's TabsRouter for proper state management.
final class AdaptiveNavigationScaffold extends StatelessWidget {
  /// Creates an [AdaptiveNavigationScaffold].
  const AdaptiveNavigationScaffold({
    required this.tabsRouter,
    required this.child,
    super.key,
  });

  /// The navigation shell that manages the tab state and navigation.
  final TabsRouter tabsRouter;
  final Widget child;

  /// Get navigation destinations with localized labels.
  static List<_NavigationDestination> _getDestinations(BuildContext context) {
    return [
      _NavigationDestination(
        label: DashboardLocalizations.of(context).appBarTitle,
        icon: Icons.dashboard_outlined,
        selectedIcon: Icons.dashboard,
      ),
      _NavigationDestination(
        label: ProfileLocalizations.of(context).appBarTitle,
        icon: Icons.person_outline,
        selectedIcon: Icons.person,
      ),
      _NavigationDestination(
        label: SettingsLocalizations.of(context).appBarTitle,
        icon: Icons.settings_outlined,
        selectedIcon: Icons.settings,
      ),
    ];
  }

  /// Get the currently selected tab index from the navigation shell.
  int get _selectedIndex => tabsRouter.activeIndex;

  /// Handle tab selection.
  void _onDestinationSelected(int index) {
    // Don't navigate if already on the same branch
    if (index == _selectedIndex) return;

    tabsRouter.setActiveIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveLayoutBuilder(
      builder: (context, screenSize) {
        // Compact: Bottom NavigationBar
        if (screenSize == ScreenSize.compact) {
          return _CompactLayout(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            child: child,
          );
        }

        // Medium: NavigationRail
        if (screenSize == ScreenSize.medium) {
          return _MediumLayout(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            child: child,
          );
        }

        // Expanded: Dismissible NavigationDrawer
        if (screenSize == ScreenSize.expanded) {
          return _ExpandedLayout(
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            child: child,
          );
        }

        // Large/Extra Large: Permanent NavigationDrawer
        return _LargeLayout(
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onDestinationSelected,
          child: child,
        );
      },
    );
  }
}

/// Navigation destination data.
class _NavigationDestination {
  const _NavigationDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
}

/// Compact layout with bottom navigation bar.
class _CompactLayout extends StatelessWidget {
  const _CompactLayout({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: onDestinationSelected,
        destinations: AdaptiveNavigationScaffold._getDestinations(context)
            .map(
              (d) => NavigationDestination(
                icon: Icon(d.icon),
                selectedIcon: Icon(d.selectedIcon),
                label: d.label,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Medium layout with navigation rail.
class _MediumLayout extends StatelessWidget {
  const _MediumLayout({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            labelType: NavigationRailLabelType.all,
            destinations: AdaptiveNavigationScaffold._getDestinations(context)
                .map(
                  (d) => NavigationRailDestination(
                    icon: Icon(d.icon),
                    selectedIcon: Icon(d.selectedIcon),
                    label: Text(d.label),
                  ),
                )
                .toList(),
          ),
          const VerticalDivider(
            thickness: DividerConstants.thickness,
            width: DividerConstants.width,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// Expanded layout with dismissible navigation drawer.
class _ExpandedLayout extends StatelessWidget {
  const _ExpandedLayout({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.appL10n.appName),
      ),
      drawer: NavigationDrawer(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          onDestinationSelected(index);
          Navigator.pop(context); // Close drawer after selection
        },
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              PaddingConstants.large,
              PaddingConstants.medium,
              PaddingConstants.medium,
              PaddingConstants.small,
            ),
            child: Text(
              context.appL10n.appName,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ...AdaptiveNavigationScaffold._getDestinations(context).map(
            (d) => NavigationDrawerDestination(
              icon: Icon(d.icon),
              selectedIcon: Icon(d.selectedIcon),
              label: Text(d.label),
            ),
          ),
        ],
      ),
      body: child,
    );
  }
}

/// Large layout with permanent navigation drawer.
class _LargeLayout extends StatelessWidget {
  const _LargeLayout({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.child,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationDrawer(
            selectedIndex: selectedIndex,
            onDestinationSelected: onDestinationSelected,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  PaddingConstants.large,
                  PaddingConstants.medium,
                  PaddingConstants.medium,
                  PaddingConstants.small,
                ),
                child: Text(
                  context.appL10n.appName,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...AdaptiveNavigationScaffold._getDestinations(context).map(
                (d) => NavigationDrawerDestination(
                  icon: Icon(d.icon),
                  selectedIcon: Icon(d.selectedIcon),
                  label: Text(d.label),
                ),
              ),
            ],
          ),
          const VerticalDivider(
            thickness: DividerConstants.thickness,
            width: DividerConstants.thickness,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

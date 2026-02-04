import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/navigation/app_router.dart';

@RoutePage()
class DashboardShellPage extends StatelessWidget {
  const DashboardShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        DashboardRoute(),
        ProfileRoute(),
        SettingsRoute(),
        OrdersRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onTap: context.tabsRouter.setActiveIndex,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
            ],
          ),
        );
      },
    );
  }
}

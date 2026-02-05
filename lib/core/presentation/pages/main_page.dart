import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/presentation/widgets/adaptive_navigation_scaffold.dart';

@RoutePage()
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        DashboardRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return AdaptiveNavigationScaffold(
          tabsRouter: tabsRouter,
          child: child,
        );
      },
    );
  }
}

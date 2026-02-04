import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/auth_guard.dart';
import 'package:starter_app/features/auth/presentation/pages/auth_page.dart';
import 'package:starter_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:starter_app/features/dashboard/presentation/pages/dashboard_shell_page.dart';
import 'package:starter_app/features/orders/presentation/orders_page.dart';
import 'package:starter_app/features/profile/presentation/pages/profile_page.dart';
import 'package:starter_app/features/settings/presentation/pages/settings_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({
    required this.authGuard,
    required this.authChangeNotifier,
  });

  final AuthGuard authGuard;
  final AuthChangeNotifier authChangeNotifier;

  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/auth', page: AuthRoute.page),
    AutoRoute(
      path: '/',
      page: DashboardShellRoute.page,
      guards: [authGuard],
      children: [
        AutoRoute(path: '', page: DashboardRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
        AutoRoute(path: 'settings', page: SettingsRoute.page),
        AutoRoute(path: 'orders', page: OrdersRoute.page),
      ],
    ),
  ];

  @override
  Listenable? get reevaluateListenable => authChangeNotifier;

  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 200,
  );
}

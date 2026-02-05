import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/guards/auth_guard.dart';
import 'package:starter_app/core/navigation/route_definitions.dart';
import 'package:starter_app/core/presentation/pages/error_page.dart';
import 'package:starter_app/core/presentation/pages/main_page.dart';
import 'package:starter_app/features/auth/presentation/pages/auth_page.dart';
import 'package:starter_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:starter_app/features/orders/presentation/orders_page.dart';
import 'package:starter_app/features/profile/presentation/pages/profile_page.dart';
import 'package:starter_app/features/settings/presentation/pages/settings_page.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AuthChangeNotifier _authChangeNotifier;

  AppRouter(this._authChangeNotifier);

  @override
  final Map<String, AutoRoutePage<dynamic> Function(RouteData)> pagesMap = {
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthPage(),
      );
    },
    DashboardRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DashboardPage(),
      );
    },
    ErrorRoute.name: (routeData) {
      final args = routeData.argsAs<ErrorRouteArgs>(
        orElse: () => const ErrorRouteArgs(),
      );
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ErrorPage(error: args.error, key: args.key),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainPage(),
      );
    },
    OrdersRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrdersPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsPage(),
      );
    },
  };

  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          if (animation.status == AnimationStatus.reverse) {
            return FadeTransition(opacity: animation, child: child);
          }
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              ),
            ),
            child: child,
          );
        },
      );

  @override
  List<AutoRoute> get routes => [
        // Shell Route (Dashboard, Profile, Settings)
        AutoRoute(
          path: '/',
          page: MainRoute.page,
          children: [
            RedirectRoute(path: '', redirectTo: 'dashboard'),
            AutoRoute(
              path: 'dashboard',
              page: DashboardRoute.page,
              title: (context, data) => RouteDefinitions.dashboardName,
            ),
            AutoRoute(
              path: 'profile',
              page: ProfileRoute.page,
              title: (context, data) => RouteDefinitions.profileName,
            ),
            AutoRoute(
              path: 'settings',
              page: SettingsRoute.page,
              title: (context, data) => RouteDefinitions.settingsName,
            ),
          ],
        ),

        // Auth Route
        AutoRoute(
          path: RouteDefinitions.authPath,
          page: AuthRoute.page,
        ),

        // Protected Orders Route
        AutoRoute(
          path: RouteDefinitions.ordersPath,
          page: OrdersRoute.page,
          guards: [AuthGuard(_authChangeNotifier)],
        ),

        // Wildcard / Error
        AutoRoute(path: '*', page: ErrorRoute.page),
      ];
}

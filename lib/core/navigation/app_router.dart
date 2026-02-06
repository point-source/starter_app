import 'package:auto_route/auto_route.dart';
// Export generated routes
import 'package:starter_app/core/navigation/app_router.gr.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/auth_guard.dart';

export 'package:starter_app/core/navigation/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(
    this._authChangeNotifier,
  ) : super();

  final AuthChangeNotifier _authChangeNotifier;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    // Shell Route (Dashboard with tabs)
    AutoRoute(
      page: DashboardShellRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: DashboardRoute.page,
          path: 'dashboard',
          initial: true,
        ),
        AutoRoute(
          page: ProfileRoute.page,
          path: 'profile',
        ),
        AutoRoute(
          page: SettingsRoute.page,
          path: 'settings',
        ),
        AutoRoute(
          page: OrdersRoute.page,
          path: 'orders',
          guards: [AuthGuard(_authChangeNotifier)],
        ),
      ],
    ),

    // Auth Route (Outside shell, but accessible)
    CustomRoute<void>(
      page: AuthRoute.page,
      path: '/auth',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      duration: const Duration(milliseconds: 400),
    ),

    // Redirects
    // Redirect '/' to 'dashboard' (handled by initial: true on DashboardShellRoute)
  ];

  // Helper for tests or external access if needed
  StackRouter get routerConfig => this;
}

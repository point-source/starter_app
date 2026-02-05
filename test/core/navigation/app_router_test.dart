import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/app_router.gr.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';

class MockAuthChangeNotifier extends Mock implements AuthChangeNotifier {}

void main() {
  late AuthChangeNotifier authChangeNotifier;
  late AppRouter appRouter;

  setUp(() {
    authChangeNotifier = MockAuthChangeNotifier();
    appRouter = AppRouter(authChangeNotifier);
  });

  group('AppRouter', () {
    test('defaultRouteType is adaptive', () {
      expect(appRouter.defaultRouteType, const RouteType.adaptive());
    });

    test('defines correct routes', () {
      final routes = appRouter.routes;

      // Dashboard Shell
      final shellRoute = routes.firstWhere(
        (r) => r.page.name == DashboardShellRoute.name,
      );
      expect(shellRoute.initial, isTrue);

      // Auth Route
      final authRoute = routes.firstWhere((r) => r.page.name == AuthRoute.name);
      expect(authRoute.path, '/auth');

      // Nested Routes in Shell
      final shellChildren = shellRoute.children!;
      expect(
        shellChildren.any((r) => r.page.name == DashboardRoute.name),
        isTrue,
      );
      expect(
        shellChildren.any((r) => r.page.name == ProfileRoute.name),
        isTrue,
      );
      expect(
        shellChildren.any((r) => r.page.name == SettingsRoute.name),
        isTrue,
      );
      expect(shellChildren.any((r) => r.page.name == OrdersRoute.name), isTrue);
    });

    test('OrdersRoute has AuthGuard', () {
      final routes = appRouter.routes;
      final shellRoute = routes.firstWhere(
        (r) => r.page.name == DashboardShellRoute.name,
      );
      final ordersRoute = shellRoute.children!.firstWhere(
        (r) => r.page.name == OrdersRoute.name,
      );

      expect(ordersRoute.guards, isNotEmpty);
    });
  });
}

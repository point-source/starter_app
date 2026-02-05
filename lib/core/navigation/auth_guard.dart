import 'package:auto_route/auto_route.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._authChangeNotifier);

  final AuthChangeNotifier _authChangeNotifier;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // Should be authenticated?
    // This guard is applied to specific routes (e.g. Orders)
    // or we can check the path being accessed.

    // In our architecture, we use Opt-In auth for most routes,
    // but some are protected (deepLinkProtectedRoutes).
    // If this guard is attached to a protected route, we must enforce auth.

    if (_authChangeNotifier.isAuthenticated) {
      resolver.next();
    } else {
      // Redirect to Login (AuthRoute)
      // We can pass onResult to resume navigation after login if needed
      // Redirect to Login (AuthRoute)
      router.push(const AuthRoute()).then((success) {
        // Resume navigation if login successful (true)
        resolver.next(success == true);
      });
    }
  }
}

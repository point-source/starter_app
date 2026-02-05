import 'package:auto_route/auto_route.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthChangeNotifier _authChangeNotifier;

  AuthGuard(this._authChangeNotifier);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authChangeNotifier.isAuthenticated) {
      resolver.next();
    } else {
      // Redirect to Dashboard as per requirements
      router.replace(const DashboardRoute());
      resolver.next(false);
    }
  }
}

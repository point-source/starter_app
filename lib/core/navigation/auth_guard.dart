import 'package:auto_route/auto_route.dart';
import 'package:starter_app/core/navigation/app_router.dart';

class AuthGuard extends AutoRouteGuard {
  AuthGuard({required this.isAuthenticated});

  final bool Function() isAuthenticated;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (isAuthenticated()) {
      resolver.next();
    } else {
      resolver.redirect(const AuthRoute());
    }
  }
}

# ADR-0018: auto_route for Navigation

## Status

Accepted

## Context

The project previously used go_router (see [ADR-0004](./0004-go-router-navigation.md)) for navigation. A migration to auto_route was undertaken to leverage its more robust features:

| Solution | Pros | Cons |
|----------|------|------|
| **auto_route** | Full type-safety, built-in guards, nested routers | Heavier, more complex |
| go_router | Declarative, Flutter team backed | Less flexible guards, requires wrapper for type safety |
| Navigator 2.0 raw | Full control | Very complex, lots of boilerplate |

The migration was driven by needs for:
1. **Built-in Route Guards**: auto_route's `AutoRouteGuard` provides cleaner authentication handling
2. **Full Type Safety**: Routes are generated with complete type checking
3. **Nested Routers**: Cleaner shell route patterns for dashboard navigation
4. **Better Test Support**: `StackRouterScope` enables straightforward mocking

## Decision

We adopt **auto_route** with **auto_route_generator** for type-safe navigation with built-in guards.

### Router Configuration

```dart
// lib/core/navigation/app_router.dart
@lazySingleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(this._authChangeNotifier) : super();

  final AuthChangeNotifier _authChangeNotifier;

  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: DashboardShellRoute.page,
      initial: true,
      children: [
        AutoRoute(page: DashboardRoute.page, path: 'dashboard', initial: true),
        AutoRoute(page: ProfileRoute.page, path: 'profile'),
        AutoRoute(page: SettingsRoute.page, path: 'settings'),
        AutoRoute(
          page: OrdersRoute.page,
          path: 'orders',
          guards: [AuthGuard(_authChangeNotifier)],
        ),
      ],
    ),
    CustomRoute<void>(
      page: AuthRoute.page,
      path: '/auth',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      durationInMilliseconds: 400,
    ),
  ];
}
```

### Page Definition

```dart
// Pages are annotated with @RoutePage()
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  // ...
}
```

### Route Guards

```dart
// lib/core/navigation/auth_guard.dart
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._authChangeNotifier);

  final AuthChangeNotifier _authChangeNotifier;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authChangeNotifier.isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(const AuthRoute());
      resolver.next(false);
    }
  }
}
```

### Navigation Patterns

```dart
// Push (stack navigation)
context.router.push(const ProfileRoute());
const ProfileRoute().push<void>(context);

// Replace (no back)
context.router.replace(const DashboardRoute());

// Navigate (declarative)
context.router.navigate(const SettingsRoute());

// Pop (go back)
context.router.pop();
context.router.maybePop();
```

## Consequences

### Positive

- **Type Safety**: Compile-time route validation
- **Built-in Guards**: Clean authentication/authorization patterns
- **Deep Linking**: Works on web and mobile
- **Shell Routes**: Clean nested navigation with `AutoRoute.children`
- **Testability**: `StackRouterScope` enables easy router mocking

### Negative

- **Code Generation**: Required for route classes
- **Learning Curve**: Different API from go_router

### Neutral

- Route transitions configured via `CustomRoute`
- Navigation logging via observers

## References

- [auto_route Documentation](https://pub.dev/packages/auto_route)
- [auto_route_generator](https://pub.dev/packages/auto_route_generator)
- [Superseded: ADR-0004](./0004-go-router-navigation.md)

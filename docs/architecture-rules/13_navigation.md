# Navigation Rules (auto_route)

## Setup

### Router Configuration

**Actual implementation from this starter app:**

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
    // Shell Route (Dashboard with tabs)
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
    // Auth Route (Outside shell)
    CustomRoute<void>(
      page: AuthRoute.page,
      path: '/auth',
      transitionsBuilder: TransitionsBuilders.slideBottom,
      durationInMilliseconds: 400,
    ),
  ];
}
```

**Note**: For authentication redirects, see `AuthGuard` which handles protected route access.

## Type-Safe Routes

### Page Definitions

Pages are annotated with `@RoutePage()`:

```dart
// features/dashboard/presentation/pages/dashboard_page.dart
@RoutePage()
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  // ...
}
```

Routes are auto-generated in `app_router.gr.dart`:

```dart
// Generated route classes
class DashboardRoute extends PageRouteInfo<void> { ... }
class ProfileRoute extends PageRouteInfo<void> { ... }
```

### Navigation Usage

```dart
// Type-safe navigation
context.router.push(const ProfileRoute());
context.router.navigate(const DashboardRoute());

// Using route extension method
const AuthRoute().push<void>(context);
```

## Navigation Patterns

### Push (Stack Navigation)

```dart
// Navigate to new page
context.router.push(const ProfileRoute());

// With result
final result = await context.router.push<bool>(const ConfirmRoute());
if (result == true) {
  // Handle confirmation
}
```

### Replace (No Back)

```dart
context.router.replace(const DashboardRoute());
```

### Navigate (Declarative)

```dart
context.router.navigate(const SettingsRoute());
```

### Pop (Go Back)

```dart
context.router.pop();
context.router.maybePop(); // Safe pop that checks if can pop
context.router.pop(result); // With result
```

## Route Guards

### Authentication Guard

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
      // Redirect to auth page
      router.push(const AuthRoute());
      resolver.next(false);
    }
  }
}
```

### Applying Guards

```dart
AutoRoute(
  page: OrdersRoute.page,
  path: 'orders',
  guards: [AuthGuard(_authChangeNotifier)],
),
```

### Permissions Guard

```dart
class AdminGuard extends AutoRouteGuard {
  AdminGuard(this._userService);
  final UserService _userService;

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_userService.currentUser?.role == UserRole.admin) {
      resolver.next(true);
    } else {
      router.push(const ForbiddenRoute());
      resolver.next(false);
    }
  }
}
```

## Deep Linking

### Query Parameters

```dart
// Define route with parameters
@RoutePage()
class SearchPage extends StatelessWidget {
  const SearchPage({
    @QueryParam() this.q,
    @QueryParam() this.category,
    super.key,
  });

  final String? q;
  final String? category;
}

// Navigate with parameters
context.router.push(SearchRoute(q: 'flutter', category: 'mobile'));
```

## Shell Navigation

### Nested Routes with Shell

**Actual implementation from this starter app:**

```dart
// lib/core/navigation/app_router.dart
@override
List<AutoRoute> get routes => [
  AutoRoute(
    page: DashboardShellRoute.page,
    initial: true,
    children: [
      AutoRoute(page: DashboardRoute.page, path: 'dashboard', initial: true),
      AutoRoute(page: ProfileRoute.page, path: 'profile'),
      AutoRoute(page: SettingsRoute.page, path: 'settings'),
      AutoRoute(page: OrdersRoute.page, path: 'orders', guards: [AuthGuard(...)]),
    ],
  ),
];
```

**Note**: This app uses `AdaptiveNavigationScaffold` in `DashboardShellPage` which automatically switches between bottom navigation (mobile) and navigation rail (desktop/tablet) based on screen size.

## Custom Transitions

```dart
CustomRoute<void>(
  page: AuthRoute.page,
  path: '/auth',
  transitionsBuilder: TransitionsBuilders.slideBottom,
  durationInMilliseconds: 400,
),
```

## Error Handling

Handle navigation errors via the router's error callback or by catching exceptions:

```dart
try {
  await context.router.push(const ProtectedRoute());
} catch (e) {
  // Handle navigation error
}
```

## Testing

### Mocking the Router

```dart
class MockStackRouter extends Mock implements StackRouter {}

testWidgets('navigates on tap', (tester) async {
  final mockRouter = MockStackRouter();
  when(() => mockRouter.push<void>(any())).thenAnswer((_) async {});

  await tester.pumpWidget(
    MaterialApp(
      home: StackRouterScope(
        controller: mockRouter,
        stateHash: 0,
        child: const MyWidget(),
      ),
    ),
  );

  await tester.tap(find.byType(MyButton));
  verify(() => mockRouter.push<void>(any(that: isA<TargetRoute>()))).called(1);
});
```

## Rules

- ✅ Use `@RoutePage()` annotation on all navigable pages
- ✅ Centralize route definitions in `app_router.dart`
- ✅ Use route guards for auth/permissions
- ✅ Handle deep links and query parameters
- ✅ Use `StackRouterScope` for testing navigation
- ❌ Don't use Navigator.push directly
- ❌ Don't bypass route guards

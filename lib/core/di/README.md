# Dependency Injection

This directory contains the dependency injection configuration using Riverpod Providers.

## Overview

The DI system provides:

- **Type-safe dependency injection** via Riverpod
- **Environment-specific dependencies** (development, staging, production)
- **Lifecycle management** (provider, futureProvider, stateNotifierProvider)
- **Feature-based organization** for related dependencies

## Structure

```text
di/
└── providers/                  # Core DI providers
    ├── bloc_providers.dart     # BLoC/Cubit providers
    ├── environment_providers.dart # AppEnvironment provider
    ├── error_providers.dart    # Error reporting (NoOp/Sentry by environment)
    ├── logging_providers.dart  # Logger configuration
    ├── navigation_providers.dart # Router and navigation
    ├── network_providers.dart  # HTTP client, API services
    ├── platform_providers.dart # Platform-specific info
    └── storage_providers.dart  # Local storage, databases
```

Feature-specific providers are located in `lib/features/<feature>/di/`.

## Setup

### 1. Initialize in Bootstrap

```dart
// lib/bootstrap.dart
Future<void> bootstrap<T extends Widget>({
  required AppEnvironment environment,
  required List<Override> overrides,
  required T Function() builder,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create a container to initialize services before running the app
  final container = ProviderContainer(overrides: overrides);

  // Initialize services
  await container.read(bootstrapServiceProvider).initialize(environment);

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: builder(),
    ),
  );
}
```

### 2. Access Dependencies

#### In Widgets

```dart
class MyPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myService = ref.watch(myServiceProvider);
    return ...
  }
}
```

#### In Providers

```dart
@Riverpod(keepAlive: true)
MyUseCase myUseCase(MyUseCaseRef ref) {
  final repository = ref.watch(myRepositoryProvider);
  return MyUseCase(repository);
}
```

## Provider Types

### @Riverpod(keepAlive: true)

Creates a **singleton-like** provider that lives as long as the ProviderScope (app lifetime).

```dart
@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(...);
}
```

**Use for:** Repositories, Services, API Clients.

### @riverpod

Creates an **auto-dispose** provider that is disposed when no longer listened to.

```dart
@riverpod
Future<User> currentUser(CurrentUserRef ref) {
  return ref.watch(authRepositoryProvider).getCurrentUser();
}
```

**Use for:** View Models, ephemeral state, async data fetching.

## Environment-Specific Registration

Use `appEnvironmentProvider` to branch logic based on environment.

```dart
@Riverpod(keepAlive: true)
IErrorReporter errorReporter(ErrorReporterRef ref) {
  final env = ref.watch(appEnvironmentProvider);
  if (env == AppEnvironment.development) {
    return const NoOpErrorReporter();
  } else {
    return SentryErrorReporter(...);
  }
}
```

## Overrides

For dependencies initialized asynchronously (like `SharedPreferences`), use overrides in `main.dart` files.

```dart
// lib/core/di/providers/storage_providers.dart
@Riverpod(keepAlive: true)
SharedPreferences sharedPreferences(SharedPreferencesRef ref) {
  throw UnimplementedError('Initialize via overrides in main');
}

// lib/main_production.dart
final sharedPrefs = await SharedPreferences.getInstance();

await bootstrap(
  overrides: [
    sharedPreferencesProvider.overrideWithValue(sharedPrefs),
  ],
  ...
);
```

## Testing with DI

Use `ProviderScope` with `overrides` to mock dependencies.

```dart
testWidgets('MyWidget test', (tester) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        authRepositoryProvider.overrideWithValue(MockAuthRepository()),
      ],
      child: MyWidget(),
    ),
  );
});
```

## Code Generation

Run build_runner to generate `*.g.dart` files.

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Watch Mode

```bash
dart run build_runner watch --delete-conflicting-outputs
```

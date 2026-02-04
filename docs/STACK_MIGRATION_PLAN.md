# Stack Migration Implementation Plan

Migrate Flutter starter app from **BLoC/get_it/freezed/go_router** to **Riverpod/dart_mappable/auto_route/Drift**.

> [!IMPORTANT]
> This plan is designed for autonomous AI (Jules) execution. Each phase includes explicit file paths, code patterns, and verification commands.

---

## Important Notes

> [!CAUTION]
> **Breaking Changes**: This is a complete state management rewrite. All widget tests and BLoC tests will need migration. The app will not compile between phases.

### Key Decisions:
1. **Phase Order**: Navigation first (lowest risk), then data classes, persistence, state management (highest risk)
2. **Drift for Persistence**: Replaces HydratedBloc
3. **Riverpod Generator**: Use `riverpod_annotation` + `riverpod_generator` for codegen consistency
4. **Dart 3 Sealed Classes**: Replace freezed unions with native sealed classes (no codegen)
5. **Backend**: Not yet implemented — keep as abstract interfaces (ports) in domain layer

---

## Git Branching Strategy

> [!IMPORTANT]
> **Create a separate branch and PR for each phase.** This enables incremental review and safe rollback.

```bash
# Before starting each phase:
git checkout main
git pull origin main
git checkout -b migration/phase-N-description

# After completing phase:
git add .
git commit -m "feat: Phase N - [description]"
git push origin migration/phase-N-description
# Create PR targeting main
```

| Phase | Branch Name | PR Title |
|-------|-------------|----------|
| 1 | `migration/phase-1-auto-route` | `feat: Phase 1 - Migrate navigation to auto_route` |
| 2 | `migration/phase-2-dart-mappable` | `feat: Phase 2 - Migrate data classes to dart_mappable` |
| 3 | `migration/phase-3-drift` | `feat: Phase 3 - Migrate persistence to Drift` |
| 4 | `migration/phase-4-riverpod` | `feat: Phase 4 - Migrate state management to Riverpod` |
| 5 | `migration/phase-5-tests` | `feat: Phase 5 - Update tests for Riverpod` |
| 6 | `migration/phase-6-mason-bricks` | `feat: Phase 6 - Update Mason brick templates` |
| 7 | `migration/phase-7-docs` | `docs: Phase 7 - Update documentation` |

---

## Test Requirements

> [!IMPORTANT]
> **Tests must pass and coverage must be maintained or improved after each phase.**

- Run `very_good test --coverage` after each phase
- If coverage drops, add tests before proceeding
- All existing tests must pass (after migration to new patterns)
- Use the same testing rigor as the original codebase

---

## Current State Analysis

| Category | Current | Count | Migration Target |
|----------|---------|-------|------------------|
| State Management | flutter_bloc, hydrated_bloc | 2 BLoCs, 2 HydratedCubits | Riverpod Notifiers |
| DI | get_it + injectable | 7 modules | Riverpod Providers |
| Navigation | go_router + go_router_builder | 13 files | auto_route |
| Data Classes | freezed | 23 files | dart_mappable + sealed classes |
| Persistence | HydratedBloc | 2 cubits | Drift |
| Tests | bloc_test, mocktail | ~167 tests | riverpod test patterns |

### Files Affected Per Phase:

| Phase | Files to Modify | Files to Delete | New Files |
|-------|-----------------|-----------------|-----------|
| 1. Navigation | ~15 | ~4 | ~8 |
| 2. Data Classes | ~23 | ~23 (.freezed.dart) | ~0 |
| 3. Persistence | ~5 | ~2 | ~4 |
| 4. State Management | ~40 | ~10 | ~15 |
| 5. Tests | ~50 | ~0 | ~5 |
| 6. Mason Bricks | ~6 | ~0 | ~0 |
| 7. Documentation | ~10 | ~0 | ~0 |

---

## Phase 1: Navigation Migration (auto_route)

**Risk Level**: Low ⭐  
**Rationale**: Navigation is independent of state management. Can verify immediately.

---

### Step 1.1: Update Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/pubspec.yaml)

**Remove**:
```yaml
# dependencies:
go_router: ^17.1.0

# dev_dependencies:
go_router_builder: ^4.1.3
```

**Add**:
```yaml
# dependencies:
auto_route: ^10.0.0

# dev_dependencies:
auto_route_generator: ^10.0.0
```

Run: `flutter pub get`

---

### Step 1.2: Create New Router

#### [NEW] [app_router.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/navigation/app_router.dart)

Replace the go_router implementation with auto_route. The existing file has 216 lines; completely rewrite it.

**Pattern to follow**:
```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter({required this.authGuard});

  final AutoRouteGuard authGuard;

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
  RouteType get defaultRouteType => const RouteType.custom(
    transitionsBuilder: TransitionsBuilders.fadeIn,
    durationInMilliseconds: 200,
  );
}
```

---

### Step 1.3: Create Auth Guard

#### [NEW] [auth_guard.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/navigation/auth_guard.dart)

```dart
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
```

---

### Step 1.4: Update Feature Pages with @RoutePage Annotation

Each page needs the `@RoutePage()` annotation. Update these files:

#### [MODIFY] [auth_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/pages/auth_page.dart)

Add at top of class:
```dart
@RoutePage()
class AuthPage extends StatelessWidget { ... }
```

Repeat for:
- [dashboard_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/dashboard/presentation/pages/dashboard_page.dart)
- [profile_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/presentation/pages/profile_page.dart)
- [settings_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/settings/presentation/pages/settings_page.dart)
- [orders_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/orders/presentation/pages/orders_page.dart)

---

### Step 1.5: Create Dashboard Shell for Nested Navigation

#### [NEW] [dashboard_shell_page.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/dashboard/presentation/pages/dashboard_shell_page.dart)

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DashboardShellPage extends StatelessWidget {
  const DashboardShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter.tabBar(
      routes: const [
        DashboardRoute(),
        ProfileRoute(),
        SettingsRoute(),
        OrdersRoute(),
      ],
      builder: (context, child, tabController) {
        return Scaffold(
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: context.tabsRouter.activeIndex,
            onTap: context.tabsRouter.setActiveIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Orders'),
            ],
          ),
        );
      },
    );
  }
}
```

---

### Step 1.6: Update App Entry Point

#### [MODIFY] [app.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/app/view/app.dart)

Replace `GoRouter` with `AppRouter`:

```dart
class App extends StatelessWidget {
  App({super.key}) : _appRouter = AppRouter(
    authGuard: AuthGuard(isAuthenticated: () => /* check auth state */),
  );

  final AppRouter _appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      // ... rest of config
    );
  }
}
```

---

### Step 1.7: Delete Old Navigation Files

#### [DELETE] [app_router.g.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/navigation/app_router.g.dart)
#### [DELETE] [base_route.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/navigation/base_route.dart)
#### [DELETE] Feature route files:
- `lib/features/auth/presentation/routes/auth_routes.dart`
- `lib/features/dashboard/presentation/routes/dashboard_routes.dart`
- `lib/features/profile/presentation/routes/profile_routes.dart`
- `lib/features/settings/presentation/routes/settings_routes.dart`
- `lib/features/orders/presentation/routes/orders_route.dart`

---

### Step 1.8: Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

This generates `app_router.gr.dart`.

---

### Step 1.9: Verification

```bash
# Verify build
flutter analyze
flutter build apk --debug --flavor development --target lib/main_development.dart --dart-define-from-file=config/development.json

# Run navigation-specific tests (if any exist)
very_good test test/core/navigation/
```

**Manual Check**: Launch app and verify:
- Auth page loads on cold start
- After login, dashboard loads with bottom navigation
- Tab switching works
- Logout redirects to auth

---

## Phase 2: Data Classes Migration (dart_mappable + sealed classes)

**Risk Level**: Medium ⭐⭐  
**Rationale**: Freezed is used extensively but changes are mechanical.

---

### Step 2.1: Update Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/pubspec.yaml)

**Remove**:
```yaml
# dependencies:
freezed_annotation: ^3.1.0

# dev_dependencies:
freezed: ^3.2.3
```

**Add**:
```yaml
# dependencies:
dart_mappable: ^4.4.0
fast_immutable_collections: ^11.0.0

# dev_dependencies:
dart_mappable_builder: ^4.4.0
```

---

### Step 2.2: Migrate DTOs to dart_mappable

DTOs are simple data classes with JSON serialization. Migrate each file.

**Example Pattern** - Convert from freezed:
```dart
// BEFORE (freezed)
@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
```

```dart
// AFTER (dart_mappable)
import 'package:dart_mappable/dart_mappable.dart';

part 'user_model.mapper.dart';

@MappableClass()
class UserModel with UserModelMappable {
  const UserModel({
    required this.id,
    required this.email,
  });

  final String id;
  final String email;
}
```

#### Files to migrate (Infrastructure Models):

| File | Location |
|------|----------|
| [user_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/user_model.dart) | `lib/features/auth/infrastructure/models/` |
| [auth_response_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/auth_response_model.dart) | `lib/features/auth/infrastructure/models/` |
| [auth_tokens_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/auth_tokens_model.dart) | `lib/features/auth/infrastructure/models/` |
| [login_request_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/login_request_model.dart) | `lib/features/auth/infrastructure/models/` |
| [register_request_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/register_request_model.dart) | `lib/features/auth/infrastructure/models/` |
| [check_user_exists_request_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/check_user_exists_request_model.dart) | `lib/features/auth/infrastructure/models/` |
| [check_user_exists_response_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/check_user_exists_response_model.dart) | `lib/features/auth/infrastructure/models/` |
| [auth_ws_event_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/infrastructure/models/websocket/auth_ws_event_model.dart) | `lib/features/auth/infrastructure/models/websocket/` |
| [user_profile_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/infrastructure/models/user_profile_model.dart) | `lib/features/profile/infrastructure/models/` |
| [error_model.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/presentation/models/error_model.dart) | `lib/core/presentation/models/` |

---

### Step 2.3: Migrate Failures to Dart 3 Sealed Classes

Failures use freezed unions. Replace with Dart 3 sealed classes.

**Example Pattern** - Convert from freezed union:
```dart
// BEFORE (freezed)
@freezed
sealed class AuthFailure with _$AuthFailure {
  const factory AuthFailure.invalidCredentials() = InvalidCredentials;
  const factory AuthFailure.serverError(String message) = ServerError;
  const factory AuthFailure.networkError() = NetworkError;
}
```

```dart
// AFTER (Dart 3 sealed class - no codegen needed!)
sealed class AuthFailure {
  const AuthFailure();
}

class InvalidCredentials extends AuthFailure {
  const InvalidCredentials();
}

class ServerError extends AuthFailure {
  const ServerError(this.message);
  final String message;
}

class NetworkError extends AuthFailure {
  const NetworkError();
}
```

#### Files to migrate (Failures):

| File | Location |
|------|----------|
| [infrastructure_failures.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/error/failures/infrastructure_failures.dart) | `lib/core/error/failures/` |
| [auth_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/domain/failure/auth_failure.dart) | `lib/features/auth/domain/failure/` |
| [profile_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/domain/failure/profile_failure.dart) | `lib/features/profile/domain/failure/` |
| [unique_id_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/domain/base/unique_id_failure.dart) | `lib/core/domain/base/` |
| [email_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/domain/value_objects/email_failure.dart) | `lib/core/domain/value_objects/` |
| [name_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/domain/value_objects/name_failure.dart) | `lib/core/domain/value_objects/` |
| [password_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/domain/value_objects/password_failure.dart) | `lib/core/domain/value_objects/` |
| [token_failure.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/domain/value_objects/token_failure.dart) | `lib/features/auth/domain/value_objects/` |

---

### Step 2.4: Delete All .freezed.dart Files

Run this command to find and delete:
```bash
find lib -name "*.freezed.dart" -delete
```

Or delete these 23 files individually (list from earlier analysis).

---

### Step 2.5: Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

### Step 2.6: Verification

```bash
flutter analyze
very_good test test/features/auth/infrastructure/
very_good test test/core/domain/
```

---

## Phase 3: Persistence Migration (Drift)

**Risk Level**: Medium ⭐⭐  
**Rationale**: Replaces HydratedBloc storage for theme/locale. Isolated change.

---

### Step 3.1: Update Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/pubspec.yaml)

**Remove**:
```yaml
# dependencies:
hydrated_bloc: ^10.1.1
```

**Add**:
```yaml
# dependencies:
drift: ^2.26.0
sqlite3_flutter_libs: ^0.5.31
path_provider: ^2.1.5  # (already exists)
path: ^1.9.1

# dev_dependencies:
drift_dev: ^2.26.0
```

---

### Step 3.2: Create Drift Database

#### [NEW] [app_database.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/infrastructure/database/app_database.dart)

```dart
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class SettingsTable extends Table {
  TextColumn get key => text()();
  TextColumn get value => text()();

  @override
  Set<Column> get primaryKey => {key};
}

@DriftDatabase(tables: [SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Theme persistence
  Future<String?> getThemeMode() async {
    final result = await (select(settingsTable)
          ..where((t) => t.key.equals('themeMode')))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setThemeMode(String mode) async {
    await into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion.insert(key: 'themeMode', value: mode),
    );
  }

  // Locale persistence
  Future<String?> getLocale() async {
    final result = await (select(settingsTable)
          ..where((t) => t.key.equals('locale')))
        .getSingleOrNull();
    return result?.value;
  }

  Future<void> setLocale(String locale) async {
    await into(settingsTable).insertOnConflictUpdate(
      SettingsTableCompanion.insert(key: 'locale', value: locale),
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'starter_app.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
```

---

### Step 3.3: Run Drift Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

### Step 3.4: Remove HydratedBloc Storage Setup

#### [MODIFY] [bootstrap_service.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/application/bootstrap_service.dart)

Remove these lines:
```dart
// Remove:
import 'package:hydrated_bloc/hydrated_bloc.dart';
HydratedBloc.storage = _storage;
```

#### [DELETE] [storage_module.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/di/modules/storage_module.dart) 

(The HydratedStorage parts - keep flutter_secure_storage if used elsewhere)

---

### Step 3.5: Verification

```bash
flutter analyze
# Drift-specific tests will be added in Phase 5
```

---

## Phase 4: State Management Migration (Riverpod)

**Risk Level**: High ⭐⭐⭐  
**Rationale**: Core architecture change. Most files affected.

---

### Step 4.1: Update Dependencies

#### [MODIFY] [pubspec.yaml](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/pubspec.yaml)

**Remove**:
```yaml
# dependencies:
bloc_concurrency: ^0.3.0
flutter_bloc: ^9.1.1
get_it: ^9.2.0
injectable: ^2.7.1+2

# dev_dependencies:
bloc_lint: ^0.3.5
bloc_test: ^10.0.0
injectable_generator: ^2.9.1
```

**Add**:
```yaml
# dependencies:
flutter_riverpod: ^2.6.1
riverpod_annotation: ^2.6.1

# dev_dependencies:
riverpod_generator: ^2.6.4
riverpod_lint: ^2.6.4
```

---

### Step 4.2: Migrate BLoC States to Dart 3 Sealed Classes

These files already use freezed unions. Convert to Dart 3 sealed classes.

#### [MODIFY] [auth_state.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/bloc/auth_state.dart)

**Current states** (from analysis): Initial, Unauthenticated, RegistrationRequired, LoginRequired, Authenticated

```dart
// AFTER (Dart 3 sealed class)
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

sealed class AuthState {
  const AuthState();
}

class Initial extends AuthState {
  const Initial({
    required this.email,
    required this.isSubmitting,
    required this.validation,
    this.error,
  });

  final EmailAddress email;
  final bool isSubmitting;
  final FieldValidationState validation;
  final ErrorModel? error;

  Initial copyWith({
    EmailAddress? email,
    bool? isSubmitting,
    FieldValidationState? validation,
    ErrorModel? error,
  }) => Initial(
    email: email ?? this.email,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    validation: validation ?? this.validation,
    error: error ?? this.error,
  );
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class RegistrationRequired extends AuthState {
  const RegistrationRequired({
    required this.email,
    required this.password,
    required this.name,
    required this.isSubmitting,
    required this.validation,
    this.passwordVisible = false,
    this.error,
  });

  final EmailAddress email;
  final Password password;
  final Name name;
  final bool isSubmitting;
  final FieldValidationState validation;
  final bool passwordVisible;
  final ErrorModel? error;

  RegistrationRequired copyWith({
    EmailAddress? email,
    Password? password,
    Name? name,
    bool? isSubmitting,
    FieldValidationState? validation,
    bool? passwordVisible,
    ErrorModel? error,
  }) => RegistrationRequired(
    email: email ?? this.email,
    password: password ?? this.password,
    name: name ?? this.name,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    validation: validation ?? this.validation,
    passwordVisible: passwordVisible ?? this.passwordVisible,
    error: error ?? this.error,
  );
}

class LoginRequired extends AuthState {
  const LoginRequired({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.validation,
    this.passwordVisible = false,
    this.error,
  });

  final EmailAddress email;
  final Password password;
  final bool isSubmitting;
  final FieldValidationState validation;
  final bool passwordVisible;
  final ErrorModel? error;

  LoginRequired copyWith({
    EmailAddress? email,
    Password? password,
    bool? isSubmitting,
    FieldValidationState? validation,
    bool? passwordVisible,
    ErrorModel? error,
  }) => LoginRequired(
    email: email ?? this.email,
    password: password ?? this.password,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    validation: validation ?? this.validation,
    passwordVisible: passwordVisible ?? this.passwordVisible,
    error: error ?? this.error,
  );
}

class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;
}
```

Repeat for:
- [profile_state.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/presentation/bloc/profile_state.dart)
- [field_validation_state.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/bloc/field_validation_state.dart)

---

### Step 4.3: Delete Event Files

With Riverpod, events become methods on the Notifier. Delete:

#### [DELETE] [auth_event.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/bloc/auth_event.dart)
#### [DELETE] [auth_event.freezed.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/bloc/auth_event.freezed.dart)
#### [DELETE] [profile_event.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/presentation/bloc/profile_event.dart)
#### [DELETE] [profile_event.freezed.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/profile/presentation/bloc/profile_event.freezed.dart)

---

### Step 4.4: Create Provider Infrastructure

#### [NEW] [providers.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/providers/providers.dart)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/infrastructure/database/app_database.dart';

part 'providers.g.dart';

// Database provider
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  return AppDatabase();
}

// Add other core providers here (ApiClient, SecureStorage, etc.)
```

---

### Step 4.5: Migrate AuthBloc to AuthNotifier

#### [MODIFY] [auth_bloc.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/presentation/bloc/auth_bloc.dart) → Rename to `auth_notifier.dart`

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/features/auth/application/usecases/login.dart';
import 'package:starter_app/features/auth/application/usecases/register.dart';
// ... other imports

part 'auth_notifier.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    // Initialize use cases from providers
    _loginUseCase = ref.read(loginUseCaseProvider);
    _registerUseCase = ref.read(registerUseCaseProvider);
    // ... etc

    // Return initial state
    return Initial(
      email: EmailAddress(''),
      isSubmitting: false,
      validation: const FieldValidationState(),
    );
  }

  late final Login _loginUseCase;
  late final Register _registerUseCase;

  // Convert events to methods
  void emailChanged(String email) {
    // Logic from _onEmailChanged
  }

  void passwordChanged(String password) {
    // Logic from _onPasswordChanged
  }

  Future<void> loginSubmitted() async {
    // Logic from _onLoginSubmitted
    state = (state as LoginRequired).copyWith(isSubmitting: true);
    
    final result = await _loginUseCase.execute(/* params */);
    
    result.fold(
      (failure) => state = (state as LoginRequired).copyWith(
        isSubmitting: false,
        error: ErrorModel.fromFailure(failure),
      ),
      (user) => state = Authenticated(user),
    );
  }

  // ... convert all event handlers to methods
}
```

---

### Step 4.6: Create Use Case Providers

#### [NEW] [auth_providers.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/features/auth/providers/auth_providers.dart)

```dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/features/auth/application/usecases/login.dart';
// ... other imports

part 'auth_providers.g.dart';

@riverpod
Login loginUseCase(Ref ref) {
  return Login(ref.read(authRepositoryProvider));
}

@riverpod
IAuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    ref.read(authRemoteDataSourceProvider),
    ref.read(tokenStorageProvider),
  );
}

// ... etc
```

---

### Step 4.7: Migrate HydratedCubits to Riverpod + Drift

#### [MODIFY] [theme_cubit.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/presentation/bloc/theme_cubit.dart) → Rename to `theme_notifier.dart`

```dart
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/providers/providers.dart';

part 'theme_notifier.g.dart';

@riverpod
class Theme extends _$Theme {
  @override
  Future<ThemeMode> build() async {
    final db = ref.read(appDatabaseProvider);
    final saved = await db.getThemeMode();
    return switch (saved) {
      'dark' => ThemeMode.dark,
      'light' => ThemeMode.light,
      _ => ThemeMode.system,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final db = ref.read(appDatabaseProvider);
    await db.setThemeMode(mode.name);
    state = AsyncData(mode);
  }
}
```

Repeat for `locale_cubit.dart` → `locale_notifier.dart`.

---

### Step 4.8: Update Widgets to Use Riverpod

#### [MODIFY] [app.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/app/view/app.dart)

Wrap with ProviderScope:
```dart
// In main entry point
runApp(
  const ProviderScope(
    child: App(),
  ),
);
```

Convert widgets to ConsumerWidget:
```dart
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp.router(
      themeMode: themeMode.when(
        data: (mode) => mode,
        loading: () => ThemeMode.system,
        error: (_, __) => ThemeMode.system,
      ),
      // ...
    );
  }
}
```

Update all pages that use BlocProvider/BlocBuilder:
- Replace `BlocProvider` with direct provider access via `ref.watch`
- Replace `BlocBuilder` with `Consumer` or `ConsumerWidget`
- Replace `context.read<Bloc>().add(Event)` with `ref.read(notifierProvider.notifier).method()`

---

### Step 4.9: Delete DI Module Files

#### [DELETE] Entire directory: [lib/core/di/](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/lib/core/di/)

Including:
- `injection.dart`
- `injection.config.dart`
- `modules/` directory (7 files)
- `README.md`

---

### Step 4.10: Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

### Step 4.11: Verification

```bash
flutter analyze
very_good test --coverage
```

---

## Phase 5: Test Migration

**Risk Level**: Medium ⭐⭐  
**Rationale**: Tests must be updated to work with Riverpod patterns.

---

### Step 5.1: Update Test Helpers

#### [MODIFY] [pump_app.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/test/helpers/pump_app.dart) (or equivalent)

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    List<Override>? overrides,
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides ?? [],
        child: MaterialApp(
          home: widget,
        ),
      ),
    );
  }
}
```

---

### Step 5.2: Migrate BLoC Tests to Riverpod Tests

**Pattern** - Convert from `bloc_test` to Riverpod testing:

```dart
// BEFORE (bloc_test)
blocTest<AuthBloc, AuthState>(
  'emits [loading, authenticated] when login succeeds',
  build: () => AuthBloc(mockLogin, mockRegister),
  act: (bloc) => bloc.add(const AuthLoginSubmitted()),
  expect: () => [
    isA<AuthState>().having((s) => s.isSubmitting, 'isSubmitting', true),
    isA<Authenticated>(),
  ],
);
```

```dart
// AFTER (Riverpod)
test('emits authenticated when login succeeds', () async {
  final container = ProviderContainer(
    overrides: [
      loginUseCaseProvider.overrideWithValue(mockLogin),
    ],
  );
  addTearDown(container.dispose);

  final notifier = container.read(authProvider.notifier);
  
  // Set up mock
  when(() => mockLogin.execute(any())).thenAnswer(
    (_) async => right(testUser),
  );

  await notifier.loginSubmitted();

  expect(
    container.read(authProvider),
    isA<Authenticated>(),
  );
});
```

---

### Step 5.3: Delete BLoC Test Helpers

#### [DELETE] [test_bloc.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/test/helpers/test_bloc.dart)
#### [DELETE] [fake_auth_bloc.dart](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/integration_test/helpers/fake_auth_bloc.dart)

---

### Step 5.4: Run Full Test Suite

```bash
very_good test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

Target: Maintain 100% coverage.

---

## Phase 6: Mason Bricks Update

Update templates to generate Riverpod-compatible code.

---

### Step 6.1: Update Feature Brick

#### [MODIFY] [bricks/feature/](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/bricks/feature/)

Update templates to:
- Generate providers instead of BLoCs
- Use Dart 3 sealed classes instead of freezed
- Remove injectable annotations

---

### Step 6.2: Update BLoC Brick → Notifier Brick

#### [MODIFY] [bricks/bloc/](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/bricks/bloc/) → Rename/refactor to notifier template

---

## Phase 7: Documentation Update

---

### Step 7.1: Update Core Documentation

#### [MODIFY] [ARCHITECTURE.md](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/ARCHITECTURE.md)

Update:
- State management section: BLoC → Riverpod
- DI section: get_it/injectable → Riverpod providers
- Navigation section: go_router → auto_route
- Data flow diagrams

#### [MODIFY] [README.md](file:///Users/andrew/Documents/Git/GitHub/PointSource/starter_app/README.md)

Update:
- Tech stack table
- Quick start commands
- Dependencies list

---

### Step 7.2: Update ADRs

Add new ADR files or update existing:
- ADR-002: ~~flutter_bloc~~ → Riverpod
- ADR-004: ~~go_router~~ → auto_route  
- ADR-005: ~~injectable + get_it~~ → Riverpod providers
- ADR-008: ~~freezed~~ → dart_mappable + Dart 3 sealed classes

---

## Verification Plan

### Automated Tests

After each phase, run:
```bash
# 1. Code generation
dart run build_runner build --delete-conflicting-outputs

# 2. Static analysis
flutter analyze

# 3. Unit/Widget tests
very_good test --coverage

# 4. Build verification
flutter build apk --debug --flavor development --target lib/main_development.dart --dart-define-from-file=config/development.json
```

### Manual Verification

After Phase 4 (State Management), manually test:

1. **Cold Start**: App should show auth page
2. **Login Flow**: Enter email → password → submit → dashboard appears
3. **Registration Flow**: New user can register
4. **Tab Navigation**: All 4 tabs work, state preserved on switch
5. **Settings Persistence**: 
   - Change theme to dark → kill app → reopen → theme is still dark
   - Change locale → kill app → reopen → locale preserved
6. **Logout**: Returns to auth page, can log in again

---

## Rollback Strategy

If migration fails partway through:

1. Each phase should be committed separately
2. Git tags at each phase completion: `migration/phase-1-navigation`, etc.
3. Can revert to any phase checkpoint

---

## Dependencies Summary

### Final pubspec.yaml dependencies:

```yaml
dependencies:
  auto_route: ^10.0.0
  chopper: ^8.5.0
  dart_mappable: ^4.4.0
  drift: ^2.26.0
  fast_immutable_collections: ^11.0.0
  flex_color_scheme: ^8.4.0
  flutter:
    sdk: flutter
  flutter_localizations:
    sdk: flutter
  flutter_riverpod: ^2.6.1
  flutter_secure_storage: ^10.0.0
  fpdart: ^1.2.0
  http: ^1.6.0
  intl: ^0.20.2
  json_annotation: ^4.9.0
  logging: ^1.3.0
  meta: ^1.16.0
  path: ^1.9.1
  path_provider: ^2.1.5
  riverpod_annotation: ^2.6.1
  sentry_flutter: ^9.9.2
  shared_preferences: ^2.5.4
  sqlite3_flutter_libs: ^0.5.31
  synchronized: ^3.4.0
  url_strategy: ^0.3.0
  uuid: ^4.5.2
  web: ^1.1.1
  web_socket_channel: ^3.0.3

dev_dependencies:
  auto_route_generator: ^10.0.0
  build_runner: ^2.10.4
  chopper_generator: ^8.5.0
  dart_mappable_builder: ^4.4.0
  drift_dev: ^2.26.0
  flutter_test:
    sdk: flutter
  glados: ^1.1.7
  integration_test:
    sdk: flutter
  json_serializable: ^6.11.2
  mocktail: ^1.0.4
  riverpod_generator: ^2.6.4
  riverpod_lint: ^2.6.4
  very_good_analysis: ^10.0.0
```

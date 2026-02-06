# Stack Migration Implementation Plan

> [!IMPORTANT]
> **Base Branch**: `stack_swap` (not main)
> **Approach**: Requirements-focused — document WHAT must work, let AI determine HOW to implement.
> **Tests are the source of truth for verification.**

---

## Guiding Principles

1. **Tests verify correctness** — Existing tests define the expected behavior. All tests must pass after each phase.
2. **Coverage mustbe maintained or improved** — Check coverage BEFORE and AFTER each phase. Never let coverage drop.
3. **Deleting tests is not the same as passing them** — A test may only be deleted if the underlying functionality is no longer required (i.e., requirements changed). Tests cannot be deleted simply because they fail.
4. **Preserve existing functionality and modularity** — The codebase's architecture (Clean Architecture, Hexagonal, DDD) must remain intact.
5. **Preserve flavor-specific behavior** — The app has 3 environments (development, staging, production) with different configurations. Environment-specific DI and behavior must be preserved.
6. **All new code must have docstrings** — Every new public class, method, and function must have documentation.
7. **Modified code with docstrings must have updated docstrings** — If you modify documented code, update the documentation to match.
8. **Update docs, don't delete them** — Documentation files should be updated to reflect changes, not removed.
9. **Backend is abstract** — Backend APIs are not implemented. Keep interfaces (ports) in the domain layer as abstract contracts.
10. **Use latest package versions** — Use the latest versions of all packages that pass dependency resolution. Do not pin to current versions.

---

## Git Branching Strategy

> [!IMPORTANT]
> **Create a separate branch and PR for each phase.** This enables incremental review and safe rollback.

```bash
# Before starting each phase:
git checkout stack_swap
git pull origin stack_swap
git checkout -b migration/phase-N-description

# After completing phase:
git add .
git commit -m "feat: Phase N - [description]"
git push origin migration/phase-N-description
# Create PR targeting stack_swap
```

| Phase | Branch Name | PR Title |
|-------|-------------|----------|
| 1 | `migration/phase-1-auto-route` | `feat: Phase 1 - Migrate navigation to auto_route` |
| 2 | `migration/phase-2-dart-mappable` | `feat: Phase 2 - Migrate data classes to dart_mappable` |
| 3 | `migration/phase-3-riverpod-di` | `feat: Phase 3 - Migrate DI to Riverpod providers` |
| 4 | `migration/phase-4-riverpod-state` | `feat: Phase 4 - Migrate state management to Riverpod` |

---

## Pre-Phase Checklist (Run Before EVERY Phase)

```bash
# 1. Ensure you're on a clean branch from stack_swap
git status  # Should be clean

# 2. Record baseline test count and coverage
flutter test --coverage
# Record: Total tests, passing tests, coverage percentage

# 3. Ensure all tests pass
flutter test  # All tests must pass before starting
```

---

## Phase Completion Requirements

> [!IMPORTANT]
> **Each phase must be self-contained.** When a part of the stack is migrated, the following must also be completed as part of that phase:
>
> - **Tests**: Update or create tests for the migrated functionality
> - **Documentation**: Update relevant docs (README, ARCHITECTURE.md, feature READMEs)
> - **ADRs**: Add Architecture Decision Records for migration decisions
> - **Mason Bricks**: Update any brick templates affected by the migration
> - **Analyzer/Lints**: Resolve all analyzer warnings and lint errors introduced by the changes
>
> The goal is to completely remove the previous packages that were migrated away from, leaving only historical references (e.g., ADRs explaining why a migration happened).

---

## Phase 1: Navigation Migration (auto_route)

**Risk Level**: Low  
**Dependencies to replace**: `go_router`, `go_router_builder` → `auto_route`, `auto_route_generator`

### Current Navigation Functionality (Requirements)

The following behaviors are tested and must continue to work:

| Requirement | Verified By |
|-------------|-------------|
| **Initial Route**: App starts on `/dashboard` for ALL users (authenticated or not) | `lib/core/navigation/route_definitions.dart` |
| **Unprotected Routes**: Dashboard, Profile, Settings, Auth are accessible without login | `RouteDefinitions.unProtectedRoutes` |
| **Deep Link Protected Routes**: Only `/orders` (and similar) require authentication | `RouteDefinitions.deepLinkProtectedRoutes` |
| **Auth Guard Redirect**: Unauthenticated users accessing protected routes are redirected to dashboard | `test/core/navigation/app_router_test.dart` |
| **Opt-in Authentication**: Users navigate to login voluntarily (e.g., Profile → Login) | Current app flow |
| **Return to Home**: Login page has "Return to home" button that returns to dashboard | Auth page UI |
| **Shell Navigation**: Dashboard has tabbed/nested navigation with state preservation | `test/core/navigation/app_router_test.dart` |
| **Navigation Tracking**: Navigation events are tracked/logged | `test/core/navigation/navigation_tracking_service_test.dart` |
| **Custom Page Transitions**: Routes use custom transitions (fade, slide) | `test/core/navigation/page_builder_test.dart` |
| **Reactive Auth Redirects**: Router re-evaluates redirects when auth state changes | `AuthChangeNotifier` + `refreshListenable` |


### Files to Modify/Replace

| Current File | Action | New File (if renamed) |
|--------------|--------|-----------------------|
| `lib/core/navigation/app_router.dart` | Replace | Keep same name |
| `lib/core/navigation/app_router.g.dart` | Delete (will be regenerated as `.gr.dart`) | `app_router.gr.dart` |
| `lib/core/navigation/base_route.dart` | Remove if not needed by auto_route | — |
| `lib/core/navigation/auth_change_notifier.dart` | Review — may need to adapt for auto_route guards | — |
| `lib/core/navigation/page_builder.dart` | Review — auto_route has its own transition system | — |
| Feature route files (`*_routes.dart`) | Migrate or remove in favor of centralized routing | — |

### Dependencies to Change

**Remove**:
- `go_router`
- `go_router_builder`

**Add** (latest versions):
- `auto_route`
- `auto_route_generator` (dev dependency)

### Phase 1 Deliverables

In addition to the migration itself, this phase must include:

- [ ] Update navigation-related tests for auto_route patterns
- [ ] Update `lib/core/navigation/README.md` and `lib/core/navigation/ARCHITECTURE.md`
- [ ] Add ADR: Migration from go_router to auto_route
- [ ] Update any Mason bricks that generate routes
- [ ] Resolve all analyzer warnings related to navigation changes

### Verification

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze  # No warnings or errors
flutter test test/core/navigation/
flutter test --coverage
# Compare coverage to baseline
```

**All 471 lines of `app_router_test.dart` must have equivalent tests passing (or be adapted for auto_route patterns).**

---

## Phase 2: Data Classes Migration (dart_mappable + Dart 3 sealed classes)

**Risk Level**: Medium  
**Dependencies to replace**: `freezed`, `freezed_annotation` → `dart_mappable`, `dart_mappable_builder`, `fast_immutable_collections`, native Dart 3 sealed classes

### Current Data Class Functionality (Requirements)

| Requirement | File Pattern |
|-------------|--------------|
| **JSON Serialization**: DTOs serialize to/from JSON for API requests/responses | `*_model.dart` files in `infrastructure/models/` |
| **Immutability**: All data classes are immutable with `copyWith` support | All freezed classes |
| **Equality**: Value-based equality for domain entities and DTOs | All freezed classes |
| **Union Types (Failures)**: Sealed class hierarchies for failure handling | `*_failure.dart` files |
| **Union Types (States)**: Sealed class hierarchies for BLoC states | `*_state.dart`, `*_event.dart` files (handled in Phase 4) |
| **Pattern Matching**: Code uses `when`/`map` or switch expressions on sealed types | Throughout codebase |

### Files to Migrate

**Infrastructure DTOs** (convert freezed → dart_mappable):
- `lib/features/auth/infrastructure/models/user_model.dart`
- `lib/features/auth/infrastructure/models/auth_response_model.dart`
- `lib/features/auth/infrastructure/models/auth_tokens_model.dart`
- `lib/features/auth/infrastructure/models/login_request_model.dart`
- `lib/features/auth/infrastructure/models/register_request_model.dart`
- `lib/features/auth/infrastructure/models/check_user_exists_request_model.dart`
- `lib/features/auth/infrastructure/models/check_user_exists_response_model.dart`
- `lib/features/auth/infrastructure/models/websocket/auth_ws_event_model.dart`
- `lib/features/profile/infrastructure/models/user_profile_model.dart`
- `lib/core/presentation/models/error_model.dart`

**Domain Failures** (convert freezed → Dart 3 sealed classes, NO codegen needed):
- `lib/core/error/failures/infrastructure_failures.dart`
- `lib/features/auth/domain/failure/auth_failure.dart`
- `lib/features/profile/domain/failure/profile_failure.dart`
- `lib/core/domain/base/unique_id_failure.dart`
- `lib/core/domain/value_objects/email_failure.dart`
- `lib/core/domain/value_objects/name_failure.dart`
- `lib/core/domain/value_objects/password_failure.dart`
- `lib/features/auth/domain/value_objects/token_failure.dart`

### Generated Files to Delete

All `*.freezed.dart` files (23 files total) — these will not be regenerated.

### Dependencies to Change

**Remove**:
- `freezed`
- `freezed_annotation`

**Add** (latest versions):
- `dart_mappable`
- `dart_mappable_builder` (dev dependency)
- `fast_immutable_collections`

### Phase 2 Deliverables

In addition to the migration itself, this phase must include:

- [ ] Update model/failure tests for new patterns
- [ ] Update documentation for data class patterns
- [ ] Add ADR: Migration from freezed to dart_mappable + sealed classes
- [ ] Update Mason bricks that generate models, entities, or value objects
- [ ] Resolve all analyzer warnings related to data class changes

### Verification

```bash
# Delete generated files
find lib -name "*.freezed.dart" -delete

flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze  # No warnings or errors
flutter test test/features/auth/infrastructure/
flutter test test/core/domain/
flutter test test/core/error/
flutter test --coverage
```

---

## Phase 3: Dependency Injection Migration (Riverpod Providers)

**Risk Level**: Medium  
**Dependencies to replace**: `get_it`, `injectable` → `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`

> [!NOTE]
> This phase focuses **only** on replacing the DI layer. BLoCs will continue to work during this phase — they will be provided via Riverpod instead of get_it. The actual BLoC → Notifier migration happens in Phase 4.

### Current DI Functionality (Requirements)

**Dependency Injection** (90 lines of tests in `injection_test.dart`):

| Requirement | Test Coverage |
|-------------|---------------|
| Configures successfully for development environment | Tested |
| Configures successfully for staging environment | Tested |
| Configures successfully for production environment | Tested |
| Environment-specific implementations are used (dev vs prod error reporting) | `error_module.dart` uses `@LazySingleton(env: [...])` |

### DI Modules to Replace with Providers

All files in `lib/core/di/modules/`:
- `bloc_module.dart` — Convert to providers that expose existing BLoCs
- `error_module.dart` (must preserve environment-specific behavior)
- `logging_module.dart`
- `navigation_module.dart`
- `network_module.dart`
- `storage_module.dart`
- `websocket_module.dart`

### Environment-Specific Behavior (CRITICAL)

The current DI uses injectable's `env` parameter to provide different implementations per environment:

```dart
@LazySingleton(env: [AppEnvironment.devEnv])
IErrorReporter get devErrorReporter => ...

@LazySingleton(env: [AppEnvironment.stagingEnv, AppEnvironment.prodEnv])
IErrorReporter get prodErrorReporter => ...
```

**This behavior MUST be preserved** using Riverpod's family providers or conditional logic based on current environment.

### Files to Modify/Delete

- `lib/core/di/injection.dart` — Replace with Riverpod provider setup
- `lib/core/di/injection.config.dart` — Delete (generated by injectable)
- All module files — Convert to provider files or delete if inlined

### Dependencies to Change

**Remove**:
- `get_it`
- `injectable`
- `injectable_generator` (dev)

**Add** (latest versions):
- `flutter_riverpod`
- `riverpod_annotation`
- `riverpod_generator` (dev)
- `riverpod_lint` (dev)

### Phase 3 Deliverables

In addition to the migration itself, this phase must include:

- [ ] Update DI-related tests for Riverpod patterns
- [ ] Wrap app with `ProviderScope`
- [ ] BLoCs are now provided via Riverpod (but still use BlocProvider for widgets)
- [ ] Update `ARCHITECTURE.md` with new DI patterns
- [ ] Update `lib/core/di/README.md` for Riverpod providers
- [ ] Add ADR: Migration from get_it/injectable to Riverpod providers
- [ ] Resolve all analyzer warnings related to DI changes

### Verification

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze  # No warnings or errors
flutter test test/core/di/  # DI tests must pass
flutter test --coverage
```

---

## Phase 4: State Management Migration (Riverpod Notifiers)

**Risk Level**: High  
**Dependencies to replace**: `flutter_bloc`, `bloc_concurrency`, `hydrated_bloc` → Riverpod notifiers

> [!NOTE]
> This phase converts BLoCs/Cubits to Riverpod Notifiers. The DI layer should already be using Riverpod from Phase 3.

### Current State Management Functionality (Requirements)

**AuthBloc** (972 lines of tests in `auth_bloc_test.dart`):

| Requirement | Test Coverage |
|-------------|---------------|
| Initial state with email input form | Tested |
| Email validation (shows error for invalid emails) | Tested |
| Check if user exists → transition to login or registration flow | Tested |
| Password validation | Tested |
| Name validation (for registration) | Tested |
| Login submission → success shows authenticated state | Tested |
| Login submission → failure shows error state | Tested |
| Registration submission → success shows authenticated state | Tested |
| Registration submission → failure shows error state | Tested |
| Logout → returns to unauthenticated state | Tested |
| Session expiration stream handling | Tested |
| Auth state changes stream handling | Tested |
| Concurrent event handling (debounced, throttled, sequential as appropriate) | Uses `bloc_concurrency` |

**ProfileBloc**:
| Requirement | Test Coverage |
|-------------|---------------|
| Load user profile | Tested |
| Update profile fields | Tested |
| Profile loading states | Tested |

**ThemeCubit** (currently HydratedCubit):
| Requirement | Test Coverage |
|-------------|---------------|
| Toggle between light/dark/system | Tested |
| State persists across app restart | Via HydratedBloc |

**LocaleCubit** (currently HydratedCubit):
| Requirement | Test Coverage |
|-------------|---------------|
| Switch between supported locales | Tested |
| State persists across app restart | Via HydratedBloc |

### State Classes to Migrate to Dart 3 Sealed Classes

- `lib/features/auth/presentation/bloc/auth_state.dart`
- `lib/features/auth/presentation/bloc/auth_event.dart` (convert events to notifier methods)
- `lib/features/auth/presentation/bloc/field_validation_state.dart`
- `lib/features/profile/presentation/bloc/profile_state.dart`
- `lib/features/profile/presentation/bloc/profile_event.dart`

### BLoCs to Convert to Riverpod Notifiers

- `AuthBloc` → `AuthNotifier` (using `@riverpod` annotation)
- `ProfileBloc` → `ProfileNotifier`
- `ThemeCubit` → `ThemeNotifier` (use SharedPreferences or similar for persistence)
- `LocaleCubit` → `LocaleNotifier` (use SharedPreferences or similar for persistence)

### Files to Delete

- All `*_event.dart` files (events become methods on notifiers)

### Dependencies to Change

**Remove**:
- `flutter_bloc`
- `bloc_concurrency`
- `hydrated_bloc`
- `bloc_test` (dev)
- `bloc_lint` (dev)

### Phase 4 Deliverables

In addition to the migration itself, this phase must include:

- [ ] Update `test/helpers/pump_app.dart` for Riverpod (`ProviderScope`)
- [ ] Update `test/helpers/mock_helpers.dart` with mock providers
- [ ] Delete `test/helpers/test_bloc.dart` (BLoC-specific helper)
- [ ] Update integration test helpers (convert fake BLoCs to fake notifiers)
- [ ] Update all UI widgets to use `ConsumerWidget` / `ref.watch`
- [ ] Update `ARCHITECTURE.md` with new state management patterns
- [ ] Update `README.md` tech stack table and commands
- [ ] Update `test/README.md` with Riverpod test patterns
- [ ] Add ADR: Migration from BLoC to Riverpod
- [ ] Update Mason bricks (`bricks/bloc/` → `notifier/`, `bricks/feature/` for Riverpod)
- [ ] Test brick generation in `/tmp` and verify generated code
- [ ] Resolve all analyzer warnings related to state management changes

### Verification

```bash
dart run build_runner build --delete-conflicting-outputs
flutter analyze  # No warnings or errors

# This is the critical test — all widget and BLoC tests must pass
flutter test --coverage
```

---

## Post-Migration Verification Checklist

```bash
# Final verification
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter analyze --fatal-infos

# Full test suite
flutter test --coverage

# Build all flavors
flutter build apk --debug --flavor development --target lib/main_development.dart --dart-define-from-file=config/development.json
flutter build apk --debug --flavor staging --target lib/main_staging.dart --dart-define-from-file=config/staging.json
flutter build apk --debug --flavor production --target lib/main_production.dart --dart-define-from-file=config/production.json

# Coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Final Checks

- [ ] All 2311+ tests pass
- [ ] Coverage is >= baseline (check before Phase 1)
- [ ] All 3 flavors build successfully
- [ ] No analyzer warnings or errors
- [ ] All docstrings updated for modified code
- [ ] All documentation updated (not deleted)
- [ ] No tests were deleted unless functionality was intentionally removed
- [ ] All Mason bricks generate code using the new stack
- [ ] ADRs exist for all major migration decisions

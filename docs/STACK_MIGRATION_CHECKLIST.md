# Stack Migration Checklist

> **Branch**: `stack_swap`
> **Target**: Riverpod + dart_mappable + auto_route

---

## Pre-Phase Actions (EVERY Phase)

- [ ] Checkout from `stack_swap` to new branch: `migration/phase-N-description`
- [ ] Run `flutter test --coverage` and record baseline
- [ ] Verify all tests pass before starting

---

## Phase 1: Navigation (auto_route)

### Migration Tasks

- [x] Add `auto_route` and `auto_route_generator` dependencies (latest versions)
- [x] Migrate route definitions to auto_route format
- [x] Migrate auth guard functionality  
- [x] Migrate shell/nested navigation (dashboard tabs)
- [x] Update navigation tracking service for auto_route
- [x] Update page transition configurations
- [x] Remove `go_router` and `go_router_builder` dependencies

### Tests & Documentation

- [x] Update navigation tests for auto_route patterns
- [x] Update `lib/core/navigation/README.md`
- [x] Update `lib/core/navigation/ARCHITECTURE.md`
- [x] Add ADR: Migration from go_router to auto_route
- [x] Update Mason bricks that generate routes (if any)

### Verification

- [x] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] Run `flutter analyze` — no warnings or errors
- [x] Run `flutter test test/core/navigation/` — all pass
- [x] Run `flutter test --coverage` — coverage >= baseline
- [x] Commit, push, create PR

---

## Phase 2: Data Classes (dart_mappable + sealed classes)

### Migration Tasks

- [x] Add `dart_mappable`, `dart_mappable_builder`, `fast_immutable_collections` (latest)
- [x] Migrate DTOs (10 files in `infrastructure/models/`)
- [x] Migrate Failures to Dart 3 sealed classes (8 files)
- [x] Delete all `*.freezed.dart` files
- [x] Remove `freezed` and `freezed_annotation` dependencies

### Tests & Documentation

- [x] Update model/failure tests for new patterns
- [x] Update documentation for data class patterns
- [x] Add ADR: Migration from freezed to dart_mappable + sealed classes
- [x] Update Mason bricks for models, entities, value objects

### Verification

- [x] Run build_runner and verify
- [x] Run `flutter analyze` — no warnings or errors
- [x] Run `flutter test test/features/auth/infrastructure/`
- [x] Run `flutter test test/core/domain/`
- [x] Run `flutter test test/core/error/`
- [x] Coverage >= baseline
- [x] Commit, push, create PR

---

## Phase 3: Dependency Injection (Riverpod Providers)

> **Focus**: Replace get_it/injectable with Riverpod providers. BLoCs continue to work but are provided via Riverpod.

### Migration Tasks

- [ ] Add `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `riverpod_lint` (latest)
- [ ] Create Riverpod providers to replace DI modules
- [ ] Convert `bloc_module.dart` — expose existing BLoCs via Riverpod
- [ ] Convert `error_module.dart` — **preserve environment-specific behavior**
- [ ] Convert `logging_module.dart`
- [ ] Convert `navigation_module.dart`
- [ ] Convert `network_module.dart`
- [ ] Convert `storage_module.dart`
- [ ] Convert `websocket_module.dart`
- [ ] Wrap app with `ProviderScope`
- [ ] Remove `get_it`, `injectable`, `injectable_generator` dependencies
- [ ] Delete `lib/core/di/injection.config.dart`

### Tests & Documentation

- [ ] Update DI tests for Riverpod patterns
- [ ] Update `ARCHITECTURE.md` with new DI patterns
- [ ] Update `lib/core/di/README.md` for Riverpod providers
- [ ] Add ADR: Migration from get_it/injectable to Riverpod providers

### Verification

- [ ] Run build_runner and verify
- [ ] Run `flutter analyze` — no warnings or errors
- [ ] Run `flutter test test/core/di/`
- [ ] Run `flutter test` — ALL tests pass (BLoCs still work via Riverpod)
- [ ] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Phase 4: State Management (Riverpod Notifiers)

> **Focus**: Convert BLoCs/Cubits to Riverpod Notifiers. DI layer already uses Riverpod from Phase 3.

### Migration Tasks

- [ ] Migrate BLoC states to Dart 3 sealed classes
- [ ] Convert `AuthBloc` → `AuthNotifier` (preserve all tested behaviors)
- [ ] Convert `ProfileBloc` → `ProfileNotifier`
- [ ] Convert `ThemeCubit` → `ThemeNotifier` (use SharedPreferences for persistence)
- [ ] Convert `LocaleCubit` → `LocaleNotifier` (use SharedPreferences for persistence)
- [ ] Update all UI widgets to use `ConsumerWidget` / `ref.watch`
- [ ] Delete all `*_event.dart` files (events become notifier methods)
- [ ] Remove `flutter_bloc`, `bloc_concurrency`, `hydrated_bloc`
- [ ] Remove `bloc_test`, `bloc_lint` (dev)

### Tests & Documentation

- [ ] Update `test/helpers/pump_app.dart` for Riverpod
- [ ] Update `test/helpers/mock_helpers.dart` with mock providers
- [ ] Delete `test/helpers/test_bloc.dart` (BLoC-specific helper)
- [ ] Update integration test helpers
- [ ] Verify no tests were deleted (only modified)
- [ ] Update `ARCHITECTURE.md` with new state management patterns
- [ ] Update `README.md` tech stack table and commands
- [ ] Update `test/README.md` with Riverpod test patterns
- [ ] Add ADR: Migration from BLoC to Riverpod

### Mason Bricks

- [ ] Update `bricks/bloc/` → `notifier/` template
- [ ] Update `bricks/feature/` for Riverpod structure
- [ ] Update other bricks as needed (entity, repository, use_case, value_object)
- [ ] Test brick generation in `/tmp`
- [ ] Verify generated code follows new patterns

### Verification

- [ ] Run build_runner and verify
- [ ] Run `flutter analyze` — no warnings or errors
- [ ] Run `flutter test` — ALL tests pass
- [ ] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Final Verification

- [ ] All tests pass (2311+ tests)
- [ ] Coverage >= baseline from before Phase 1
- [ ] All 3 flavors build successfully
- [ ] No analyzer warnings or errors
- [ ] No tests deleted (unless functionality removed)
- [ ] All docstrings present on new/modified code
- [ ] All Mason bricks generate code using the new stack
- [ ] ADRs exist for all major migration decisions

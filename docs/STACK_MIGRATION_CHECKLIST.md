# Stack Migration Checklist

> **Branch**: `stack_swap`
> **Target**: Riverpod + dart_mappable + auto_route + Drift

---

## Pre-Phase Actions (EVERY Phase)

- [ ] Checkout from `stack_swap` to new branch: `migration/phase-N-description`
- [ ] Run `flutter test --coverage` and record baseline
- [ ] Verify all tests pass before starting

---

## Phase 1: Navigation (auto_route)

- [x] Add `auto_route` and `auto_route_generator` dependencies (latest versions)
- [x] Migrate route definitions to auto_route format
- [x] Migrate auth guard functionality  
- [x] Migrate shell/nested navigation (dashboard tabs)
- [x] Update navigation tracking service for auto_route
- [x] Update page transition configurations
- [x] Remove `go_router` and `go_router_builder` dependencies
- [x] Run `dart run build_runner build --delete-conflicting-outputs`
- [x] Run `flutter analyze` — no errors
- [x] Run `flutter test test/core/navigation/` — all pass
- [x] Run `flutter test --coverage` — coverage >= baseline
- [x] Commit, push, create PR

---

## Phase 2: Data Classes (dart_mappable + sealed classes)

- [x] Add `dart_mappable`, `dart_mappable_builder`, `fast_immutable_collections` (latest)
- [x] Migrate DTOs (10 files in `infrastructure/models/`)
- [x] Migrate Failures to Dart 3 sealed classes (8 files)
- [x] Delete all `*.freezed.dart` files
- [ ] Remove `freezed` and `freezed_annotation` dependencies
- [x] Run build_runner and verify
- [x] Run `flutter test test/features/auth/infrastructure/`
- [x] Run `flutter test test/core/domain/`
- [x] Run `flutter test test/core/error/`
- [x] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Phase 3: Persistence (Drift)

- [ ] Add `drift`, `drift_dev`, `sqlite3_flutter_libs` dependencies (latest)
- [ ] Create Drift database for settings persistence
- [ ] Implement theme/locale storage via Drift
- [ ] Update bootstrap to initialize Drift database
- [ ] Verify theme persistence works manually
- [ ] Verify locale persistence works manually
- [ ] Run `flutter test test/core/presentation/`
- [ ] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Phase 4: State Management (Riverpod)

- [ ] Add `flutter_riverpod`, `riverpod_annotation`, `riverpod_generator`, `riverpod_lint` (latest)
- [ ] Migrate BLoC states to Dart 3 sealed classes
- [ ] Convert `AuthBloc` → `AuthNotifier` (preserve all tested behaviors)
- [ ] Convert `ProfileBloc` → `ProfileNotifier`
- [ ] Convert `ThemeCubit` → `ThemeNotifier` (use Drift)
- [ ] Convert `LocaleCubit` → `LocaleNotifier` (use Drift)
- [ ] Create Riverpod providers to replace DI modules
- [ ] **Preserve environment-specific behavior** (dev vs staging vs prod)
- [ ] Update all UI widgets to use `ConsumerWidget` / `ref.watch`
- [ ] Wrap app with `ProviderScope`
- [ ] Remove `flutter_bloc`, `bloc_concurrency`, `get_it`, `injectable`, `hydrated_bloc`
- [ ] Remove `bloc_test`, `bloc_lint`, `injectable_generator` (dev)
- [ ] Delete `lib/core/di/` directory
- [ ] Run build_runner and verify
- [ ] Run `flutter analyze` — no errors
- [ ] Run `flutter test` — ALL tests pass
- [ ] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Phase 5: Tests

- [ ] Update `test/helpers/pump_app.dart` for Riverpod
- [ ] Update `test/helpers/mock_helpers.dart` with mock providers
- [ ] Delete `test/helpers/test_bloc.dart` (BLoC-specific helper)
- [ ] Update integration test helpers
- [ ] Verify all tests pass
- [ ] Verify no tests were deleted (only modified)
- [ ] Coverage >= baseline
- [ ] Commit, push, create PR

---

## Phase 6: Mason Bricks

- [ ] Update `bricks/bloc/` → notifier template
- [ ] Update `bricks/feature/` for Riverpod structure
- [ ] Update other bricks as needed
- [ ] Test brick generation in `/tmp`
- [ ] Verify generated code follows new patterns
- [ ] Commit, push, create PR

---

## Phase 7: Documentation

- [ ] Update `ARCHITECTURE.md`
- [ ] Update `README.md`
- [ ] Update `lib/core/di/README.md` (or relocate)
- [ ] Update `lib/core/navigation/README.md`
- [ ] Update `test/README.md`
- [ ] Add ADRs for migration decisions
- [ ] Verify all docstrings updated for modified code
- [ ] Commit, push, create PR

---

## Final Verification

- [ ] All tests pass (2311+ tests)
- [ ] Coverage >= baseline from before Phase 1
- [ ] All 3 flavors build successfully
- [ ] No analyzer warnings
- [ ] No tests deleted (unless functionality removed)
- [ ] All docstrings present on new/modified code

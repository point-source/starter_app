# Stack Migration Task Checklist

## Overview
Migrate Flutter starter app from:
- **BLoC + get_it/injectable** → **Riverpod**
- **freezed** → **dart_mappable + fast_immutable_collections + Dart 3 sealed classes**
- **go_router + go_router_builder** → **auto_route**
- **HydratedBloc** → **Drift** (for persistence)

---

## Phase 1: Navigation Migration (auto_route)
- [ ] Add auto_route dependencies to pubspec.yaml
- [ ] Create `lib/core/navigation/app_router.dart` with auto_route setup
- [ ] Migrate route definitions from go_router to auto_route format
- [ ] Migrate AuthRoute, DashboardRoute to auto_route
- [ ] Migrate feature routes (profile, settings, orders)
- [ ] Update route guards for auth redirect logic
- [ ] Update shell/nested navigation (StatefulShellRoute → AutoTabsRouter)
- [ ] Remove go_router dependencies
- [ ] Run `dart run build_runner build`
- [ ] Run tests to verify navigation works

## Phase 2: Data Classes Migration (dart_mappable + Dart 3 sealed classes)
- [ ] Add dart_mappable, fast_immutable_collections dependencies
- [ ] Migrate infrastructure DTOs from freezed to dart_mappable
  - [ ] `user_model.dart`
  - [ ] `auth_response_model.dart`
  - [ ] `auth_tokens_model.dart`
  - [ ] `login_request_model.dart`
  - [ ] `register_request_model.dart`
  - [ ] `check_user_exists_request_model.dart`
  - [ ] `check_user_exists_response_model.dart`
  - [ ] `auth_ws_event_model.dart`
  - [ ] `user_profile_model.dart`
- [ ] Migrate Failures to Dart 3 sealed classes
  - [ ] `infrastructure_failures.dart`
  - [ ] `auth_failure.dart`
  - [ ] `profile_failure.dart`
  - [ ] `unique_id_failure.dart`
  - [ ] `email_failure.dart`, `name_failure.dart`, `password_failure.dart`, `token_failure.dart`
- [ ] Migrate presentation models (`error_model.dart`)
- [ ] Delete freezed generated files (*.freezed.dart)
- [ ] Remove freezed/freezed_annotation from pubspec.yaml
- [ ] Run code generation and verify

## Phase 3: Persistence Migration (Drift)
- [ ] Add drift and drift_dev dependencies
- [ ] Create Drift database class with tables for settings
- [ ] Create SettingsDao for theme/locale persistence
- [ ] Create DriftStorageService as replacement for HydratedBloc storage
- [ ] Wire persistence into DI/providers
- [ ] Remove HydratedBloc dependencies

## Phase 4: State Management Migration (Riverpod)
- [ ] Add flutter_riverpod and riverpod_annotation dependencies
- [ ] Create core Riverpod provider infrastructure
  - [ ] `lib/core/di/providers/` directory structure
  - [ ] Core providers (ApiClient, Storage, etc.)
- [ ] Migrate BLoC states to Dart 3 sealed classes
  - [ ] `auth_state.dart`
  - [ ] `auth_event.dart` (convert to methods)
  - [ ] `profile_state.dart`
  - [ ] `profile_event.dart`
  - [ ] `field_validation_state.dart`
- [ ] Migrate BLoCs to Riverpod Notifiers
  - [ ] `AuthBloc` → `AuthNotifier`
  - [ ] `ProfileBloc` → `ProfileNotifier`
  - [ ] `ThemeCubit` → `ThemeNotifier` (with Drift persistence)
  - [ ] `LocaleCubit` → `LocaleNotifier` (with Drift persistence)
- [ ] Update UI to use Riverpod (ConsumerWidget, ref.watch)
  - [ ] Wrap MaterialApp with ProviderScope
  - [ ] Update auth pages
  - [ ] Update profile pages
  - [ ] Update settings pages
  - [ ] Update dashboard pages
- [ ] Remove get_it, injectable, flutter_bloc, hydrated_bloc from pubspec.yaml
- [ ] Delete DI modules directory
- [ ] Run code generation and verify

## Phase 5: Test Migration
- [ ] Update test helpers for Riverpod (ProviderContainer)
- [ ] Migrate bloc_test tests to Riverpod-style tests
- [ ] Update widget tests to use ProviderScope
- [ ] Update integration tests
- [ ] Verify 100% test coverage

## Phase 6: Mason Bricks Update
- [ ] Update `bloc` brick → Riverpod notifier template
- [ ] Update `feature` brick → Riverpod structure
- [ ] Update other bricks as needed
- [ ] Test brick generation

## Phase 7: Documentation & Cleanup
- [ ] Update ARCHITECTURE.md
- [ ] Update README.md
- [ ] Update ADR documents
- [ ] Update architecture-rules docs
- [ ] Final cleanup of unused imports/files

---

## Verification Checkpoints
After each phase, run:
```bash
dart run build_runner build --delete-conflicting-outputs
very_good test --coverage
flutter analyze
```

# Failure Handling Architecture

A **Clean Architecture** compliant system for handling and displaying errors.

## Architecture Overview

This system follows **Hexagonal/Clean Architecture**, **DDD**, and **SOLID** principles:

```text
┌─────────────────────────────────────────────┐
│ UI Layer (Widgets)                          │
│ - Uses ErrorModel + FailureMessageService   │
│ - Has BuildContext for localization         │
└─────────────────┬───────────────────────────┘
                 │
┌─────────────────▼───────────────────────────┐
│ Presentation Layer (BLoC/Cubit)             │
│ - ADAPTER between domain and UI             │
│ - Maps Failure → ErrorModel                 │
│ - Keeps domain layer free of BuildContext   │
└─────────────────┬───────────────────────────┘
                 │
┌─────────────────▼───────────────────────────┐
│ Application Layer (Use Cases)               │
│ - Returns Either<Failure, T>                │
│ - No knowledge of presentation              │
└─────────────────┬───────────────────────────┘
                  │
┌─────────────────▼───────────────────────────┐
│ Domain Layer (Entities, Failures)           │
│ - Pure business logic                       │
│ - Framework agnostic                        │
│ - No BuildContext, no Flutter               │
└─────────────────────────────────────────────┘
```

## Flow: Domain → Presentation → UI

### 1. Domain Layer: Pure Failures

```dart
// lib/features/auth/domain/failure/auth_failure.dart
import 'package:starter_app/core/error/failures/failure.dart';

sealed class AuthFailure extends Failure {
  const AuthFailure();
  
  @override
  bool get isRetryable => false;
}

final class Unauthorized extends AuthFailure {
  const Unauthorized();
}

final class Forbidden extends AuthFailure {
  const Forbidden();
}
```

### 2. Presentation Layer: Failure Mapper

```dart
// Feature-local mapper (example)
@injectable
class AuthFailureMessageMapper extends FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is AuthFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return switch (failure as AuthFailure) {
      Unauthorized() => context.l10n.authUnauthorized,
      Forbidden() => context.l10n.authForbidden,
    };
  }
}
```

### 3. BLoC: Maps at Adapter Boundary

```dart
@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // ... constructor

  Future<void> _onLogin(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    // ...
    final result = await _login(credentials);

    result.fold(
      (failure) {
        // Map domain failure to presentation model HERE (no BuildContext)
        final error = ErrorModel.fromFailure(failure);
        emit(state.copyWith(error: error));
      },
      (user) => add(AuthAuthenticatedEvent(user)),
    );
  }
}
```

### 4. State: Contains View Model

```dart
final class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated({
    required this.email,
    this.error, // ← Presentation model, NOT domain Failure
  });
  
  final EmailAddress email;
  final ErrorModel? error;
}
```

### 5. UI: Displays Message

```dart
BlocConsumer<AuthBloc, AuthState>(
  listener: (context, state) {
    if (state is AuthUnauthenticated && state.error != null) {
      // Get localized message (BuildContext available here!)
      final service = getIt<FailureMessageService>();
      final message = state.error!.getMessage(context, service);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          action: state.error!.isRetryable
              ? SnackBarAction(label: 'Retry', onPressed: _retry)
              : null,
        ),
      );
    }
  },
)
```

## Adding a New Feature

### Example: Profile Feature

### Step 1: Create Domain Failure

```dart
// lib/features/profile/domain/failure/profile_failure.dart
sealed class ProfileFailure extends Failure {
  const ProfileFailure();
}

final class ProfileNotFound extends ProfileFailure {
  const ProfileNotFound();
}

final class ProfileUpdateFailed extends ProfileFailure {
  const ProfileUpdateFailed();
}

// Extension for simple retry logic if needed
extension ProfileFailureX on ProfileFailure {
  bool get isRetryable => switch (this) {
    ProfileNotFound() => false,
    ProfileUpdateFailed() => true,
  };
}
```

### Step 2: Create Presentation Mapper

```dart
@injectable
class ProfileFailureMapper extends FailureMessageMapper {
  @override
  bool canHandle(Failure failure) => failure is ProfileFailure;

  @override
  String map(BuildContext context, Failure failure) {
    return switch (failure as ProfileFailure) {
      ProfileNotFound() => context.l10n.profileNotFound,
      ProfileUpdateFailed() => context.l10n.profileUpdateFailed,
    };
  }
}
```

### Step 3: Run Code Generator

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Step 4: Use in BLoC

```dart
// Standard Either.fold pattern
result.fold(
  (failure) {
    final error = ErrorModel.fromFailure(failure);
    emit(state.copyWith(error: error));
  },
  (profile) => emit(state.copyWith(profile: profile)),
);
```

**That's it!** No changes to core failure infrastructure, and the domain
layer remains free of `BuildContext` and localization details.

## Why This Approach?

### ✅ Clean Architecture Compliance

**Domain Layer:**

- ✅ Pure Dart, no Flutter dependencies
- ✅ No `BuildContext` in domain
- ✅ Failures are business concepts
- ✅ Uses native Dart 3 **sealed classes** (no code generation overhead)

**Application Layer:**

- ✅ Returns `Either<Failure, T>`
- ✅ No knowledge of presentation

**Presentation Layer (BLoC):**

- ✅ Acts as **Adapter** between domain and UI
- ✅ Maps domain failures to view models
- ✅ State contains presentation-ready data

**UI Layer:**

- ✅ Just displays data from state
- ✅ No knowledge of domain failures
- ✅ Has `BuildContext` for localization

### ✅ SOLID Principles

**Open/Closed:** Core code never changes when adding features.
**Dependency Inversion:** Core defines mapper interface.
**Single Responsibility:** Clear separation of business/translation logic.

## Key Files

**Core:**
- `lib/core/error/failures/failure.dart` - Base failure interface
- `lib/core/presentation/failure_message/failure_message_mapper.dart` - Mapper interface
- `lib/core/presentation/services/failure_message_service.dart` - Localized message service
- `lib/core/presentation/models/error_model.dart` - Presentation model

**Infrastructure:**
- `lib/core/presentation/failure_message/infrastructure_failure_mapper.dart` - Infrastructure failure mapper

**Features (Example: Auth):**
- `lib/features/auth/domain/...` - Feature-specific failures (Sealed Classes)
- `lib/features/auth/presentation/bloc/auth_state.dart` - State with `ErrorModel`
- `lib/features/auth/presentation/bloc/auth_bloc.dart` - BLoC that creates `ErrorModel` from `Failure`

## Summary

This architecture ensures:

- **Domain layer** remains pure (no Flutter, no BuildContext)
- **BLoC/Adapter** handles translation at the boundary
- **UI** receives presentation-ready data
- **Features** are independent and auto-discovered
- **No extra dependencies** (Freezed removed in favor of Sealed Classes)

Perfect compliance with Clean Architecture, Hexagonal Architecture, DDD, and SOLID.

# Data Modeling Rules (Dart Mappable & Sealed Classes)

## Core Principles

- All data classes MUST be immutable
- Use `dart_mappable` for **DTOs/Models** (JSON serialization)
- Use **`fast_immutable_collections`** (`IList`, `ISet`, `IMap`) for all collection fields to ensure immutability and deep equality.
- Use **Dart 3 Sealed Classes** for:
  - ✅ **Failures** - Exhaustive matching for error handling
  - ✅ **BLoC Events** - Discriminated unions for event handling
  - ✅ **BLoC States** - Discriminated unions for state handling
- **DO NOT use freezed** (replaced by native features + dart_mappable)
- **DO NOT** use code generation for:
  - ❌ **Entities** - Use plain Dart classes with `Entity`/`AggregateRoot` base class
  - ❌ **Value Objects** - Use `ValueObject` base class with validation

## Data Transfer Objects (dart_mappable)

### Setup

```dart
import 'package:dart_mappable/dart_mappable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

part 'product_model.mapper.dart';

@MappableClass()
class ProductModel with ProductModelMappable {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.description = '',
    this.tags = const [],
  });

  final String id;
  final String name;
  final double price;
  final String description;
  final IList<String> tags;

  // JSON serialization
  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      ProductModelMapper.fromMap(json);
}
```

### Rules for DTOs

- ✅ **DO**: Use `@MappableClass()` annotation
- ✅ **DO**: Mixin `WithClassNameMappable`
- ✅ **DO**: Use standard Dart constructor with named parameters
- ✅ **DO**: Add `part 'filename.mapper.dart';`
- ✅ **DO**: Implement `fromJson` using the generated Mapper
- ❌ **DON'T**: Use `@freezed`

## Union Types (Sealed Classes)

### State Representation (BLoC)

**Example from auth feature:**

```dart
// lib/features/auth/presentation/bloc/auth_state.dart
import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();
}

final class AuthAuthenticated extends AuthState {
  const AuthAuthenticated(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

final class AuthError extends AuthState {
  const AuthError(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

// Usage with switch (exhaustive)
switch (state) {
  case AuthInitial():
    return const LoginScreen();
  case AuthLoading():
    return const LoadingSpinner();
  case AuthAuthenticated(:final user):
    return HomeScreen(user: user);
  case AuthError(:final message):
    return ErrorBanner(message);
}
```

### Failures

**Example:**

```dart
// lib/features/auth/domain/failure/auth_failure.dart
import 'package:starter_app/core/error/failures/failure.dart';

sealed class AuthFailure extends Failure {
  const AuthFailure();
}

final class Unauthorized extends AuthFailure {
  const Unauthorized();
}

final class ServerError extends AuthFailure {
  const ServerError(this.message);
  final String message;
}

// Usage
bool isRetryable(AuthFailure failure) => switch (failure) {
  Unauthorized() => false,
  ServerError() => true,
};
```

### Rules for Sealed Classes

- ✅ **DO**: Use `sealed class BaseName`
- ✅ **DO**: Use `final class SubName extends BaseName`
- ✅ **DO**: Extend `Equatable` for value comparison (if needed)
- ✅ **DO**: Use Dart 3 `switch` expressions for pattern matching
- ❌ **DON'T**: Use `freezed` for unions

## Domain Entity vs DTO Pattern

### Domain Entity (Plain Dart Class)

**CRITICAL: Entities use plain Dart classes**

```dart
class User extends AggregateRoot {
  User({
    required this.id,
    required this.email,
  });

  @override
  final UserId id;
  final EmailAddress email;

  User copyWith({
    UserId? id,
    EmailAddress? email,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
    );
  }
}
```

### DTO/Model (With Serialization)

```dart
@MappableClass()
class UserModel with UserModelMappable {
   // ... implementation details
}
```

### Rules

- ✅ **DO**: Keep domain entities clean (no serialization annotations)
- ✅ **DO**: Use `dart_mappable` only in infrastructure layer (DTOs)
- ❌ **DON'T**: Mix infrastructure concerns into domain entities

## Code Generation

### Commands

```bash
# Generate code
dart run build_runner build --delete-conflicting-outputs
```

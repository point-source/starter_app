# ADR-0008: Immutable Data Classes

## Status

**Superseded** — Superseded by [ADR-019](0019-dart-mappable-and-sealed-classes.md). Originally adopted `freezed`, now migrated to Dart 3 sealed classes + `dart_mappable`.

## Context

Dart requires significant boilerplate for immutable classes:
- `copyWith` methods
- `==` and `hashCode` overrides
- `toString`

I needed code generation for immutable data classes while keeping domain entities as pure Dart classes.

## Decision (Original)

I originally adopted **freezed** for failures, BLoC events/states, and DTOs.

## Decision (Current - Phase 2 Migration)

As of Phase 2 of the stack migration, I now use:

- ✅ **Dart 3 Sealed Classes** for failures (no codegen needed)
- ✅ **Dart 3 Sealed Classes** for BLoC states/events (Phase 4)
- ✅ **dart_mappable** for DTOs/Models (JSON serialization)
- ❌ **Entities** remain plain Dart classes with `Entity` base class

### Why the Migration?

1. **Dart 3 native support**: Sealed classes and switch expressions eliminate need for freezed for union types
2. **Simpler codegen**: `dart_mappable` is lighter-weight than `freezed` for JSON serialization
3. **Better IDE support**: Native Dart patterns have better tooling support
4. **Less generated code**: No `*.freezed.dart` files for failures

### Implementation

```dart
// Failures - Dart 3 sealed class (no codegen)
sealed class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.stackTrace});
}

final class UnauthorizedFailure extends AuthFailure {
  const UnauthorizedFailure({required super.message, super.stackTrace});
}

// Pattern matching with switch expressions
final message = switch (failure) {
  UnauthorizedFailure() => 'Invalid credentials',
  ForbiddenFailure() => 'Access denied',
  _ => 'Unknown error',
};

// DTOs - dart_mappable for JSON
@MappableClass()
class UserModel with UserModelMappable {
  const UserModel({required this.id, required this.email});
  final String id;
  final String email;
}
```

## Consequences

### Positive
- **Less boilerplate**: Automatic copyWith, ==, hashCode via dart_mappable
- **Exhaustive matching**: Compiler ensures all sealed class cases handled
- **Type safety**: Sealed classes for failures and states
- **No freezed dependency**: Simpler build process

### Negative
- **Migration effort**: Required updating tests to use new patterns

### Neutral
- Entities remain pure Dart for DDD semantics

# ADR-0019: Dart Mappable and Sealed Classes

## Status

Accepted

## Context

We previously used `freezed` (ADR-008) for immutable data classes, unions, and JSON serialization. While effective, `freezed` introduced:
1.  **Build time overhead**: Large `*.freezed.dart` files slow down the `build_runner`.
2.  **Complex API**: Custom syntax for unions (`when`, `map`, `maybeMap`) instead of native Dart patterns.
3.  **Dependency weight**: Heavy dependency on `freezed_annotation`.

With the release of Dart 3, generic "sealed classes" and finding a lighter weight alternative for JSON serialization became viable options.

## Decision

We will replace `freezed` with **Dart 3 Sealed Classes** and **dart_mappable**.

### 1. Data Transfer Objects (DTOs) -> dart_mappable

We will use `dart_mappable` for models requiring JSON serialization.

```dart
@MappableClass()
class UserModel with UserModelMappable {
  const UserModel({required this.id, required this.email});
  final String id;
  final String email;
}
```

### 2. Unions (Failures, BLoC Events/States) -> Sealed Classes

We will use native Dart 3 `sealed class` for defining finite sets of subclasses (unions).

```dart
sealed class AuthState {}
final class AuthInitial extends AuthState {}
final class AuthAuthenticated extends AuthState {
  AuthAuthenticated(this.user);
  final User user;
}
```

### 3. Pattern Matching -> Switch Expressions

We will use Dart 3 `switch` expressions instead of `.map()` or `.when()`.

```dart
return switch (state) {
  AuthInitial() => LoginScreen(),
  AuthAuthenticated(:final user) => HomeScreen(user: user),
};
```

### 4. Immutable Collections -> fast_immutable_collections

We will use `fast_immutable_collections` (FIC) to replace the implicit deep equality and immutability provided by `freezed` for collections.

```dart
// Before (freezed List)
final List<String> items;

// After (FIC IList)
final IList<String> items;
```

This ensures:
-   **True Immutability**: Collections cannot be modified after creation.
-   **Deep Equality**: `IList(['a']) == IList(['a'])` returns `true`.
-   **Performance**: Optimized for immutable operations.

## Consequences

### Positive

-   **Native Dart Syntax**: Leverages standard language features (sealed classes, pattern matching) rather than library-specific syntax.
-   **Reduced Build Times**: `dart_mappable` generates smaller files and is generally faster than `freezed`.
-   **Better IDE Support**: Standard classes work better with Refactoring tools than generated mixins.
-   **Future Proof**: Aligns with the direction of the Dart language.

### Negative

-   **Migration Cost**: Significant effort to refactor existing `freezed` code (completed in Phase 2).
-   **Boilerplate**: Slightly more verbose definition for simple data classes compared to `freezed` one-liners (though `dart_mappable` is close).

### Neutral

-   **Code Generation**: Still requires `build_runner` for `dart_mappable`, but the scope is reduced (only DTOs, not failures/events/states).

## References

-   [Dart 3 Class Modifiers](https://dart.dev/language/class-modifiers)
-   [dart_mappable package](https://pub.dev/packages/dart_mappable)
-   [ADR-008: Immutable Data Classes (Superseded)](0008-freezed-immutable-classes.md)

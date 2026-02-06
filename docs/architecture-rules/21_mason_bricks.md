# Mason Bricks - Code Generation Rules

## Overview

This project uses **Mason** for template-based code generation to ensure consistent architecture compliance across all features. See ADR-017 for the decision rationale.

## Available Bricks

| Brick | Purpose | ADRs Applied |
|-------|---------|--------------|
| `feature` | Complete feature scaffold | ADR-001, ADR-002, ADR-008, ADR-010 |
| `use_case` | CQRS Command/Query use cases | ADR-010 |
| `bloc` | BLoC with **Sealed Classes** | ADR-002, ADR-008 |
| `entity` | Domain entity with AggregateRoot | ADR-008 (Ordinary Dart Class) |
| `value_object` | ValueObject with Either validation | ADR-003 |
| `repository` | Repository interface + implementation | ADR-001, ADR-005 |

## Usage

### Initialization

```bash
# First time: install mason_cli globally
dart pub global activate mason_cli

# In project root: get bricks defined in mason.yaml
mason get
```

### Generating Code

```bash
# Generate a complete feature
mason make feature --feature_name payments

# Generate a use case (query or command)
mason make use_case --name GetPayments --feature_name payments --type query

# Generate a BLoC
mason make bloc --name payment_list --feature_name payments
```

## Pattern Enforcement

Each brick enforces architectural patterns from ADRs:

### feature Brick

- **Routes**: Uses `auto_route` via `@RoutePage()` annotation.
- **Models**: Uses `dart_mappable` via `@MappableClass()`.
- **Failures**: Uses Dart 3 `sealed class`.

### BLoC Brick (ADR-002, ADR-008)

Generates BLoC with **Sealed Classes** for events and states (No Freezed):

```dart
// Events (Sealed Class)
sealed class PaymentListEvent {
  const PaymentListEvent();
}

final class PaymentListStarted extends PaymentListEvent {
  const PaymentListStarted();
}
```

### Entity Brick (ADR-008)

Generates **plain Dart class** extending AggregateRoot.

### Value Object Brick (ADR-003)

Generates ValueObject with Either-based validation.

## Post-Generation Steps

After using any brick (especially feature):

1. **Run build_runner** to generate `dart_mappable`, `auto_route`, and `injectable` code:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

2. **Register the Page in AppRouter**:
   - `auto_route` requires adding the generated `Route` to the `AppRouter` routes list.

3. **Verify Imports**: Ensure all generated imports are correct.

## Rules

- ✅ **DO**: Use bricks for new features/components
- ✅ **DO**: Run `mason get` after pulling changes
- ✅ **DO**: Run build_runner after generation
- ❌ **DON'T**: Manually create boilerplate that bricks can generate
- ❌ **DON'T**: Modify files in `bricks/` without updating templates

## References

- [ADR-017: Mason Bricks for Code Generation](../docs/adr/0017-mason-bricks-code-generation.md)
- [Mason Documentation](https://docs.brickhub.dev/)
- [mason.yaml](../mason.yaml) - Project brick configuration

# Architecture Decision Record: Migration to Riverpod Providers for DI

## Status

Accepted

## Context

The application previously used `get_it` and `injectable` for dependency injection. While robust, this approach had several limitations:
- **Service Locator Pattern:** `getIt<T>()` calls could be made anywhere, potentially hiding dependencies.
- **Code Generation Complexity:** `injectable` required complex setup and code generation for modules.
- **Testing Boilerplate:** Mocking dependencies required resetting and re-registering singletons in `getIt`.
- **State Management Disconnect:** State management (BLoC) and DI were separate, leading to boilerplate when connecting them.

We decided to migrate to Riverpod for DI to unify state management and dependency injection, improving testability and modularity.

## Decision

We have replaced `get_it` and `injectable` with **Riverpod Providers**.

### Key Changes

1.  **Providers:**
    -   All services, repositories, and data sources are now exposed via `@Riverpod` providers.
    -   Providers are generated using `riverpod_generator`.
    -   Singleton services use `@Riverpod(keepAlive: true)`.

2.  **Scopes:**
    -   The entire app is wrapped in a `ProviderScope`.
    -   `bootstrap` function now accepts `overrides` for injecting pre-initialized dependencies (e.g., `SharedPreferences`).

3.  **Consumption:**
    -   `ConsumerWidget` and `ConsumerStatefulWidget` are used in UI to access dependencies via `ref.watch`.
    -   Functional providers access dependencies via `ref.watch` in their body.

4.  **Testing:**
    -   `ProviderScope(overrides: [...])` is used to mock dependencies in tests.
    -   `getIt` usage has been removed from tests.

## Consequences

### Positive
-   **Explicit Dependencies:** Dependencies are declared explicitly in provider definitions.
-   **Declarative Overrides:** Testing is simplified with declarative provider overrides.
-   **Unified System:** DI and state management use the same system (Riverpod).
-   **Modularity:** Providers are easily composable and scoped.

### Negative
-   **Migration Effort:** Significant effort to refactor existing code and tests.
-   **Learning Curve:** Team needs to learn Riverpod concepts (if not already familiar).

## Implementation Details

-   Core providers are located in `lib/core/di/providers/`.
-   Feature-specific providers are in `lib/features/<feature>/di/`.
-   `lib/core/di/injection.dart` and `lib/core/di/modules/` have been removed.

import 'package:starter_app/core/error/failures/value_failure.dart';

/// Unique ID validation failures.
///
/// Each variant represents a specific unique ID validation requirement
/// that was not met. Use pattern matching to handle each case:
///
/// ```dart
/// // In UI mapper
/// final message = switch (failure) {
///   UniqueIdEmpty() => context.l10n.uniqueIdRequired,
///   UniqueIdInvalidFormat() => context.l10n.uniqueIdInvalid,
/// };
/// ```
sealed class UniqueIdFailure extends ValueFailure<String> {
  /// Creates a [UniqueIdFailure].
  const UniqueIdFailure();
}

/// Unique ID is empty.
final class UniqueIdEmpty extends UniqueIdFailure {
  /// Creates a [UniqueIdEmpty] failure.
  const UniqueIdEmpty();

  @override
  bool operator ==(Object other) => other is UniqueIdEmpty;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'UniqueIdFailure.empty()';
}

/// Unique ID format is invalid.
final class UniqueIdInvalidFormat extends UniqueIdFailure {
  /// Creates a [UniqueIdInvalidFormat] failure.
  const UniqueIdInvalidFormat();

  @override
  bool operator ==(Object other) => other is UniqueIdInvalidFormat;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'UniqueIdFailure.invalidFormat()';
}

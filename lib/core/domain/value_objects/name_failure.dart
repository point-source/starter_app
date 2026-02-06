import 'package:starter_app/core/error/failures/value_failure.dart';

/// Name validation failures.
///
/// Each variant represents a specific name validation requirement
/// that was not met. Use pattern matching to handle each case:
///
/// ```dart
/// // In UI mapper
/// final message = switch (failure) {
///   NameEmpty() => context.l10n.nameRequired,
///   NameTooLong(:final maxLength) => context.l10n.nameTooLong(maxLength),
/// };
/// ```
sealed class NameFailure extends ValueFailure<String> {
  /// Creates a [NameFailure].
  const NameFailure();
}

/// Name is empty.
final class NameEmpty extends NameFailure {
  /// Creates a [NameEmpty] failure.
  const NameEmpty();

  @override
  bool operator ==(Object other) => other is NameEmpty;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'NameFailure.empty()';
}

/// Name exceeds maximum length.
final class NameTooLong extends NameFailure {
  /// Maximum allowed length.
  final int maxLength;

  /// Actual length of the input.
  final int actualLength;

  /// Creates a [NameTooLong] failure.
  const NameTooLong({
    required this.maxLength,
    required this.actualLength,
  });

  /// Creates a copy with the given fields replaced.
  NameTooLong copyWith({
    int? maxLength,
    int? actualLength,
  }) {
    return NameTooLong(
      maxLength: maxLength ?? this.maxLength,
      actualLength: actualLength ?? this.actualLength,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NameTooLong &&
          maxLength == other.maxLength &&
          actualLength == other.actualLength;

  @override
  int get hashCode => Object.hash(maxLength, actualLength);

  @override
  String toString() =>
      'NameFailure.tooLong(maxLength: $maxLength, actualLength: $actualLength)';
}

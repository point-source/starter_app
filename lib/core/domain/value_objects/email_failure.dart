import 'package:meta/meta.dart';
import 'package:starter_app/core/error/failures/value_failure.dart';

/// Email validation failures.
///
/// Each variant represents a specific email validation requirement
/// that was not met. Use pattern matching to handle each case:
///
/// ```dart
/// // In UI mapper
/// final message = switch (failure) {
///   EmailEmpty() => context.l10n.emailRequired,
///   EmailTooLong(:final maxLength) => context.l10n.emailTooLong(maxLength),
///   EmailInvalidFormat() => context.l10n.emailInvalid,
/// };
/// ```
@immutable
sealed class EmailFailure extends ValueFailure<String> {
  /// Creates an [EmailFailure].
  const EmailFailure();
}

/// Email is empty.
@immutable
final class EmailEmpty extends EmailFailure {
  /// Creates an [EmailEmpty] failure.
  const EmailEmpty();

  @override
  bool operator ==(Object other) => other is EmailEmpty;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'EmailFailure.empty()';
}

/// Email exceeds maximum length.
@immutable
final class EmailTooLong extends EmailFailure {
  /// Creates an [EmailTooLong] failure.
  const EmailTooLong({
    required this.maxLength,
    required this.actualLength,
  });

  /// Maximum allowed length.
  final int maxLength;

  /// Actual length of the input.
  final int actualLength;

  /// Creates a copy with the given fields replaced.
  EmailTooLong copyWith({
    int? maxLength,
    int? actualLength,
  }) {
    return EmailTooLong(
      maxLength: maxLength ?? this.maxLength,
      actualLength: actualLength ?? this.actualLength,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailTooLong &&
          maxLength == other.maxLength &&
          actualLength == other.actualLength;

  @override
  int get hashCode => Object.hash(maxLength, actualLength);

  @override
  String toString() =>
      'EmailFailure.tooLong(maxLength: $maxLength, actualLength: $actualLength)';
}

/// Email format is invalid.
@immutable
final class EmailInvalidFormat extends EmailFailure {
  /// Creates an [EmailInvalidFormat] failure.
  const EmailInvalidFormat({
    required this.failedValue,
  });

  /// The invalid email value.
  final String failedValue;

  /// Creates a copy with the given fields replaced.
  EmailInvalidFormat copyWith({
    String? failedValue,
  }) {
    return EmailInvalidFormat(
      failedValue: failedValue ?? this.failedValue,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailInvalidFormat && failedValue == other.failedValue;

  @override
  int get hashCode => failedValue.hashCode;

  @override
  String toString() => 'EmailFailure.invalidFormat(failedValue: $failedValue)';
}

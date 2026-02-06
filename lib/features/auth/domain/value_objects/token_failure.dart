import 'package:starter_app/core/error/failures/value_failure.dart';

/// Token validation failures.
///
/// Each variant represents a specific token validation requirement
/// that was not met. Use pattern matching to handle each case:
///
/// ```dart
/// // In UI mapper
/// final message = switch (failure) {
///   TokenEmpty() => context.l10n.tokenRequired,
///   TokenTooShort(:final minLength) => context.l10n.tokenTooShort(minLength),
///   TokenInvalidFormat(:final expectedFormat) => context.l10n.tokenInvalid,
///   TokenExpired() => context.l10n.tokenExpired,
/// };
/// ```
sealed class TokenFailure extends ValueFailure<String> {
  /// Creates a [TokenFailure].
  const TokenFailure();
}

/// Token is empty.
final class TokenEmpty extends TokenFailure {
  /// Creates a [TokenEmpty] failure.
  const TokenEmpty();

  @override
  bool operator ==(Object other) => other is TokenEmpty;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'TokenFailure.empty()';
}

/// Token is too short.
final class TokenTooShort extends TokenFailure {
  /// Creates a [TokenTooShort] failure.
  const TokenTooShort({
    required this.minLength,
    required this.actualLength,
  });

  /// Minimum required length.
  final int minLength;

  /// Actual length of the input.
  final int actualLength;

  /// Creates a copy with the given fields replaced.
  TokenTooShort copyWith({
    int? minLength,
    int? actualLength,
  }) {
    return TokenTooShort(
      minLength: minLength ?? this.minLength,
      actualLength: actualLength ?? this.actualLength,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenTooShort &&
          minLength == other.minLength &&
          actualLength == other.actualLength;

  @override
  int get hashCode => Object.hash(minLength, actualLength);

  @override
  String toString() =>
      'TokenFailure.tooShort(minLength: $minLength, actualLength: $actualLength)';
}

/// Token format is invalid.
final class TokenInvalidFormat extends TokenFailure {
  /// Creates a [TokenInvalidFormat] failure.
  const TokenInvalidFormat({
    required this.expectedFormat,
  });

  /// Expected format description.
  final String expectedFormat;

  /// Creates a copy with the given fields replaced.
  TokenInvalidFormat copyWith({
    String? expectedFormat,
  }) {
    return TokenInvalidFormat(
      expectedFormat: expectedFormat ?? this.expectedFormat,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenInvalidFormat && expectedFormat == other.expectedFormat;

  @override
  int get hashCode => expectedFormat.hashCode;

  @override
  String toString() =>
      'TokenFailure.invalidFormat(expectedFormat: $expectedFormat)';
}

/// Token has expired.
final class TokenExpired extends TokenFailure {
  /// Creates a [TokenExpired] failure.
  const TokenExpired();

  @override
  bool operator ==(Object other) => other is TokenExpired;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'TokenFailure.expired()';
}

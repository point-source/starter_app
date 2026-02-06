import 'package:starter_app/core/error/failures/value_failure.dart';

/// Password validation failures.
///
/// Each variant represents a specific password validation requirement
/// that was not met. Use pattern matching to handle each case:
///
/// ```dart
/// // In UI mapper
/// final message = switch (failure) {
///   PasswordEmpty() => context.l10n.passwordRequired,
///   PasswordTooShort(:final minLength) => context.l10n.passwordTooShort(minLength),
///   PasswordTooLong(:final maxLength) => context.l10n.passwordTooLong(maxLength),
///   PasswordMissingUppercase() => context.l10n.passwordMissingUppercase,
///   PasswordMissingLowercase() => context.l10n.passwordMissingLowercase,
///   PasswordMissingDigit() => context.l10n.passwordMissingDigit,
///   PasswordMissingSpecialCharacter() => context.l10n.passwordMissingSpecialChar,
/// };
/// ```
sealed class PasswordFailure extends ValueFailure<String> {
  /// Creates a [PasswordFailure].
  const PasswordFailure();
}

/// Password is empty.
final class PasswordEmpty extends PasswordFailure {
  /// Creates a [PasswordEmpty] failure.
  const PasswordEmpty();

  @override
  bool operator ==(Object other) => other is PasswordEmpty;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'PasswordFailure.empty()';
}

/// Password is too short.
final class PasswordTooShort extends PasswordFailure {
  /// Minimum required length.
  final int minLength;

  /// Actual length of the input.
  final int actualLength;

  /// Creates a [PasswordTooShort] failure.
  const PasswordTooShort({
    required this.minLength,
    required this.actualLength,
  });

  /// Creates a copy with the given fields replaced.
  PasswordTooShort copyWith({
    int? minLength,
    int? actualLength,
  }) {
    return PasswordTooShort(
      minLength: minLength ?? this.minLength,
      actualLength: actualLength ?? this.actualLength,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordTooShort &&
          minLength == other.minLength &&
          actualLength == other.actualLength;

  @override
  int get hashCode => Object.hash(minLength, actualLength);

  @override
  String toString() =>
      'PasswordFailure.tooShort(minLength: $minLength, actualLength: $actualLength)';
}

/// Password is too long.
final class PasswordTooLong extends PasswordFailure {
  /// Maximum allowed length.
  final int maxLength;

  /// Actual length of the input.
  final int actualLength;

  /// Creates a [PasswordTooLong] failure.
  const PasswordTooLong({
    required this.maxLength,
    required this.actualLength,
  });

  /// Creates a copy with the given fields replaced.
  PasswordTooLong copyWith({
    int? maxLength,
    int? actualLength,
  }) {
    return PasswordTooLong(
      maxLength: maxLength ?? this.maxLength,
      actualLength: actualLength ?? this.actualLength,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PasswordTooLong &&
          maxLength == other.maxLength &&
          actualLength == other.actualLength;

  @override
  int get hashCode => Object.hash(maxLength, actualLength);

  @override
  String toString() =>
      'PasswordFailure.tooLong(maxLength: $maxLength, actualLength: $actualLength)';
}

/// Password is missing uppercase letter.
final class PasswordMissingUppercase extends PasswordFailure {
  /// Creates a [PasswordMissingUppercase] failure.
  const PasswordMissingUppercase();

  @override
  bool operator ==(Object other) => other is PasswordMissingUppercase;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'PasswordFailure.missingUppercase()';
}

/// Password is missing lowercase letter.
final class PasswordMissingLowercase extends PasswordFailure {
  /// Creates a [PasswordMissingLowercase] failure.
  const PasswordMissingLowercase();

  @override
  bool operator ==(Object other) => other is PasswordMissingLowercase;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'PasswordFailure.missingLowercase()';
}

/// Password is missing digit.
final class PasswordMissingDigit extends PasswordFailure {
  /// Creates a [PasswordMissingDigit] failure.
  const PasswordMissingDigit();

  @override
  bool operator ==(Object other) => other is PasswordMissingDigit;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'PasswordFailure.missingDigit()';
}

/// Password is missing special character.
final class PasswordMissingSpecialCharacter extends PasswordFailure {
  /// Creates a [PasswordMissingSpecialCharacter] failure.
  const PasswordMissingSpecialCharacter();

  @override
  bool operator ==(Object other) => other is PasswordMissingSpecialCharacter;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'PasswordFailure.missingSpecialCharacter()';
}

import 'package:starter_app/core/error/failures/failures.dart'
    show InfrastructureFailure;
import 'package:starter_app/core/error/failures/infrastructure_failures.dart'
    show InfrastructureFailure;
import 'package:starter_app/core/error/failures/technical_failure.dart';

/// Authentication domain failures.
///
/// Represents business logic errors specific to authentication.
/// Extends [TechnicalFailure] which provides [isRetryable] and [stackTrace].
///
/// Infrastructure failures (network, server, etc.) should use
/// [InfrastructureFailure] instead.
///
/// Example:
/// ```dart
/// // In Repository
/// if (e.statusCode == 401) {
///   return Left(UnauthorizedFailure(message: 'Invalid credentials'));
/// }
/// if (e.statusCode == 403) {
///   return Left(ForbiddenFailure(message: 'Account suspended'));
/// }
/// if (e.statusCode == 404) {
///   return Left(AuthNotFoundFailure(message: 'User not found'));
/// }
/// ```
sealed class AuthFailure extends TechnicalFailure {
  /// Creates an [AuthFailure].
  const AuthFailure();

  /// Returns the error message.
  String get message;
}

/// User or resource not found (HTTP 404).
final class AuthNotFoundFailure extends AuthFailure {
  /// Creates an [AuthNotFoundFailure].
  const AuthNotFoundFailure({
    required this.message,
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  AuthNotFoundFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return AuthNotFoundFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthNotFoundFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthFailure.notFound(message: $message)';
}

/// Invalid credentials or expired session (HTTP 401).
final class UnauthorizedFailure extends AuthFailure {
  /// Creates an [UnauthorizedFailure].
  const UnauthorizedFailure({
    required this.message,
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  UnauthorizedFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return UnauthorizedFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnauthorizedFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthFailure.unauthorized(message: $message)';
}

/// Access denied or account suspended (HTTP 403).
final class ForbiddenFailure extends AuthFailure {
  /// Creates a [ForbiddenFailure].
  const ForbiddenFailure({
    required this.message,
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  ForbiddenFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return ForbiddenFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForbiddenFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthFailure.forbidden(message: $message)';
}

/// Email address is already registered (HTTP 409).
final class EmailAlreadyInUseFailure extends AuthFailure {
  /// Creates an [EmailAlreadyInUseFailure].
  const EmailAlreadyInUseFailure({
    this.message = 'Email already in use',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  EmailAlreadyInUseFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return EmailAlreadyInUseFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmailAlreadyInUseFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthFailure.emailAlreadyInUse(message: $message)';
}

/// Invalid input data (HTTP 400).
final class InvalidInputFailure extends AuthFailure {
  /// Creates an [InvalidInputFailure].
  const InvalidInputFailure({
    required this.message,
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  InvalidInputFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return InvalidInputFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvalidInputFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthFailure.invalidInput(message: $message)';
}

import 'package:meta/meta.dart';
import 'package:starter_app/core/error/failures/technical_failure.dart';

/// Profile domain failures.
///
/// Represents business logic errors specific to user profile operations.
/// Extends [TechnicalFailure] which provides [isRetryable] and [stackTrace].
@immutable
sealed class ProfileFailure extends TechnicalFailure {
  /// Creates a [ProfileFailure].
  const ProfileFailure();

  /// Returns the error message.
  String get message;
}

/// Unexpected error in profile operations.
@immutable
final class ProfileUnexpectedFailure extends ProfileFailure {
  /// Creates a [ProfileUnexpectedFailure].
  const ProfileUnexpectedFailure({
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
  ProfileUnexpectedFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return ProfileUnexpectedFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileUnexpectedFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ProfileFailure.unexpected(message: $message)';
}

/// Server error in profile operations.
@immutable
final class ProfileServerError extends ProfileFailure {
  /// Creates a [ProfileServerError].
  const ProfileServerError({
    required this.message,
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  /// Creates a copy with the given fields replaced.
  ProfileServerError copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return ProfileServerError(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileServerError && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ProfileFailure.serverError(message: $message)';
}

/// Profile not found.
@immutable
final class ProfileNotFoundFailure extends ProfileFailure {
  /// Creates a [ProfileNotFoundFailure].
  const ProfileNotFoundFailure({
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
  ProfileNotFoundFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return ProfileNotFoundFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileNotFoundFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'ProfileFailure.notFound(message: $message)';
}

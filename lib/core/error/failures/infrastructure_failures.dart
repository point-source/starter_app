import 'package:meta/meta.dart';
import 'package:starter_app/core/error/failures/technical_failure.dart';

/// Infrastructure layer failures.
///
/// These represent technical errors from external systems (API, DB, Network).
/// Extends [TechnicalFailure] which provides [isRetryable] and [stackTrace].
///
/// Repositories map Exceptions → InfrastructureFailure when no specific
/// domain mapping is available.
///
/// Example in repository:
/// ```dart
/// try {
///   final product = await _api.getProduct(id);
///   return Right(product);
/// } on ServerException catch (e) {
///   // Map generic server errors
///   return Left(ServerFailure(
///     message: e.message,
///     statusCode: e.statusCode,
///   ));
/// } on NetworkException catch (e) {
///   return Left(NetworkFailure(message: e.message));
/// }
/// ```
///
/// In UI, use FailureMessageService for localized messages:
/// ```dart
/// final messageService = context.read<FailureMessageService>();
/// final message = messageService.getLocalizedMessage(context, failure);
/// ```
@immutable
sealed class InfrastructureFailure extends TechnicalFailure {
  /// Creates an [InfrastructureFailure].
  const InfrastructureFailure();

  /// Returns the error message.
  String get message;
}

/// Server error.
/// Map from ServerException in repository.
@immutable
final class ServerFailure extends InfrastructureFailure {
  /// Creates a [ServerFailure].
  const ServerFailure({
    required this.message,
    this.statusCode,
    this.stackTrace,
  });
  @override
  final String message;

  /// HTTP status code if available.
  final int? statusCode;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  /// Creates a copy with the given fields replaced.
  ServerFailure copyWith({
    String? message,
    int? statusCode,
    StackTrace? stackTrace,
  }) {
    return ServerFailure(
      message: message ?? this.message,
      statusCode: statusCode ?? this.statusCode,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServerFailure &&
          message == other.message &&
          statusCode == other.statusCode;

  @override
  int get hashCode => Object.hash(message, statusCode);

  @override
  String toString() =>
      'InfrastructureFailure.server(message: $message, statusCode: $statusCode)';
}

/// Network error.
/// Map from NetworkException in repository.
@immutable
final class NetworkFailure extends InfrastructureFailure {
  /// Creates a [NetworkFailure].
  const NetworkFailure({
    this.message = 'Network error',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  /// Creates a copy with the given fields replaced.
  NetworkFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return NetworkFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NetworkFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'InfrastructureFailure.network(message: $message)';
}

/// Cache error.
/// Map from CacheException in repository.
@immutable
final class CacheFailure extends InfrastructureFailure {
  /// Creates a [CacheFailure].
  const CacheFailure({
    this.message = 'Cache error',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  CacheFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return CacheFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'InfrastructureFailure.cache(message: $message)';
}

/// Parse error.
/// Map from ParseException in repository.
@immutable
final class ParseFailure extends InfrastructureFailure {
  /// Creates a [ParseFailure].
  const ParseFailure({
    this.message = 'Parse error',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  ParseFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return ParseFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParseFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'InfrastructureFailure.parse(message: $message)';
}

/// Circuit breaker open error.
/// Map from CircuitBreakerException in repository.
@immutable
final class CircuitBreakerFailure extends InfrastructureFailure {
  /// Creates a [CircuitBreakerFailure].
  const CircuitBreakerFailure({
    this.message = 'Service temporarily unavailable',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => true;

  /// Creates a copy with the given fields replaced.
  CircuitBreakerFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return CircuitBreakerFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CircuitBreakerFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() =>
      'InfrastructureFailure.circuitBreaker(message: $message)';
}

/// Unexpected error.
/// Fallback for unknown exceptions that don't match other categories.
@immutable
final class UnexpectedFailure extends InfrastructureFailure {
  /// Creates an [UnexpectedFailure].
  const UnexpectedFailure({
    this.message = 'An unexpected error occurred',
    this.stackTrace,
  });
  @override
  final String message;

  @override
  final StackTrace? stackTrace;

  @override
  bool get isRetryable => false;

  /// Creates a copy with the given fields replaced.
  UnexpectedFailure copyWith({
    String? message,
    StackTrace? stackTrace,
  }) {
    return UnexpectedFailure(
      message: message ?? this.message,
      stackTrace: stackTrace ?? this.stackTrace,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnexpectedFailure && message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'InfrastructureFailure.unexpected(message: $message)';
}

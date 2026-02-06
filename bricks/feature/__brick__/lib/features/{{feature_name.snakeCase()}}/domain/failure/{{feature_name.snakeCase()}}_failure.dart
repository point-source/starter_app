import 'package:starter_app/core/error/failures/technical_failure.dart';

/// {{feature_name.pascalCase()}} domain failures.
///
/// Represents business logic errors specific to {{feature_name.snakeCase()}} operations.
/// Extends [TechnicalFailure] which provides [isRetryable] and [stackTrace].
sealed class {{feature_name.pascalCase()}}Failure extends TechnicalFailure {
  const {{feature_name.pascalCase()}}Failure();

  @override
  bool get isRetryable => switch (this) {
    {{feature_name.pascalCase()}}Unexpected() => false,
    {{feature_name.pascalCase()}}ServerError() => true,
    {{feature_name.pascalCase()}}NotFound() => false,
  };

  @override
  StackTrace? get stackTrace => switch (this) {
    {{feature_name.pascalCase()}}Unexpected(:final stackTrace) => stackTrace,
    {{feature_name.pascalCase()}}ServerError(:final stackTrace) => stackTrace,
    {{feature_name.pascalCase()}}NotFound(:final stackTrace) => stackTrace,
  };
}

final class {{feature_name.pascalCase()}}Unexpected extends {{feature_name.pascalCase()}}Failure {
  const {{feature_name.pascalCase()}}Unexpected({
    required this.message,
    this.stackTrace,
  });
  
  final String message;
  final StackTrace? stackTrace;
}

final class {{feature_name.pascalCase()}}ServerError extends {{feature_name.pascalCase()}}Failure {
  const {{feature_name.pascalCase()}}ServerError({
    required this.message,
    this.stackTrace,
  });
  
  final String message;
  final StackTrace? stackTrace;
}

final class {{feature_name.pascalCase()}}NotFound extends {{feature_name.pascalCase()}}Failure {
  const {{feature_name.pascalCase()}}NotFound({
    required this.message,
    this.stackTrace,
  });
  
  final String message;
  final StackTrace? stackTrace;
}

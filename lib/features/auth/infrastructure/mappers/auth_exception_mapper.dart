import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:starter_app/core/error/exceptions/server_exception.dart';
import 'package:starter_app/core/error/failures/infrastructure_failures.dart';
import 'package:starter_app/core/error/failures/technical_failure.dart';
import 'package:starter_app/core/error/i_exception_mapper.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';

/// Maps [ServerException] to authentication-specific failures.
///
/// This mapper implements [IExceptionMapper] and provides domain-specific
/// mapping for authentication-related HTTP errors.
///
/// Status code mapping:
/// - 401 Unauthorized → [UnauthorizedFailure]
/// - 403 Forbidden → [ForbiddenFailure]
/// - 404 Not Found → [AuthNotFoundFailure]
/// - Other 4xx/5xx → [ServerFailure]
@injectable
final class AuthExceptionMapper implements IExceptionMapper {
  const AuthExceptionMapper();

  @override
  TechnicalFailure mapToFailure(ServerException exception) {
    return switch (exception.statusCode) {
      HttpStatus.badRequest => InvalidInputFailure(
        message: exception.message,
      ),
      HttpStatus.unauthorized => UnauthorizedFailure(
        message: exception.message,
      ),
      HttpStatus.forbidden => ForbiddenFailure(
        message: exception.message,
      ),
      HttpStatus.notFound => AuthNotFoundFailure(
        message: exception.message,
      ),
      HttpStatus.conflict => const EmailAlreadyInUseFailure(),
      _ => ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
    };
  }
}

import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:starter_app/core/error/exceptions/server_exception.dart';
import 'package:starter_app/core/error/failures/infrastructure_failures.dart';
import 'package:starter_app/core/error/failures/technical_failure.dart';
import 'package:starter_app/core/error/i_exception_mapper.dart';
import 'package:starter_app/features/profile/domain/failure/profile_failure.dart';

/// Maps [ServerException] to profile-specific failures.
///
/// This mapper implements [IExceptionMapper] and provides domain-specific
/// mapping for profile-related HTTP errors.
@injectable
final class ProfileExceptionMapper implements IExceptionMapper {
  const ProfileExceptionMapper();

  @override
  TechnicalFailure mapToFailure(ServerException exception) {
    return switch (exception.statusCode) {
      HttpStatus.notFound => ProfileNotFoundFailure(
        message: exception.message,
      ),
      HttpStatus.internalServerError => ProfileServerError(
        message: exception.message,
      ),
      _ => ServerFailure(
        message: exception.message,
        statusCode: exception.statusCode,
      ),
    };
  }
}

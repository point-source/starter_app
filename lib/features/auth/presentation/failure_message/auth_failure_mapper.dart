import 'package:flutter/material.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/presentation/failure_message/failure_message_mapper.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';
import 'package:starter_app/features/auth/infrastructure/mappers/auth_exception_mapper.dart';
import 'package:starter_app/features/auth/l10n/l10n_extensions.dart';

/// Maps auth failures to user-friendly localized messages.
///
/// Named differently from [AuthExceptionMapper] in infrastructure layer
/// to avoid naming conflicts.
class AuthFailureMessageMapper extends FailureMessageMapper {
  const AuthFailureMessageMapper();

  @override
  bool canHandle(Failure failure) => failure is AuthFailure;

  @override
  String map(BuildContext context, Failure failure) {
    final authFailure = failure as AuthFailure;
    return switch (authFailure) {
      UnauthorizedFailure() => context.authL10n.unauthorized,
      ForbiddenFailure() => context.authL10n.forbidden,
      AuthNotFoundFailure() => context.authL10n.notFound,
      EmailAlreadyInUseFailure() => context.authL10n.emailAlreadyInUse,
      InvalidInputFailure() => context.authL10n.invalidInput,
    };
  }
}

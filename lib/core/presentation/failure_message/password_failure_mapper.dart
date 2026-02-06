import 'package:flutter/material.dart';
import 'package:starter_app/core/domain/value_objects/password_failure.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/l10n/l10n_extensions.dart';
import 'package:starter_app/core/presentation/failure_message/failure_message_mapper.dart';

/// Maps password validation failures to user-friendly localized messages.
///
/// Handles [PasswordFailure] types with specific messages for each validation
/// requirement (empty, too short, missing uppercase, etc.).
class PasswordFailureMapper extends FailureMessageMapper {
  /// Creates this mapper.
  const PasswordFailureMapper();

  @override
  bool canHandle(Failure failure) => failure is PasswordFailure;

  @override
  String map(BuildContext context, Failure failure) {
    final passwordFailure = failure as PasswordFailure;
    return switch (passwordFailure) {
      PasswordEmpty() => context.appL10n.passwordEmpty,
      PasswordTooShort(:final minLength) => context.appL10n.passwordTooShort(
        minLength,
      ),
      PasswordTooLong(:final maxLength) => context.appL10n.passwordTooLong(
        maxLength,
      ),
      PasswordMissingUppercase() => context.appL10n.passwordMissingUppercase,
      PasswordMissingLowercase() => context.appL10n.passwordMissingLowercase,
      PasswordMissingDigit() => context.appL10n.passwordMissingDigit,
      PasswordMissingSpecialCharacter() =>
        context.appL10n.passwordMissingSpecialCharacter,
    };
  }
}

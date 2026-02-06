import 'package:flutter/material.dart';
import 'package:starter_app/core/domain/value_objects/email_failure.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/l10n/l10n_extensions.dart';
import 'package:starter_app/core/presentation/failure_message/failure_message_mapper.dart';

/// Maps email validation failures to user-friendly localized messages.
///
/// Handles [EmailFailure] types with specific messages for each validation
/// error (empty, too long, invalid format).
class EmailFailureMapper extends FailureMessageMapper {
  const EmailFailureMapper();

  @override
  bool canHandle(Failure failure) => failure is EmailFailure;

  @override
  String map(BuildContext context, Failure failure) {
    final emailFailure = failure as EmailFailure;
    return switch (emailFailure) {
      EmailEmpty() => context.appL10n.emailEmpty,
      EmailTooLong(:final maxLength) => context.appL10n.emailTooLong(maxLength),
      EmailInvalidFormat() => context.appL10n.emailInvalidFormat,
    };
  }
}

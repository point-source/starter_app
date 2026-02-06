import 'package:flutter/widgets.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/presentation/failure_message/failure_message_mapper.dart';
import 'package:starter_app/features/profile/domain/failure/profile_failure.dart';
import 'package:starter_app/features/profile/l10n/l10n_extensions.dart';

/// Maps profile failures to user-friendly localized messages.
final class ProfileFailureMapper extends FailureMessageMapper {
  const ProfileFailureMapper();

  @override
  bool canHandle(Failure failure) => failure is ProfileFailure;

  @override
  String map(BuildContext context, Failure failure) {
    final l10n = context.profileL10n;
    final profileFailure = failure as ProfileFailure;
    return switch (profileFailure) {
      ProfileUnexpectedFailure() => l10n.unexpectedError,
      ProfileServerError() => l10n.serverError,
      ProfileNotFoundFailure() => l10n.notFound,
    };
  }
}

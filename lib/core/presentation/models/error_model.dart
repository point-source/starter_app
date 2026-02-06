import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/material.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/error/failures/failures.dart'
    show ValueFailure;
import 'package:starter_app/core/error/failures/technical_failure.dart';
import 'package:starter_app/core/error/failures/value_failure.dart'
    show ValueFailure;
import 'package:starter_app/core/presentation/services/failure_message_service.dart';

part 'error_model.mapper.dart';

/// Presentation model for displaying errors in the UI.
///
/// This model wraps a domain Failure and provides UI-friendly access
/// to error information. It acts as a boundary between domain and UI layers.
///
/// The BLoC creates this without needing BuildContext:
/// ```dart
/// // In BLoC (no BuildContext needed!)
/// result.fold(
///   (failure) {
///     final error = ErrorModel.fromFailure(failure);
///     emit(state.copyWith(error: error));
///   },
/// )
/// ```
///
/// The UI gets the localized message:
/// ```dart
/// // In UI (has BuildContext)
/// if (state.error != null) {
///   final service = context.read<FailureMessageService>();
///   final message = state.error!.getMessage(context, service);
///   showSnackBar(message);
/// }
/// ```
@MappableClass()
class ErrorModel with ErrorModelMappable {
  /// Creates an [ErrorModel].
  const ErrorModel({
    required this.failure,
    required this.isRetryable,
  });

  /// Factory to create from a Failure (used by BLoC).
  ///
  /// Only [TechnicalFailure] types (infrastructure, auth) are retryable.
  /// [ValueFailure] types (validation errors) are never retryable since
  /// they require user correction.
  factory ErrorModel.fromFailure(Failure failure) {
    // Only technical failures can be retryable
    final isRetryable = failure is TechnicalFailure && failure.isRetryable;

    return ErrorModel(
      failure: failure,
      isRetryable: isRetryable,
    );
  }

  /// The underlying domain failure.
  final Failure failure;

  /// Whether this error can be retried by the user.
  final bool isRetryable;
}

/// Extension methods for ErrorModel.
extension ErrorModelX on ErrorModel {
  /// Gets the localized error message (called by UI with BuildContext).
  ///
  /// This method delegates to the service to translate the domain failure
  /// to a user-friendly localized message.
  String getMessage(
    BuildContext context,
    FailureMessageService service,
  ) {
    return service.getLocalizedMessage(context, failure);
  }
}

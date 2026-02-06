import 'package:flutter/material.dart';
import 'package:starter_app/core/error/failures/failure.dart';

/// Maps failures to user-friendly messages.
///
/// This is a presentation layer concern - failures in the domain layer
/// remain framework-agnostic and don't know about BuildContext.
///
/// Each feature provides its own mapper implementation to handle
/// feature-specific failures.
abstract class FailureMessageMapper {
  /// Creates this mapper.
  const FailureMessageMapper();

  /// Returns true if this mapper can handle the given failure type.
  bool canHandle(Failure failure);

  /// Maps a failure to a user-friendly message.
  ///
  /// Only called if [canHandle] returns true for this failure.
  String map(BuildContext context, Failure failure);
}

import 'package:dart_mappable/dart_mappable.dart';
import 'package:flutter/foundation.dart';

part 'field_validation_state.mapper.dart';

/// Tracks which form fields have been interacted with (touched/blurred).
///
/// This allows us to show validation errors only for fields the user
/// has interacted with, following best UX practices:
/// - Don't show errors on pristine fields
/// - Show errors only after user leaves the field or submits form
/// - Clear errors when user starts typing (field becomes untouched again)
///
/// The actual validation logic lives in ValueObjects (EmailAddress, Password).
/// This class only tracks UI interaction state.
@immutable
@MappableClass()
class FieldValidationState with FieldValidationStateMappable {
  const FieldValidationState({
    this.emailTouched = false,
    this.passwordTouched = false,
    this.nameTouched = false,
  });

  factory FieldValidationState.initial() => const FieldValidationState();

  factory FieldValidationState.allTouched() => const FieldValidationState(
    emailTouched: true,
    passwordTouched: true,
    nameTouched: true,
  );

  final bool emailTouched;
  final bool passwordTouched;
  final bool nameTouched;
}

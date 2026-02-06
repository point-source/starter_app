import 'package:dart_mappable/dart_mappable.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

part 'auth_state.mapper.dart';

@MappableClass()
sealed class AuthState with AuthStateMappable {
  const AuthState();
}

@MappableClass()
final class AuthInitial extends AuthState with AuthInitialMappable {
  const AuthInitial({
    required this.email,
    required this.isSubmitting,
    required this.validation,
    this.error,
  });

  factory AuthInitial.empty() => AuthInitial(
    email: EmailAddress(''),
    isSubmitting: false,
    validation: FieldValidationState.initial(),
  );

  final EmailAddress email;
  final bool isSubmitting;
  final FieldValidationState validation;
  final ErrorModel? error;
}

@MappableClass()
final class Unauthenticated extends AuthState with UnauthenticatedMappable {
  const Unauthenticated();
}

@MappableClass()
final class RegistrationRequired extends AuthState
    with RegistrationRequiredMappable {
  const RegistrationRequired({
    required this.email,
    required this.password,
    required this.name,
    required this.isSubmitting,
    required this.validation,
    this.passwordVisible = false,
    this.error,
  });

  final EmailAddress email;
  final Password password;
  final Name name;
  final bool isSubmitting;
  final FieldValidationState validation;
  final bool passwordVisible;
  final ErrorModel? error;
}

@MappableClass()
final class LoginRequired extends AuthState with LoginRequiredMappable {
  const LoginRequired({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.validation,
    this.passwordVisible = false,
    this.error,
  });

  final EmailAddress email;
  final Password password;
  final bool isSubmitting;
  final FieldValidationState validation;
  final bool passwordVisible;
  final ErrorModel? error;
}

@MappableClass()
final class Authenticated extends AuthState with AuthenticatedMappable {
  const Authenticated(this.user);
  final User user;
}

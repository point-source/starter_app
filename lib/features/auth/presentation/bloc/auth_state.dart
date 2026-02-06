import 'package:equatable/equatable.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

final class AuthInitial extends AuthState {
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

  @override
  List<Object?> get props => [email, isSubmitting, validation, error];

  AuthInitial copyWith({
    EmailAddress? email,
    bool? isSubmitting,
    FieldValidationState? validation,
    ErrorModel? error,
  }) {
    return AuthInitial(
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validation: validation ?? this.validation,
      error: error ?? this.error,
    );
  }
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}

final class RegistrationRequired extends AuthState {
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

  @override
  List<Object?> get props => [
    email,
    password,
    name,
    isSubmitting,
    validation,
    passwordVisible,
    error,
  ];

  RegistrationRequired copyWith({
    EmailAddress? email,
    Password? password,
    Name? name,
    bool? isSubmitting,
    FieldValidationState? validation,
    bool? passwordVisible,
    ErrorModel? error,
  }) {
    return RegistrationRequired(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validation: validation ?? this.validation,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      error: error ?? this.error,
    );
  }
}

final class LoginRequired extends AuthState {
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

  @override
  List<Object?> get props => [
    email,
    password,
    isSubmitting,
    validation,
    passwordVisible,
    error,
  ];

  LoginRequired copyWith({
    EmailAddress? email,
    Password? password,
    bool? isSubmitting,
    FieldValidationState? validation,
    bool? passwordVisible,
    ErrorModel? error,
  }) {
    return LoginRequired(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validation: validation ?? this.validation,
      passwordVisible: passwordVisible ?? this.passwordVisible,
      error: error ?? this.error,
    );
  }
}

final class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;

  @override
  List<Object?> get props => [user];
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

import 'integration_test_data.dart';

/// Controller to configure [FakeAuthBloc] behavior.
///
/// separating test configuration from the BLoC implementation
/// to satisfy the "avoid public methods on BLoC" linter rule.
class FakeAuthBlocController {
  bool shouldLoginSucceed = true;
  bool shouldRegisterSucceed = true;
  bool shouldUserExist = true;
  bool isUserLoggedIn = false;

  /// Configure fake behavior in a single call.
  void setBehavior({
    bool? loginSucceeds,
    bool? registerSucceeds,
    bool? userExists,
    bool? loggedIn,
  }) {
    shouldLoginSucceed = loginSucceeds ?? shouldLoginSucceed;
    shouldRegisterSucceed = registerSucceeds ?? shouldRegisterSucceed;
    shouldUserExist = userExists ?? shouldUserExist;
    isUserLoggedIn = loggedIn ?? isUserLoggedIn;
  }

  /// Resets to default state.
  void reset() {
    shouldLoginSucceed = true;
    shouldRegisterSucceed = true;
    shouldUserExist = true;
    isUserLoggedIn = false;
  }
}

/// Fake AuthBloc for integration testing.
///
/// Provides controllable authentication behavior without network calls.
/// Simulates real AuthBloc behavior for testing auth flows.
class FakeAuthBloc extends Bloc<AuthEvent, AuthState> implements AuthBloc {
  /// Creates a FakeAuthBloc with optional controller.
  ///
  /// If [controller] is not provided, a default one is created.
  FakeAuthBloc({FakeAuthBlocController? controller})
    : _controller = controller ?? FakeAuthBlocController(),
      super(AuthInitial.empty()) {
    on<AuthGetCurrentUser>(_onGetCurrentUser);
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthEmailSubmitted>(_onEmailSubmitted);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  final FakeAuthBlocController _controller;

  void _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) {
    if (_controller.isUserLoggedIn) {
      emit(Authenticated(IntegrationTestData.user));
    }
  }

  void _onEmailChanged(
    AuthEmailChanged event,
    Emitter<AuthState> emit,
  ) {
    final currentState = state;
    if (currentState is AuthInitial) {
      emit(
        currentState.copyWith(
          email: EmailAddress(event.email),
          validation: currentState.validation.copyWith(emailTouched: true),
        ),
      );
    }
  }

  void _onPasswordChanged(
    AuthPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    final currentState = state;
    if (currentState is LoginRequired) {
      emit(
        currentState.copyWith(
          password: Password(event.password),
          validation: currentState.validation.copyWith(passwordTouched: true),
        ),
      );
    } else if (currentState is RegistrationRequired) {
      emit(
        currentState.copyWith(
          password: Password(event.password),
          validation: currentState.validation.copyWith(passwordTouched: true),
        ),
      );
    }
  }

  void _onNameChanged(
    AuthNameChanged event,
    Emitter<AuthState> emit,
  ) {
    final currentState = state;
    if (currentState is RegistrationRequired) {
      emit(
        currentState.copyWith(
          name: Name(event.name),
          validation: currentState.validation.copyWith(nameTouched: true),
        ),
      );
    }
  }

  Future<void> _onEmailSubmitted(
    AuthEmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is AuthInitial) {
      final email = currentState.email;
      if (email.isValid) {
        emit(currentState.copyWith(isSubmitting: true));

        // Simulate network delay
        await Future<void>.delayed(const Duration(milliseconds: 100));

        if (_controller.shouldUserExist) {
          // User exists - go to login
          emit(
            LoginRequired(
              email: email,
              password: Password(''),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          );
        } else {
          // New user - go to registration
          emit(
            RegistrationRequired(
              email: email,
              password: Password(''),
              name: Name(''),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          );
        }
      } else {
        emit(
          currentState.copyWith(
            validation: currentState.validation.copyWith(emailTouched: true),
          ),
        );
      }
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is LoginRequired) {
      emit(currentState.copyWith(isSubmitting: true));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      if (_controller.shouldLoginSucceed) {
        _controller.isUserLoggedIn = true;
        emit(Authenticated(IntegrationTestData.user));
      } else {
        emit(
          currentState.copyWith(
            isSubmitting: false,
            error: ErrorModel.fromFailure(
              const UnauthorizedFailure(
                message: 'Invalid credentials',
              ),
            ),
          ),
        );
      }
    }
  }

  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final currentState = state;
    if (currentState is RegistrationRequired) {
      emit(currentState.copyWith(isSubmitting: true));

      await Future<void>.delayed(const Duration(milliseconds: 100));

      if (_controller.shouldRegisterSucceed) {
        _controller.isUserLoggedIn = true;
        emit(Authenticated(IntegrationTestData.user));
      } else {
        emit(
          currentState.copyWith(
            isSubmitting: false,
            error: ErrorModel.fromFailure(
              const EmailAlreadyInUseFailure(),
            ),
          ),
        );
      }
    }
  }

  void _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    _controller.isUserLoggedIn = false;
    emit(const Unauthenticated());
  }
}

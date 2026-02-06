import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/presentation/models/error_model.dart';
import 'package:starter_app/features/auth/application/usecases/check_user_exists.dart';
import 'package:starter_app/features/auth/application/usecases/get_current_user.dart';
import 'package:starter_app/features/auth/application/usecases/login.dart';
import 'package:starter_app/features/auth/application/usecases/logout.dart';
import 'package:starter_app/features/auth/application/usecases/register.dart';
import 'package:starter_app/features/auth/application/usecases/watch_auth_changes.dart';
import 'package:starter_app/features/auth/application/usecases/watch_session_expired.dart';
import 'package:starter_app/features/auth/domain/entities/auth_credentials.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    this._checkUserExists,
    this._login,
    this._register,
    this._logout,
    this._getCurrentUser,
    this._watchAuthChanges,
    this._watchSessionExpired,
    this._logger,
  ) : super(AuthInitial.empty()) {
    on<AuthGetCurrentUser>(_onGetCurrentUser);
    on<AuthWatchStarted>(_onAuthWatchStarted, transformer: restartable());
    on<AuthSessionWatchStarted>(
      _onSessionWatchStarted,
      transformer: restartable(),
    );
    on<AuthEmailChanged>(_onEmailChanged);
    on<AuthPasswordChanged>(_onPasswordChanged);
    on<AuthNameChanged>(_onNameChanged);
    on<AuthEmailUnfocused>(_onEmailUnfocused);
    on<AuthPasswordUnfocused>(_onPasswordUnfocused);
    on<AuthNameUnfocused>(_onNameUnfocused);
    on<AuthEmailSubmitted>(_onEmailSubmitted);
    on<AuthLoginSubmitted>(_onLoginSubmitted);
    on<AuthRegisterSubmitted>(_onRegisterSubmitted);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthUserChanged>(_onAuthUserChanged);
    on<AuthSessionExpired>(_onSessionExpired);
    on<AuthTogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  final CheckUserExists _checkUserExists;
  final Login _login;
  final Register _register;
  final Logout _logout;
  final GetCurrentUser _getCurrentUser;
  final WatchAuthChanges _watchAuthChanges;
  final WatchSessionExpired _watchSessionExpired;
  final IAppLogger _logger;

  Future<void> _onAuthWatchStarted(
    AuthWatchStarted event,
    Emitter<AuthState> emit,
  ) async {
    await emit.onEach<Either<Failure, User?>>(
      _watchAuthChanges(),
      onData: (result) => result.fold(
        (failure) {
          _logger.error(failure.toString());
          add(const AuthUserChanged(null));
        },
        (user) {
          add(AuthUserChanged(user));
        },
      ),
    );
  }

  Future<void> _onSessionWatchStarted(
    AuthSessionWatchStarted event,
    Emitter<AuthState> emit,
  ) async {
    await emit.onEach<void>(
      _watchSessionExpired(),
      onData: (_) => add(const AuthSessionExpired()),
    );
  }

  Future<void> _onGetCurrentUser(
    AuthGetCurrentUser event,
    Emitter<AuthState> emit,
  ) async {
    add(const AuthSessionWatchStarted());

    final result = await _getCurrentUser.call();
    result.fold(
      (failure) {
        _logger.warning('Failed to get current user: $failure');
        emit(AuthInitial.empty());
      },
      (user) {
        if (user != null) {
          emit(Authenticated(user));
          add(const AuthWatchStarted());
        } else {
          emit(AuthInitial.empty());
        }
      },
    );
  }

  void _onEmailChanged(AuthEmailChanged event, Emitter<AuthState> emit) {
    switch (state) {
      case final AuthInitial s:
        emit(
          s.copyWith(
            email: EmailAddress(event.email),
            validation: s.validation.copyWith(emailTouched: false),
          ),
        );
      case LoginRequired _:
        _resetToInitialIfEmpty(event.email, emit);
      case RegistrationRequired _:
        _resetToInitialIfEmpty(event.email, emit);
      default:
        break;
    }
  }

  void _resetToInitialIfEmpty(String email, Emitter<AuthState> emit) {
    if (email.isEmpty) {
      emit(AuthInitial.empty());
    }
  }

  void _onPasswordChanged(AuthPasswordChanged event, Emitter<AuthState> emit) {
    _updatePasswordField(Password(event.password), emit);
  }

  void _updatePasswordField(Password password, Emitter<AuthState> emit) {
    switch (state) {
      case final LoginRequired s:
        emit(
          s.copyWith(
            password: password,
            validation: s.validation.copyWith(passwordTouched: false),
          ),
        );
      case final RegistrationRequired s:
        emit(
          s.copyWith(
            password: password,
            validation: s.validation.copyWith(passwordTouched: false),
          ),
        );
      default:
        break;
    }
  }

  void _onNameChanged(AuthNameChanged event, Emitter<AuthState> emit) {
    final s = state;
    if (s is RegistrationRequired) {
      emit(
        s.copyWith(
          name: Name(event.name),
          validation: s.validation.copyWith(nameTouched: false),
        ),
      );
    }
  }

  void _onTogglePasswordVisibility(
    AuthTogglePasswordVisibility event,
    Emitter<AuthState> emit,
  ) {
    switch (state) {
      case final LoginRequired s:
        emit(s.copyWith(passwordVisible: !s.passwordVisible));
      case final RegistrationRequired s:
        emit(s.copyWith(passwordVisible: !s.passwordVisible));
      default:
        break;
    }
  }

  void _onEmailUnfocused(AuthEmailUnfocused event, Emitter<AuthState> emit) {
    _markFieldTouched(emit, emailTouched: true);
  }

  void _onPasswordUnfocused(
    AuthPasswordUnfocused event,
    Emitter<AuthState> emit,
  ) {
    _markFieldTouched(emit, passwordTouched: true);
  }

  void _onNameUnfocused(AuthNameUnfocused event, Emitter<AuthState> emit) {
    _markFieldTouched(emit, nameTouched: true);
  }

  void _markFieldTouched(
    Emitter<AuthState> emit, {
    bool emailTouched = false,
    bool passwordTouched = false,
    bool nameTouched = false,
  }) {
    switch (state) {
      case final AuthInitial s:
        if (emailTouched) {
          emit(
            s.copyWith(
              validation: s.validation.copyWith(emailTouched: true),
            ),
          );
        }
      case final LoginRequired s:
        emit(
          s.copyWith(
            validation: s.validation.copyWith(
              emailTouched: emailTouched || s.validation.emailTouched,
              passwordTouched: passwordTouched || s.validation.passwordTouched,
            ),
          ),
        );
      case final RegistrationRequired s:
        emit(
          s.copyWith(
            validation: s.validation.copyWith(
              emailTouched: emailTouched || s.validation.emailTouched,
              passwordTouched: passwordTouched || s.validation.passwordTouched,
              nameTouched: nameTouched || s.validation.nameTouched,
            ),
          ),
        );
      default:
        break;
    }
  }

  Future<void> _onEmailSubmitted(
    AuthEmailSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final s = state;
    if (s is AuthInitial) {
      if (!s.email.isValid) {
        emit(
          s.copyWith(validation: s.validation.copyWith(emailTouched: true)),
        );
        return;
      }

      emit(s.copyWith(isSubmitting: true));

      final result = await _checkUserExists(s.email);

      result.fold(
        (failure) => emit(
          s.copyWith(
            isSubmitting: false,
            error: ErrorModel.fromFailure(failure),
          ),
        ),
        (exists) {
          if (exists) {
            emit(
              LoginRequired(
                email: s.email,
                password: Password(''),
                isSubmitting: false,
                validation: FieldValidationState.initial(),
              ),
            );
          } else {
            emit(
              RegistrationRequired(
                email: s.email,
                password: Password(''),
                name: Name(''),
                isSubmitting: false,
                validation: FieldValidationState.initial(),
              ),
            );
          }
        },
      );
    }
  }

  Future<void> _onLoginSubmitted(
    AuthLoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final s = state;
    if (s is LoginRequired) {
      final credentials = AuthCredentials(
        email: s.email,
        password: s.password,
      );
      if (!credentials.isValidForLogin) {
        emit(
          s.copyWith(
            validation: FieldValidationState.allTouched(),
          ),
        );
        return;
      }

      emit(s.copyWith(isSubmitting: true));

      final result = await _login(credentials);

      result.fold(
        (failure) => emit(
          s.copyWith(
            isSubmitting: false,
            error: ErrorModel.fromFailure(failure),
            validation: FieldValidationState.allTouched(),
          ),
        ),
        (user) => _handleAuthSuccess(user, emit),
      );
    }
  }

  Future<void> _onRegisterSubmitted(
    AuthRegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final s = state;
    if (s is RegistrationRequired) {
      final credentials = AuthCredentials(
        email: s.email,
        password: s.password,
        name: s.name,
      );
      if (!credentials.isValidForRegistration) {
        emit(
          s.copyWith(
            validation: FieldValidationState.allTouched(),
          ),
        );
        return;
      }

      emit(s.copyWith(isSubmitting: true));

      final result = await _register(credentials);

      result.fold(
        (failure) => emit(
          s.copyWith(
            isSubmitting: false,
            error: ErrorModel.fromFailure(failure),
            validation: FieldValidationState.allTouched(),
          ),
        ),
        (user) => _handleAuthSuccess(user, emit),
      );
    }
  }

  void _handleAuthSuccess(User user, Emitter<AuthState> emit) {
    emit(Authenticated(user));
    add(const AuthWatchStarted());
    add(const AuthSessionWatchStarted());
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _logout();

    result.fold(
      (failure) => _logger.warning('$failure'),
      (_) => _logger.debug('Logout successful'),
    );

    emit(AuthInitial.empty());
  }

  Future<void> _onAuthUserChanged(
    AuthUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      if (state is Authenticated) {
        _logger.debug(
          'Session expired from server, logging out and clearing tokens',
        );
        // Clear tokens and dispose WebSocket connection
        await _logout();
        // Emit unauthenticated first (triggers route redirect)
        emit(const Unauthenticated());
        // Then emit initial state (shows email form on auth page)
        emit(AuthInitial.empty());
      }
    }
  }

  Future<void> _onSessionExpired(
    AuthSessionExpired event,
    Emitter<AuthState> emit,
  ) async {
    _logger.warning('Session expired - token refresh failed');
    await _logout();
    emit(const Unauthenticated());
  }
}

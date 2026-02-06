import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/domain/value_objects/name.dart';
import 'package:starter_app/core/domain/value_objects/password.dart';
import 'package:starter_app/features/auth/application/usecases/check_user_exists.dart';
import 'package:starter_app/features/auth/application/usecases/get_current_user.dart';
import 'package:starter_app/features/auth/application/usecases/login.dart';
import 'package:starter_app/features/auth/application/usecases/logout.dart';
import 'package:starter_app/features/auth/application/usecases/register.dart';
import 'package:starter_app/features/auth/application/usecases/watch_auth_changes.dart';
import 'package:starter_app/features/auth/application/usecases/watch_session_expired.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/test_data.dart';

// Mock Use Cases
class MockCheckUserExists extends Mock implements CheckUserExists {}

class MockLogin extends Mock implements Login {}

class MockRegister extends Mock implements Register {}

class MockLogout extends Mock implements Logout {}

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockWatchAuthChanges extends Mock implements WatchAuthChanges {}

class MockWatchSessionExpired extends Mock implements WatchSessionExpired {}

void main() {
  late MockCheckUserExists mockCheckUserExists;
  late MockLogin mockLogin;
  late MockRegister mockRegister;
  late MockLogout mockLogout;
  late MockGetCurrentUser mockGetCurrentUser;
  late MockWatchAuthChanges mockWatchAuthChanges;
  late MockWatchSessionExpired mockWatchSessionExpired;
  late MockAppLogger mockLogger;
  late AuthBloc bloc;

  setUpAll(() {
    registerMockFallbackValues();
    registerFallbackValue(TestData.loginCredentials());
    registerFallbackValue(TestData.registerCredentials());
    registerFallbackValue(TestData.emailAddress());
    registerFallbackValue(TestData.nameVO());
  });

  setUp(() {
    mockCheckUserExists = MockCheckUserExists();
    mockLogin = MockLogin();
    mockRegister = MockRegister();
    mockLogout = MockLogout();
    mockGetCurrentUser = MockGetCurrentUser();
    mockWatchAuthChanges = MockWatchAuthChanges();
    mockWatchSessionExpired = MockWatchSessionExpired();
    mockLogger = MockAppLogger();

    // Default stream stubs to avoid null errors
    when(() => mockWatchAuthChanges()).thenAnswer((_) => const Stream.empty());
    when(
      () => mockWatchSessionExpired(),
    ).thenAnswer((_) => const Stream.empty());

    bloc = AuthBloc(
      mockCheckUserExists,
      mockLogin,
      mockRegister,
      mockLogout,
      mockGetCurrentUser,
      mockWatchAuthChanges,
      mockWatchSessionExpired,
      mockLogger,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  group('AuthBloc', () {
    test('initial state is AuthInitial.empty', () {
      expect(bloc.state, isA<AuthInitial>());
      expect((bloc.state as AuthInitial).isSubmitting, false);
    });

    group('AuthWatchStarted', () {
      blocTest<AuthBloc, AuthState>(
        'logs error and adds authUserChanged(null) on stream error',
        build: () {
          when(() => mockWatchAuthChanges()).thenAnswer(
            (_) => Stream.value(
              const Left(UnauthorizedFailure(message: 'Stream Error')),
            ),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthWatchStarted()),
        expect: () => <AuthState>[], // No state change, but side effect
        verify: (_) {
          verify(
            () => mockLogger.error(any(that: contains('Stream Error'))),
          ).called(1);
          // Verify indirect effect if possible, or just the logging
        },
      );

      blocTest<AuthBloc, AuthState>(
        'adds AuthUserChanged(user) when auth changes emit user',
        build: () {
          when(() => mockWatchAuthChanges()).thenAnswer(
            (_) => Stream.value(Right(TestData.user())),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthWatchStarted()),
        expect: () => [
          Authenticated(TestData.user()),
        ],
        verify: (_) {
          verify(() => mockWatchAuthChanges()).called(1);
        },
      );
    });

    group('AuthSessionWatchStarted', () {
      blocTest<AuthBloc, AuthState>(
        'adds sessionExpired on stream data',
        build: () {
          when(() => mockWatchSessionExpired()).thenAnswer(
            (_) => Stream.value(const Right(null)),
          );
          // Mock logout for the session expired handler
          when(() => mockLogout()).thenAnswer((_) async => const Right(unit));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthSessionWatchStarted()),
        expect: () => [
          // sessionExpired handler will emit Unauthenticated
          isA<Unauthenticated>(),
        ],
        verify: (_) {
          verify(() => mockLogout()).called(1);
        },
      );
    });

    group('AuthGetCurrentUser', () {
      final tUser = TestData.user();

      blocTest<AuthBloc, AuthState>(
        'emits [authenticated] and starts watching when user is found',
        build: () {
          when(
            () => mockGetCurrentUser(),
          ).thenAnswer((_) async => Right(tUser));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthGetCurrentUser()),
        expect: () => <AuthState>[
          Authenticated(tUser),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUser()).called(1);
          // session watch should be started
          verify(() => mockWatchSessionExpired()).called(1);
          // auth watch should be started (as side effect of authenticated)
          verify(() => mockWatchAuthChanges()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [empty] when user is not found (null)',
        build: () {
          when(
            () => mockGetCurrentUser(),
          ).thenAnswer((_) async => const Right(null));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthGetCurrentUser()),
        expect: () => [
          isA<AuthInitial>(),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUser()).called(1);
          verify(() => mockWatchSessionExpired()).called(1);
          verifyNever(() => mockWatchAuthChanges());
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [empty] and logs warning when failure occurs',
        build: () {
          when(() => mockGetCurrentUser()).thenAnswer(
            (_) async => const Left(UnauthorizedFailure(message: 'Error')),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthGetCurrentUser()),
        expect: () => [
          isA<AuthInitial>(),
        ],
        verify: (_) {
          verify(() => mockGetCurrentUser()).called(1);
          verify(() => mockLogger.warning(any())).called(1);
        },
      );
    });

    group('AuthEmailChanged', () {
      const tEmailStr = TestData.email;

      blocTest<AuthBloc, AuthState>(
        'updates email and resets error/validation in initial state',
        build: () => bloc,
        act: (bloc) => bloc.add(const AuthEmailChanged(tEmailStr)),
        expect: () => [
          isA<AuthInitial>().having(
            (s) => s.email.getOrCrash(),
            'email',
            tEmailStr,
          ),
        ],
      );
    });

    group('AuthPasswordChanged', () {
      const tPasswordStr = TestData.password;

      blocTest<AuthBloc, AuthState>(
        'updates password in loginRequired state',
        seed: () => LoginRequired(
          email: EmailAddress(TestData.email),
          password: Password(''),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () => bloc,
        act: (bloc) => bloc.add(const AuthPasswordChanged(tPasswordStr)),
        expect: () => [
          isA<LoginRequired>().having(
            (s) => s.password.getOrCrash(),
            'password',
            tPasswordStr,
          ),
        ],
      );
    });

    group('AuthEmailSubmitted', () {
      const tEmailStr = TestData.email;

      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, loginRequired] when user exists',
        build: () {
          when(
            () => mockCheckUserExists(any()),
          ).thenAnswer((_) async => const Right(true));
          return bloc;
        },
        act: (bloc) => bloc
          ..add(const AuthEmailChanged(tEmailStr))
          ..add(const AuthEmailSubmitted()),
        expect: () => [
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            false,
          ),
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<LoginRequired>().having(
            (s) => s.email.getOrCrash(),
            'email',
            tEmailStr,
          ),
        ],
        verify: (_) {
          verify(() => mockCheckUserExists(any())).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, registrationRequired] when user does not exist',
        build: () {
          when(
            () => mockCheckUserExists(any()),
          ).thenAnswer((_) async => const Right(false));
          return bloc;
        },
        act: (bloc) => bloc
          ..add(const AuthEmailChanged(tEmailStr))
          ..add(const AuthEmailSubmitted()),
        expect: () => [
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            false,
          ),
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<RegistrationRequired>().having(
            (s) => s.email.getOrCrash(),
            'email',
            tEmailStr,
          ),
        ],
      );
    });

    group('AuthLoginSubmitted', () {
      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, authenticated] on success',
        seed: () => LoginRequired(
          email: TestData.emailAddress(),
          password: TestData.passwordVO(),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () {
          when(
            () => mockLogin(any()),
          ).thenAnswer((_) async => Right(TestData.user()));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthLoginSubmitted()),
        expect: () => [
          isA<LoginRequired>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<Authenticated>(),
        ],
        verify: (_) {
          verify(() => mockLogin(any())).called(1);
          verify(() => mockWatchAuthChanges()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, error] on failure',
        seed: () => LoginRequired(
          email: TestData.emailAddress(),
          password: TestData.passwordVO(),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () {
          when(() => mockLogin(any())).thenAnswer(
            (_) async => const Left(UnauthorizedFailure(message: 'Error')),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthLoginSubmitted()),
        expect: () => [
          isA<LoginRequired>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<LoginRequired>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.error, 'error', isNotNull),
        ],
      );
    });

    group('AuthRegisterSubmitted', () {
      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, authenticated] on success',
        seed: () => RegistrationRequired(
          email: TestData.emailAddress(),
          password: TestData.passwordVO(),
          name: TestData.nameVO(),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () {
          when(
            () => mockRegister(any()),
          ).thenAnswer((_) async => Right(TestData.user()));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthRegisterSubmitted()),
        expect: () => [
          isA<RegistrationRequired>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<Authenticated>(),
        ],
      );
    });

    group('AuthLogoutRequested', () {
      blocTest<AuthBloc, AuthState>(
        'calls logout and emits [empty]',
        build: () {
          when(() => mockLogout()).thenAnswer((_) async => const Right(unit));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          isA<AuthInitial>(),
        ],
        verify: (_) {
          verify(() => mockLogout()).called(1);
        },
      );
    });

    group('AuthSessionExpired', () {
      blocTest<AuthBloc, AuthState>(
        'calls logout and emits [unauthenticated]',
        build: () {
          when(() => mockLogout()).thenAnswer((_) async => const Right(unit));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthSessionExpired()),
        expect: () => [
          isA<Unauthenticated>(),
        ],
        verify: (_) {
          verify(() => mockLogout()).called(1);
        },
      );
    });

    group('AuthEmailSubmitted', () {
      const tEmailStr = TestData.email;

      blocTest<AuthBloc, AuthState>(
        'emits [validation updated] when email is invalid',
        build: () => bloc,
        act: (bloc) => bloc
          ..add(const AuthEmailChanged('invalid-email'))
          ..add(const AuthEmailSubmitted()),
        expect: () => [
          isA<AuthInitial>().having(
            (s) => s.email.isValid,
            'email.isValid',
            false,
          ),
          isA<AuthInitial>().having(
            (s) => s.validation.emailTouched,
            'emailTouched',
            true,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockCheckUserExists(any()));
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, error] when checkUserExists fails',
        build: () {
          when(
            () => mockCheckUserExists(any()),
          ).thenAnswer(
            (_) async => const Left(UnauthorizedFailure(message: 'Error')),
          );
          return bloc;
        },
        act: (bloc) => bloc
          ..add(const AuthEmailChanged(tEmailStr))
          ..add(const AuthEmailSubmitted()),
        expect: () => [
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            false,
          ),
          isA<AuthInitial>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<AuthInitial>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.error, 'error', isNotNull),
        ],
      );
    });

    group('AuthLoginSubmitted', () {
      blocTest<AuthBloc, AuthState>(
        'emits [validation updated] when credentials are invalid',
        seed: () => LoginRequired(
          email: TestData.emailAddress(),
          password: Password('short'), // Invalid password
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () => bloc,
        act: (bloc) => bloc.add(const AuthLoginSubmitted()),
        expect: () => [
          isA<LoginRequired>().having(
            (s) => s.validation == FieldValidationState.allTouched(),
            'isAllTouched',
            true,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockLogin(any()));
        },
      );
    });

    group('AuthRegisterSubmitted', () {
      blocTest<AuthBloc, AuthState>(
        'emits [validation updated] when credentials are invalid',
        seed: () => RegistrationRequired(
          email: TestData.emailAddress(),
          password: Password('short'), // Invalid
          name: TestData.nameVO(),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () => bloc,
        act: (bloc) => bloc.add(const AuthRegisterSubmitted()),
        expect: () => [
          isA<RegistrationRequired>().having(
            (s) => s.validation == FieldValidationState.allTouched(),
            'isAllTouched',
            true,
          ),
        ],
        verify: (_) {
          verifyNever(() => mockRegister(any()));
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [isSubmitting, error] on failure',
        seed: () => RegistrationRequired(
          email: TestData.emailAddress(),
          password: TestData.passwordVO(),
          name: TestData.nameVO(),
          isSubmitting: false,
          validation: FieldValidationState.initial(),
        ),
        build: () {
          when(() => mockRegister(any())).thenAnswer(
            (_) async => const Left(EmailAlreadyInUseFailure()),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthRegisterSubmitted()),
        expect: () => [
          isA<RegistrationRequired>().having(
            (s) => s.isSubmitting,
            'isSubmitting',
            true,
          ),
          isA<RegistrationRequired>()
              .having((s) => s.isSubmitting, 'isSubmitting', false)
              .having((s) => s.error, 'error', isNotNull),
        ],
      );
    });

    group('Field Focus Events', () {
      test('AuthEmailUnfocused marks email as touched', () {
        bloc.add(const AuthEmailUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<AuthInitial>().having(
                (s) => s.validation.emailTouched,
                'emailTouched',
                true,
              ),
            ),
          ),
        );
      });

      test('AuthPasswordUnfocused marks password as touched', () {
        // Need to be in state where password exists (Login/Register)
        // Testing in LoginRequired
        bloc
          ..emit(
            LoginRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthPasswordUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<LoginRequired>().having(
                (s) => s.validation.passwordTouched,
                'passwordTouched',
                true,
              ),
            ),
          ),
        );
      });

      test('AuthNameUnfocused marks name as touched', () {
        // Need to be in RegistrationRequired
        bloc
          ..emit(
            RegistrationRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              name: TestData.nameVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthNameUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<RegistrationRequired>().having(
                (s) => s.validation.nameTouched,
                'nameTouched',
                true,
              ),
            ),
          ),
        );
      });
      test('AuthPasswordUnfocused does nothing in Initial state', () {
        bloc.add(const AuthPasswordUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });

      test('AuthNameUnfocused does nothing in Initial state', () {
        bloc.add(const AuthNameUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });

      test('AuthEmailUnfocused marks email as touched in LoginRequired', () {
        bloc
          ..emit(
            LoginRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthEmailUnfocused());
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<LoginRequired>().having(
                (s) => s.validation.emailTouched,
                'emailTouched',
                true,
              ),
            ),
          ),
        );
      });

      test(
        'AuthEmailUnfocused marks email as touched in RegistrationRequired',
        () {
          bloc
            ..emit(
              RegistrationRequired(
                email: TestData.emailAddress(),
                password: TestData.passwordVO(),
                name: TestData.nameVO(),
                isSubmitting: false,
                validation: FieldValidationState.initial(),
              ),
            )
            ..add(const AuthEmailUnfocused());
          unawaited(
            expectLater(
              bloc.stream,
              emits(
                isA<RegistrationRequired>().having(
                  (s) => s.validation.emailTouched,
                  'emailTouched',
                  true,
                ),
              ),
            ),
          );
        },
      );
    });

    group('AuthUserChanged', () {
      blocTest<AuthBloc, AuthState>(
        '''
        emits [unauthenticated, initial] 
        when user becomes null while authenticated''',
        seed: () => Authenticated(TestData.user()),
        build: () {
          when(() => mockLogout()).thenAnswer((_) async => const Right(unit));
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthUserChanged(null)),
        expect: () => [
          isA<Unauthenticated>(),
          isA<AuthInitial>(),
        ],
        verify: (_) {
          verify(() => mockLogger.debug(any())).called(greaterThan(0));
          verify(() => mockLogout()).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'emits [authenticated] when user is not null',
        seed: AuthInitial.empty,
        build: () => bloc,
        act: (bloc) => bloc.add(AuthUserChanged(TestData.user())),
        expect: () => [
          Authenticated(TestData.user()),
        ],
      );
    });
    group('Coverage Gaps', () {
      test(
        'AuthEmailChanged resets to initial if empty (from LoginRequired)',
        () {
          bloc
            ..emit(
              LoginRequired(
                email: TestData.emailAddress(),
                password: TestData.passwordVO(),
                isSubmitting: false,
                validation: FieldValidationState.initial(),
              ),
            )
            ..add(const AuthEmailChanged(''));
          unawaited(
            expectLater(
              bloc.stream,
              emits(isA<AuthInitial>()),
            ),
          );
        },
      );

      test(
        '''AuthEmailChanged resets to initial if empty (from RegistrationRequired)''',
        () {
          bloc
            ..emit(
              RegistrationRequired(
                email: TestData.emailAddress(),
                password: TestData.passwordVO(),
                name: TestData.nameVO(),
                isSubmitting: false,
                validation: FieldValidationState.initial(),
              ),
            )
            ..add(const AuthEmailChanged(''));
          unawaited(
            expectLater(
              bloc.stream,
              emits(isA<AuthInitial>()),
            ),
          );
        },
      );

      test('AuthNameChanged updates name in RegistrationRequired', () {
        bloc
          ..emit(
            RegistrationRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              name: Name('Old Name'),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthNameChanged('New Name'));
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<RegistrationRequired>().having(
                (s) => s.name.getOrCrash(),
                'name',
                'New Name',
              ),
            ),
          ),
        );
      });

      test('AuthPasswordChanged updates password in RegistrationRequired', () {
        bloc
          ..emit(
            RegistrationRequired(
              email: TestData.emailAddress(),
              password: Password('OldPassword'),
              name: TestData.nameVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthPasswordChanged('P@ssword123!'));
        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<RegistrationRequired>().having(
                (s) => s.password.getOrCrash(),
                'password',
                'P@ssword123!',
              ),
            ),
          ),
        );
      });

      blocTest<AuthBloc, AuthState>(
        'AuthLogoutRequested failure logs warning',
        build: () {
          when(() => mockLogout()).thenAnswer(
            (_) async =>
                const Left(UnauthorizedFailure(message: 'Logout Error')),
          );
          return bloc;
        },
        act: (bloc) => bloc.add(const AuthLogoutRequested()),
        expect: () => [
          isA<AuthInitial>(),
        ],
        verify: (_) {
          verify(
            () => mockLogger.warning(any(that: contains('Logout Error'))),
          ).called(1);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'AuthUserChanged(null) does nothing if not authenticated',
        seed: AuthInitial.empty,
        build: () => bloc,
        act: (bloc) => bloc.add(const AuthUserChanged(null)),
        expect: () => <AuthState>[], // No state change
      );

      test('AuthEmailChanged does nothing in LoginRequired if not empty', () {
        bloc
          ..emit(
            LoginRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthEmailChanged('new@example.com'));
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });

      test('AuthPasswordChanged does nothing in Initial state', () {
        bloc.add(const AuthPasswordChanged('pass'));
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });

      test('AuthNameChanged does nothing in Initial state', () {
        bloc.add(const AuthNameChanged('name'));
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });
    });

    group('AuthTogglePasswordVisibility', () {
      test('toggles password visibility in LoginRequired', () {
        bloc
          ..emit(
            LoginRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthTogglePasswordVisibility());

        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<LoginRequired>().having(
                (s) => s.passwordVisible,
                'passwordVisible',
                true,
              ),
            ),
          ),
        );
      });

      test('toggles password visibility in RegistrationRequired', () {
        bloc
          ..emit(
            RegistrationRequired(
              email: TestData.emailAddress(),
              password: TestData.passwordVO(),
              name: TestData.nameVO(),
              isSubmitting: false,
              validation: FieldValidationState.initial(),
            ),
          )
          ..add(const AuthTogglePasswordVisibility());

        unawaited(
          expectLater(
            bloc.stream,
            emits(
              isA<RegistrationRequired>().having(
                (s) => s.passwordVisible,
                'passwordVisible',
                true,
              ),
            ),
          ),
        );
      });

      test('does nothing in Initial state', () {
        bloc.add(const AuthTogglePasswordVisibility());
        unawaited(
          expectLater(
            bloc.stream,
            emitsDone,
          ),
        );
        unawaited(bloc.close());
      });
    });
  });
}

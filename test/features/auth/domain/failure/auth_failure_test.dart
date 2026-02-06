import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/error/failures/failure.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';

void main() {
  group('AuthFailure', () {
    group('notFound', () {
      test('creates failure with message', () {
        const failure = AuthNotFoundFailure(message: 'User not found');

        expect(failure.message, 'User not found');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = AuthNotFoundFailure(
          message: 'User not found',
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('extends Failure', () {
        const failure = AuthNotFoundFailure(message: 'test');
        expect(failure, isA<Failure>());
      });
    });

    group('unauthorized', () {
      test('creates failure with message', () {
        const failure = UnauthorizedFailure(
          message: 'Invalid credentials',
        );

        expect(failure.message, 'Invalid credentials');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = UnauthorizedFailure(
          message: 'Invalid credentials',
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });
    });

    group('forbidden', () {
      test('creates failure with message', () {
        const failure = ForbiddenFailure(message: 'Account suspended');

        expect(failure.message, 'Account suspended');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = ForbiddenFailure(
          message: 'Account suspended',
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });
    });

    group('emailAlreadyInUse', () {
      test('creates failure with default message', () {
        const failure = EmailAlreadyInUseFailure();

        expect(failure.message, 'Email already in use');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates failure with custom message', () {
        const failure = EmailAlreadyInUseFailure(
          message: 'This email is taken',
        );

        expect(failure.message, 'This email is taken');
      });

      test('creates failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = EmailAlreadyInUseFailure(stackTrace: stackTrace);

        expect(failure.stackTrace, stackTrace);
      });
    });

    group('invalidInput', () {
      test('creates failure with message', () {
        const failure = InvalidInputFailure(
          message: 'Invalid email format',
        );

        expect(failure.message, 'Invalid email format');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = InvalidInputFailure(
          message: 'Invalid email format',
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });
    });

    group('isRetryable', () {
      test('all failure types are not retryable', () {
        expect(
          const AuthNotFoundFailure(message: 'test').isRetryable,
          false,
        );
        expect(
          const UnauthorizedFailure(message: 'test').isRetryable,
          false,
        );
        expect(
          const ForbiddenFailure(message: 'test').isRetryable,
          false,
        );
        expect(
          const EmailAlreadyInUseFailure().isRetryable,
          false,
        );
        expect(
          const InvalidInputFailure(message: 'test').isRetryable,
          false,
        );
      });
    });

    group('message getter (via base type)', () {
      test('returns correct message for all failure types', () {
        // Test through base AuthFailure type to exercise the when() pattern
        AuthFailure failure;

        failure = const AuthNotFoundFailure(message: 'not found msg');
        expect(failure.message, 'not found msg');

        failure = const UnauthorizedFailure(message: 'unauthorized msg');
        expect(failure.message, 'unauthorized msg');

        failure = const ForbiddenFailure(message: 'forbidden msg');
        expect(failure.message, 'forbidden msg');

        failure = const EmailAlreadyInUseFailure(message: 'email msg');
        expect(failure.message, 'email msg');

        failure = const InvalidInputFailure(message: 'invalid msg');
        expect(failure.message, 'invalid msg');
      });
    });

    group('stackTrace getter (via base type)', () {
      test('returns correct stackTrace for all failure types', () {
        final stackTrace = StackTrace.current;
        AuthFailure failure;

        failure = AuthNotFoundFailure(message: 'test', stackTrace: stackTrace);
        expect(failure.stackTrace, stackTrace);

        failure = UnauthorizedFailure(
          message: 'test',
          stackTrace: stackTrace,
        );
        expect(failure.stackTrace, stackTrace);

        failure = ForbiddenFailure(
          message: 'test',
          stackTrace: stackTrace,
        );
        expect(failure.stackTrace, stackTrace);

        failure = EmailAlreadyInUseFailure(stackTrace: stackTrace);
        expect(failure.stackTrace, stackTrace);

        failure = InvalidInputFailure(
          message: 'test',
          stackTrace: stackTrace,
        );
        expect(failure.stackTrace, stackTrace);
      });

      test('returns null stackTrace when not provided', () {
        AuthFailure failure;

        failure = const AuthNotFoundFailure(message: 'test');
        expect(failure.stackTrace, isNull);

        failure = const UnauthorizedFailure(message: 'test');
        expect(failure.stackTrace, isNull);

        failure = const ForbiddenFailure(message: 'test');
        expect(failure.stackTrace, isNull);

        failure = const EmailAlreadyInUseFailure();
        expect(failure.stackTrace, isNull);

        failure = const InvalidInputFailure(message: 'test');
        expect(failure.stackTrace, isNull);
      });
    });
  });
}

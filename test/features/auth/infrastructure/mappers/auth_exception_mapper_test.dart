import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/error/exceptions/server_exception.dart';
import 'package:starter_app/core/error/failures/infrastructure_failures.dart';
import 'package:starter_app/features/auth/domain/failure/auth_failure.dart';
import 'package:starter_app/features/auth/infrastructure/mappers/auth_exception_mapper.dart';

void main() {
  group('AuthExceptionMapper', () {
    late AuthExceptionMapper mapper;

    setUp(() {
      mapper = const AuthExceptionMapper();
    });

    group('mapToFailure', () {
      test('maps 401 Unauthorized to UnauthorizedFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.unauthorized,
          message: 'Invalid credentials',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<UnauthorizedFailure>());
        expect((result as UnauthorizedFailure).message, 'Invalid credentials');
      });

      test('maps 403 Forbidden to ForbiddenFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.forbidden,
          message: 'Account suspended',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<ForbiddenFailure>());
        expect((result as ForbiddenFailure).message, 'Account suspended');
      });

      test('maps 404 Not Found to AuthNotFoundFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.notFound,
          message: 'User not found',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<AuthNotFoundFailure>());
        expect((result as AuthNotFoundFailure).message, 'User not found');
      });

      test('maps 409 Conflict to EmailAlreadyInUseFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.conflict,
          message: 'Email already in use',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<EmailAlreadyInUseFailure>());
      });

      test('maps 400 Bad Request to InvalidInputFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.badRequest,
          message: 'Invalid request',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<InvalidInputFailure>());
        expect((result as InvalidInputFailure).message, 'Invalid request');
      });

      test(
        'maps 500 Internal Server Error to ServerFailure',
        () {
          const exception = ServerException(
            statusCode: HttpStatus.internalServerError,
            message: 'Server error',
          );

          final result = mapper.mapToFailure(exception);

          expect(result, isA<ServerFailure>());
          final serverFailure = result as ServerFailure;
          expect(serverFailure.message, 'Server error');
          expect(serverFailure.statusCode, HttpStatus.internalServerError);
        },
      );

      test('maps 503 Service Unavailable to ServerFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.serviceUnavailable,
          message: 'Service unavailable',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<ServerFailure>());
        final serverFailure = result as ServerFailure;
        expect(serverFailure.message, 'Service unavailable');
        expect(serverFailure.statusCode, HttpStatus.serviceUnavailable);
      });

      test('maps unknown 4xx status codes to ServerFailure', () {
        const exception = ServerException(
          statusCode: HttpStatus.paymentRequired,
          message: 'Payment required',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<InfrastructureFailure>());
      });

      test('preserves message from exception', () {
        const customMessage = 'Custom error message';
        const exception = ServerException(
          statusCode: HttpStatus.unauthorized,
          message: customMessage,
        );

        final result = mapper.mapToFailure(exception);

        expect((result as AuthFailure).message, customMessage);
      });

      test('preserves status code in infrastructure failures', () {
        const statusCode = HttpStatus.badGateway;
        const exception = ServerException(
          statusCode: statusCode,
          message: 'Bad gateway',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<ServerFailure>());
        expect((result as ServerFailure).statusCode, statusCode);
      });
    });

    group('failure properties', () {
      test('unauthorized failure is not retryable', () {
        const exception = ServerException(
          statusCode: HttpStatus.unauthorized,
          message: 'Unauthorized',
        );

        final result = mapper.mapToFailure(exception);

        expect(result.isRetryable, false);
      });

      test('forbidden failure is not retryable', () {
        const exception = ServerException(
          statusCode: HttpStatus.forbidden,
          message: 'Forbidden',
        );

        final result = mapper.mapToFailure(exception);

        expect(result.isRetryable, false);
      });

      test('not found failure is not retryable', () {
        const exception = ServerException(
          statusCode: HttpStatus.notFound,
          message: 'Not found',
        );

        final result = mapper.mapToFailure(exception);

        expect(result.isRetryable, false);
      });
    });

    group('use cases', () {
      test('maps login failure with invalid credentials', () {
        const exception = ServerException(
          statusCode: HttpStatus.unauthorized,
          message: 'Invalid email or password',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<UnauthorizedFailure>());
        expect(
          (result as UnauthorizedFailure).message,
          'Invalid email or password',
        );
      });

      test('maps account suspension scenario', () {
        const exception = ServerException(
          statusCode: HttpStatus.forbidden,
          message: 'Your account has been suspended',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<ForbiddenFailure>());
        expect(
          (result as ForbiddenFailure).message,
          contains('suspended'),
        );
      });

      test('maps email not registered scenario', () {
        const exception = ServerException(
          statusCode: HttpStatus.notFound,
          message: 'Email not registered',
        );

        final result = mapper.mapToFailure(exception);

        expect(result, isA<AuthNotFoundFailure>());
        expect(
          (result as AuthNotFoundFailure).message,
          'Email not registered',
        );
      });

      test('maps server errors to infrastructure failures', () {
        const exception = ServerException(
          statusCode: HttpStatus.internalServerError,
          message: 'Internal server error',
        );

        final result = mapper.mapToFailure(exception);

        // Server errors should be infrastructure failures, not auth failures
        expect(result, isNot(isA<AuthFailure>()));
        expect(result, isA<InfrastructureFailure>());
      });
    });
  });
}

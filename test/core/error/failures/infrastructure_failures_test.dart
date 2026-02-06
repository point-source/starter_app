import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/error/failures/failures.dart';

void main() {
  group('InfrastructureFailure', () {
    group('ServerFailure', () {
      test('creates server failure with message and status code', () {
        const failure = ServerFailure(
          message: 'Internal server error',
          statusCode: 500,
        );

        expect(failure, isA<ServerFailure>());
        expect(failure.message, 'Internal server error');
        expect(failure.isRetryable, true);
        expect(failure.stackTrace, isNull);
      });

      test('creates server failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = ServerFailure(
          message: 'Error',
          statusCode: 500,
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates server failure with only message', () {
        const failure = ServerFailure(
          message: 'Server error',
        );

        expect(failure.message, 'Server error');
      });

      test('equals another server failure with same values', () {
        const failure1 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const failure2 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );

        expect(failure1, failure2);
      });

      test('not equals server failure with different message', () {
        const failure1 = ServerFailure(
          message: 'Error 1',
          statusCode: 500,
        );
        const failure2 = ServerFailure(
          message: 'Error 2',
          statusCode: 500,
        );

        expect(failure1, isNot(failure2));
      });

      test('not equals server failure with different status code', () {
        const failure1 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const failure2 = ServerFailure(
          message: 'Error',
          statusCode: 404,
        );

        expect(failure1, isNot(failure2));
      });

      test('not equals server failure when one has null status code', () {
        const failure1 = ServerFailure(
          message: 'Error',
        );
        const failure2 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );

        expect(failure1, isNot(failure2));
      });

      test('equals server failure when both have null status code', () {
        const failure1 = ServerFailure(
          message: 'Error',
        );
        const failure2 = ServerFailure(
          message: 'Error',
        );

        expect(failure1, failure2);
      });

      test('has consistent hashCode for equal instances', () {
        const failure1 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const failure2 = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );

        expect(failure1.hashCode, failure2.hashCode);
      });

      test('has different hashCode for different instances', () {
        const failure1 = ServerFailure(
          message: 'Error 1',
          statusCode: 500,
        );
        const failure2 = ServerFailure(
          message: 'Error 2',
          statusCode: 500,
        );

        expect(failure1.hashCode, isNot(failure2.hashCode));
      });

      test('copyWith creates new instance with updated message', () {
        const original = ServerFailure(
          message: 'Original',
          statusCode: 500,
        );
        final updated = original.copyWith(
          message: 'Updated',
        );

        expect(updated.message, 'Updated');
        expect(updated.statusCode, 500);
        expect(original.message, 'Original');
      });

      test('copyWith creates new instance with partial updates', () {
        const original = ServerFailure(
          message: 'Original',
          statusCode: 500,
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(updated.statusCode, 500);
      });

      test('is a Failure', () {
        const failure = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );

        expect(failure, isA<Failure>());
      });
    });

    group('NetworkFailure', () {
      test('creates network failure with default message', () {
        const failure = NetworkFailure();

        expect(failure, isA<NetworkFailure>());
        expect(failure.message, 'Network error');
        expect(failure.isRetryable, true);
        expect(failure.stackTrace, isNull);
      });

      test('creates network failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = NetworkFailure(
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates network failure with custom message', () {
        const failure = NetworkFailure(
          message: 'No internet connection',
        );

        expect(failure.message, 'No internet connection');
      });

      test('equals another network failure with same message', () {
        const failure1 = NetworkFailure(
          message: 'Connection timeout',
        );
        const failure2 = NetworkFailure(
          message: 'Connection timeout',
        );

        expect(failure1, failure2);
      });

      test('not equals network failure with different message', () {
        const failure1 = NetworkFailure(
          message: 'Connection timeout',
        );
        const failure2 = NetworkFailure(
          message: 'No internet',
        );

        expect(failure1, isNot(failure2));
      });

      test('has consistent hashCode for equal instances', () {
        const failure1 = NetworkFailure(
          message: 'Connection timeout',
        );
        const failure2 = NetworkFailure(
          message: 'Connection timeout',
        );

        expect(failure1.hashCode, failure2.hashCode);
      });

      test('has different hashCode for different messages', () {
        const failure1 = NetworkFailure(
          message: 'Connection timeout',
        );
        const failure2 = NetworkFailure(
          message: 'No internet',
        );

        expect(failure1.hashCode, isNot(failure2.hashCode));
      });

      test('copyWith creates new instance with updated message', () {
        const original = NetworkFailure(
          message: 'Original',
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(original.message, 'Original');
      });

      test('is retryable', () {
        const failure = NetworkFailure();

        expect(failure.isRetryable, true);
      });
    });

    group('CacheFailure', () {
      test('creates cache failure with default message', () {
        const failure = CacheFailure();

        expect(failure, isA<CacheFailure>());
        expect(failure.message, 'Cache error');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates cache failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = CacheFailure(
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates cache failure with custom message', () {
        const failure = CacheFailure(
          message: 'Failed to read from cache',
        );

        expect(failure.message, 'Failed to read from cache');
      });

      test('is not retryable', () {
        const failure = CacheFailure();

        expect(failure.isRetryable, false);
      });

      test('equals another cache failure with same message', () {
        const failure1 = CacheFailure();
        const failure2 = CacheFailure();

        expect(failure1, failure2);
      });

      test('equals another cache failure with same custom message', () {
        const failure1 = CacheFailure(
          message: 'Custom cache error',
        );
        const failure2 = CacheFailure(
          message: 'Custom cache error',
        );

        expect(failure1, failure2);
      });

      test('not equals cache failure with different message', () {
        const failure1 = CacheFailure(
          message: 'Error 1',
        );
        const failure2 = CacheFailure(
          message: 'Error 2',
        );

        expect(failure1, isNot(failure2));
      });

      test('has consistent hashCode for equal instances', () {
        const failure1 = CacheFailure();
        const failure2 = CacheFailure();

        expect(failure1.hashCode, failure2.hashCode);
      });

      test('has different hashCode for different messages', () {
        const failure1 = CacheFailure(
          message: 'Error 1',
        );
        const failure2 = CacheFailure(
          message: 'Error 2',
        );

        expect(failure1.hashCode, isNot(failure2.hashCode));
      });

      test('copyWith creates new instance with updated message', () {
        const original = CacheFailure(
          message: 'Original',
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(original.message, 'Original');
      });
    });

    group('ParseFailure', () {
      test('creates parse failure with default message', () {
        const failure = ParseFailure();

        expect(failure, isA<ParseFailure>());
        expect(failure.message, 'Parse error');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates parse failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = ParseFailure(
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates parse failure with custom message', () {
        const failure = ParseFailure(
          message: 'Failed to parse JSON',
        );

        expect(failure.message, 'Failed to parse JSON');
      });

      test('is not retryable', () {
        const failure = ParseFailure();

        expect(failure.isRetryable, false);
      });

      test('equals another parse failure with same message', () {
        const failure1 = ParseFailure();
        const failure2 = ParseFailure();

        expect(failure1, failure2);
      });

      test('equals another parse failure with same custom message', () {
        const failure1 = ParseFailure(
          message: 'Custom parse error',
        );
        const failure2 = ParseFailure(
          message: 'Custom parse error',
        );

        expect(failure1, failure2);
      });

      test('not equals parse failure with different message', () {
        const failure1 = ParseFailure(
          message: 'Error 1',
        );
        const failure2 = ParseFailure(
          message: 'Error 2',
        );

        expect(failure1, isNot(failure2));
      });

      test('has consistent hashCode for equal instances', () {
        const failure1 = ParseFailure();
        const failure2 = ParseFailure();

        expect(failure1.hashCode, failure2.hashCode);
      });

      test('has different hashCode for different messages', () {
        const failure1 = ParseFailure(
          message: 'Error 1',
        );
        const failure2 = ParseFailure(
          message: 'Error 2',
        );

        expect(failure1.hashCode, isNot(failure2.hashCode));
      });

      test('copyWith creates new instance with updated message', () {
        const original = ParseFailure(
          message: 'Original',
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(original.message, 'Original');
      });
    });

    group('CircuitBreakerFailure', () {
      test('creates circuit breaker failure with default message', () {
        const failure = CircuitBreakerFailure();

        expect(failure, isA<CircuitBreakerFailure>());
        expect(failure.message, 'Service temporarily unavailable');
        expect(failure.isRetryable, true);
        expect(failure.stackTrace, isNull);
      });

      test('creates circuit breaker failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = CircuitBreakerFailure(
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates circuit breaker failure with custom message', () {
        const failure = CircuitBreakerFailure(
          message: 'Circuit is open, try again later',
        );

        expect(failure.message, 'Circuit is open, try again later');
      });

      test('is retryable', () {
        const failure = CircuitBreakerFailure();

        expect(failure.isRetryable, true);
      });

      test('equals another circuit breaker failure with same message', () {
        const failure1 = CircuitBreakerFailure();
        const failure2 = CircuitBreakerFailure();

        expect(failure1, failure2);
      });

      test(
        'equals another circuit breaker failure with same custom message',
        () {
          const failure1 = CircuitBreakerFailure(
            message: 'Custom circuit breaker error',
          );
          const failure2 = CircuitBreakerFailure(
            message: 'Custom circuit breaker error',
          );

          expect(failure1, failure2);
        },
      );

      test('not equals circuit breaker failure with different message', () {
        const failure1 = CircuitBreakerFailure(
          message: 'Error 1',
        );
        const failure2 = CircuitBreakerFailure(
          message: 'Error 2',
        );

        expect(failure1, isNot(failure2));
      });

      test('has consistent hashCode for equal instances', () {
        const failure1 = CircuitBreakerFailure();
        const failure2 = CircuitBreakerFailure();

        expect(failure1.hashCode, failure2.hashCode);
      });

      test('has different hashCode for different messages', () {
        const failure1 = CircuitBreakerFailure(
          message: 'Error 1',
        );
        const failure2 = CircuitBreakerFailure(
          message: 'Error 2',
        );

        expect(failure1.hashCode, isNot(failure2.hashCode));
      });

      test('copyWith creates new instance with updated message', () {
        const original = CircuitBreakerFailure(
          message: 'Original',
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(original.message, 'Original');
      });
    });

    group('UnexpectedFailure', () {
      test('creates unexpected failure with default message', () {
        const failure = UnexpectedFailure();

        expect(failure, isA<UnexpectedFailure>());
        expect(failure.message, 'An unexpected error occurred');
        expect(failure.isRetryable, false);
        expect(failure.stackTrace, isNull);
      });

      test('creates unexpected failure with stackTrace', () {
        final stackTrace = StackTrace.current;
        final failure = UnexpectedFailure(
          stackTrace: stackTrace,
        );

        expect(failure.stackTrace, stackTrace);
      });

      test('creates unexpected failure with custom message', () {
        const failure = UnexpectedFailure(
          message: 'Something went wrong',
        );

        expect(failure.message, 'Something went wrong');
      });

      test('is not retryable', () {
        const failure = UnexpectedFailure();

        expect(failure.isRetryable, false);
      });

      test('equals another unexpected failure with same message', () {
        const failure1 = UnexpectedFailure();
        const failure2 = UnexpectedFailure();

        expect(failure1, failure2);
      });

      test('not equals unexpected failure with different message', () {
        const failure1 = UnexpectedFailure(
          message: 'Error 1',
        );
        const failure2 = UnexpectedFailure(
          message: 'Error 2',
        );

        expect(failure1, isNot(failure2));
      });

      test('copyWith creates new instance with updated message', () {
        const original = UnexpectedFailure(
          message: 'Original',
        );
        final updated = original.copyWith(message: 'Updated');

        expect(updated.message, 'Updated');
        expect(original.message, 'Original');
      });
    });

    group('switch expression pattern matching', () {
      test('matches server failure with switch expression', () {
        const InfrastructureFailure failure = ServerFailure(
          message: 'Server error',
          statusCode: 500,
        );

        final result = switch (failure) {
          ServerFailure(:final message) => 'Server: $message',
          NetworkFailure(:final message) => 'Network: $message',
          CacheFailure(:final message) => 'Cache: $message',
          ParseFailure(:final message) => 'Parse: $message',
          CircuitBreakerFailure(:final message) => 'CircuitBreaker: $message',
          UnexpectedFailure(:final message) => 'Unexpected: $message',
        };

        expect(result, 'Server: Server error');
      });

      test('matches server failure with null status code', () {
        const failure = ServerFailure(
          message: 'Server error',
        );

        final result =
            'Server: ${failure.message} (code: ${failure.statusCode})';

        expect(result, 'Server: Server error (code: null)');
      });

      test('matches network failure with switch expression', () {
        const InfrastructureFailure failure = NetworkFailure(
          message: 'No connection',
        );

        final result = switch (failure) {
          ServerFailure() => 'Server',
          NetworkFailure(:final message) => 'Network: $message',
          CacheFailure() => 'Cache',
          ParseFailure() => 'Parse',
          CircuitBreakerFailure() => 'CircuitBreaker',
          UnexpectedFailure() => 'Unexpected',
        };

        expect(result, 'Network: No connection');
      });

      test('matches cache failure with switch expression', () {
        const InfrastructureFailure failure = CacheFailure(
          message: 'Cache failed',
        );

        final result = switch (failure) {
          ServerFailure() => 'Server',
          NetworkFailure() => 'Network',
          CacheFailure(:final message) => 'Cache: $message',
          ParseFailure() => 'Parse',
          CircuitBreakerFailure() => 'CircuitBreaker',
          UnexpectedFailure() => 'Unexpected',
        };

        expect(result, 'Cache: Cache failed');
      });

      test('matches parse failure with switch expression', () {
        const InfrastructureFailure failure = ParseFailure(
          message: 'Parse failed',
        );

        final result = switch (failure) {
          ServerFailure() => 'Server',
          NetworkFailure() => 'Network',
          CacheFailure() => 'Cache',
          ParseFailure(:final message) => 'Parse: $message',
          CircuitBreakerFailure() => 'CircuitBreaker',
          UnexpectedFailure() => 'Unexpected',
        };

        expect(result, 'Parse: Parse failed');
      });

      test('matches circuit breaker failure with switch expression', () {
        const InfrastructureFailure failure = CircuitBreakerFailure(
          message: 'Circuit open',
        );

        final result = switch (failure) {
          ServerFailure() => 'Server',
          NetworkFailure() => 'Network',
          CacheFailure() => 'Cache',
          ParseFailure() => 'Parse',
          CircuitBreakerFailure(:final message) => 'CircuitBreaker: $message',
          UnexpectedFailure(:final message) => 'Unexpected: $message',
        };

        expect(result, 'CircuitBreaker: Circuit open');
      });
    });

    group('message getter', () {
      test('returns correct message for server failure', () {
        const failure = ServerFailure(
          message: 'Server message',
          statusCode: 500,
        );

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Server message');
        expect(failure.message, 'Server message');
      });

      test(
        'returns correct message for server failure with null status code',
        () {
          const failure = ServerFailure(
            message: 'Server message without code',
          );

          // Explicitly access message getter to ensure coverage
          final message = failure.message;
          expect(message, 'Server message without code');
          expect(failure.message, 'Server message without code');
        },
      );

      test('returns correct message for network failure', () {
        const failure = NetworkFailure(
          message: 'Network message',
        );

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Network message');
        expect(failure.message, 'Network message');
      });

      test('returns default message for network failure', () {
        const failure = NetworkFailure();

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Network error');
        expect(failure.message, 'Network error');
      });

      test('returns correct message for cache failure', () {
        const failure = CacheFailure(
          message: 'Cache message',
        );

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Cache message');
        expect(failure.message, 'Cache message');
      });

      test('returns default message for cache failure', () {
        const failure = CacheFailure();

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Cache error');
        expect(failure.message, 'Cache error');
      });

      test('returns correct message for parse failure', () {
        const failure = ParseFailure(
          message: 'Parse message',
        );

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Parse message');
        expect(failure.message, 'Parse message');
      });

      test('returns default message for parse failure', () {
        const failure = ParseFailure();

        // Explicitly access message getter to ensure coverage
        final message = failure.message;
        expect(message, 'Parse error');
        expect(failure.message, 'Parse error');
      });

      test('returns correct message for circuit breaker failure', () {
        const failure = CircuitBreakerFailure(
          message: 'Circuit breaker message',
        );

        final message = failure.message;
        expect(message, 'Circuit breaker message');
        expect(failure.message, 'Circuit breaker message');
      });

      test('returns default message for circuit breaker failure', () {
        const failure = CircuitBreakerFailure();

        final message = failure.message;
        expect(message, 'Service temporarily unavailable');
        expect(failure.message, 'Service temporarily unavailable');
      });
    });

    group('isRetryable getter', () {
      test('returns true for retryable failures', () {
        const server = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const network = NetworkFailure();

        expect(server.isRetryable, true);
        expect(network.isRetryable, true);
      });

      test('returns false for non-retryable failures', () {
        const cache = CacheFailure();
        const parse = ParseFailure();

        expect(cache.isRetryable, false);
        expect(parse.isRetryable, false);
      });

      test('returns true for circuit breaker failure', () {
        const circuitBreaker = CircuitBreakerFailure();

        expect(circuitBreaker.isRetryable, true);
      });
    });

    group('toString', () {
      test('returns string representation for server failure', () {
        const failure = ServerFailure(
          message: 'Server error',
          statusCode: 500,
        );

        final string = failure.toString();
        expect(string, contains('InfrastructureFailure.server'));
        expect(string, contains('Server error'));
        expect(string, contains('500'));
      });

      test(
        'returns string representation for server failure without status code',
        () {
          const failure = ServerFailure(
            message: 'Server error',
          );

          final string = failure.toString();
          expect(string, contains('InfrastructureFailure.server'));
          expect(string, contains('Server error'));
        },
      );

      test('returns string representation for network failure', () {
        const failure = NetworkFailure();

        final string = failure.toString();
        expect(string, contains('InfrastructureFailure.network'));
        expect(string, contains('Network error'));
      });

      test('returns string representation for cache failure', () {
        const failure = CacheFailure();

        final string = failure.toString();
        expect(string, contains('InfrastructureFailure.cache'));
        expect(string, contains('Cache error'));
      });

      test('returns string representation for parse failure', () {
        const failure = ParseFailure();

        final string = failure.toString();
        expect(string, contains('InfrastructureFailure.parse'));
        expect(string, contains('Parse error'));
      });

      test('returns string representation for circuit breaker failure', () {
        const failure = CircuitBreakerFailure();

        final string = failure.toString();
        expect(string, contains('InfrastructureFailure.circuitBreaker'));
        expect(string, contains('Service temporarily unavailable'));
      });
    });

    group('type safety', () {
      test('different failure types are not equal', () {
        const server = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const network = NetworkFailure(message: 'Error');
        const cache = CacheFailure(message: 'Error');
        const parse = ParseFailure(message: 'Error');

        expect(server, isNot(network));
        expect(server, isNot(cache));
        expect(server, isNot(parse));
        expect(network, isNot(cache));
        expect(network, isNot(parse));
        expect(cache, isNot(parse));
      });

      test('all failure types implement Failure interface', () {
        const server = ServerFailure(
          message: 'Error',
          statusCode: 500,
        );
        const network = NetworkFailure();
        const cache = CacheFailure();
        const parse = ParseFailure();
        const circuitBreaker = CircuitBreakerFailure();

        expect(server, isA<Failure>());
        expect(network, isA<Failure>());
        expect(cache, isA<Failure>());
        expect(parse, isA<Failure>());
        expect(circuitBreaker, isA<Failure>());
      });
    });
  });
}

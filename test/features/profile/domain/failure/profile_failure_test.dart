import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/features/profile/domain/failure/profile_failure.dart';

void main() {
  group('ProfileFailure', () {
    const message = 'Test message';
    final stackTrace = StackTrace.current;

    group('unexpected', () {
      test('should have correct properties', () {
        final failure = ProfileUnexpectedFailure(
          message: message,
          stackTrace: stackTrace,
        );

        expect(failure.message, equals(message));
        expect(failure.stackTrace, equals(stackTrace));
      });

      test('isRetryable should be false', () {
        const failure = ProfileUnexpectedFailure(message: message);
        expect(failure.isRetryable, isFalse);
      });
    });

    group('serverError', () {
      test('should have correct properties', () {
        final failure = ProfileServerError(
          message: message,
          stackTrace: stackTrace,
        );

        expect(failure.message, equals(message));
        expect(failure.stackTrace, equals(stackTrace));
      });

      test('isRetryable should be true', () {
        const failure = ProfileServerError(message: message);
        expect(failure.isRetryable, isTrue);
      });
    });

    group('notFound', () {
      test('should have correct properties', () {
        final failure = ProfileNotFoundFailure(
          message: message,
          stackTrace: stackTrace,
        );

        expect(failure.message, equals(message));
        expect(failure.stackTrace, equals(stackTrace));
      });

      test('isRetryable should be false', () {
        const failure = ProfileNotFoundFailure(message: message);
        expect(failure.isRetryable, isFalse);
      });
    });
  });
}

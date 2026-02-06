import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/error/failures/value_failure.dart';
import 'package:starter_app/features/auth/domain/value_objects/token_failure.dart';

void main() {
  group('TokenFailure', () {
    group('TokenEmpty', () {
      test('creates correctly', () {
        const failure = TokenEmpty();

        expect(failure, isA<TokenEmpty>());
        expect(failure, isA<TokenFailure>());
        expect(failure, isA<ValueFailure<dynamic>>());
      });

      test('equality works correctly', () {
        const failure1 = TokenEmpty();
        const failure2 = TokenEmpty();

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('TokenTooShort', () {
      test('creates correctly with required parameters', () {
        const failure = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );

        expect(failure, isA<TokenTooShort>());
        expect(failure, isA<TokenFailure>());
      });

      test('stores minLength and actualLength correctly', () {
        const failure = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );

        expect(failure.minLength, 10);
        expect(failure.actualLength, 5);
      });

      test('equality works correctly with same values', () {
        const failure1 = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );
        const failure2 = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );

        expect(failure1, equals(failure2));
      });

      test('inequality works correctly with different values', () {
        const failure1 = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );
        const failure2 = TokenTooShort(
          minLength: 8,
          actualLength: 3,
        );

        expect(failure1, isNot(equals(failure2)));
      });
    });

    group('TokenInvalidFormat', () {
      test('creates correctly with required parameters', () {
        const failure = TokenInvalidFormat(
          expectedFormat: 'JWT',
        );

        expect(failure, isA<TokenInvalidFormat>());
        expect(failure, isA<TokenFailure>());
      });

      test('stores expectedFormat correctly', () {
        const failure = TokenInvalidFormat(
          expectedFormat: 'JWT',
        );

        expect(failure.expectedFormat, 'JWT');
      });

      test('equality works correctly', () {
        const failure1 = TokenInvalidFormat(
          expectedFormat: 'JWT',
        );
        const failure2 = TokenInvalidFormat(
          expectedFormat: 'JWT',
        );

        expect(failure1, equals(failure2));
      });
    });

    group('TokenExpired', () {
      test('creates correctly', () {
        const failure = TokenExpired();

        expect(failure, isA<TokenExpired>());
        expect(failure, isA<TokenFailure>());
      });

      test('equality works correctly', () {
        const failure1 = TokenExpired();
        const failure2 = TokenExpired();

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('exhaustive switch handling', () {
      test('handles all variants in single switch', () {
        const failures = <TokenFailure>[
          TokenEmpty(),
          TokenTooShort(minLength: 10, actualLength: 5),
          TokenInvalidFormat(expectedFormat: 'JWT'),
          TokenExpired(),
        ];

        for (final failure in failures) {
          final message = switch (failure) {
            TokenEmpty() => 'empty',
            TokenTooShort(:final minLength, :final actualLength) =>
              'tooShort:$minLength:$actualLength',
            TokenInvalidFormat(:final expectedFormat) =>
              'invalidFormat:$expectedFormat',
            TokenExpired() => 'expired',
          };
          expect(message, isNotEmpty);
        }
      });

      test('switch with destructuring accesses properties', () {
        const TokenFailure failure = TokenTooShort(
          minLength: 10,
          actualLength: 5,
        );

        final result = switch (failure) {
          TokenEmpty() => 'empty',
          TokenTooShort(:final minLength, :final actualLength) =>
            'Min: $minLength, Actual: $actualLength',
          TokenInvalidFormat(:final expectedFormat) =>
            'Format: $expectedFormat',
          TokenExpired() => 'expired',
        };

        expect(result, 'Min: 10, Actual: 5');
      });
    });

    group('inequality between variants', () {
      test('different variants are not equal', () {
        const empty = TokenEmpty();
        const tooShort = TokenTooShort(minLength: 10, actualLength: 5);
        const invalidFormat = TokenInvalidFormat(expectedFormat: 'JWT');
        const expired = TokenExpired();

        expect(empty, isNot(equals(tooShort)));
        expect(empty, isNot(equals(invalidFormat)));
        expect(empty, isNot(equals(expired)));
        expect(tooShort, isNot(equals(invalidFormat)));
        expect(tooShort, isNot(equals(expired)));
        expect(invalidFormat, isNot(equals(expired)));
      });
    });
  });
}

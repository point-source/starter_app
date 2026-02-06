import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/domain/base/unique_id_failure.dart';
import 'package:starter_app/core/error/failures/value_failure.dart';

void main() {
  group('UniqueIdFailure', () {
    group('UniqueIdEmpty', () {
      test('creates correctly', () {
        const failure = UniqueIdEmpty();

        expect(failure, isA<UniqueIdEmpty>());
        expect(failure, isA<UniqueIdFailure>());
        expect(failure, isA<ValueFailure<dynamic>>());
      });

      test('equality works correctly', () {
        const failure1 = UniqueIdEmpty();
        const failure2 = UniqueIdEmpty();

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('UniqueIdInvalidFormat', () {
      test('creates correctly', () {
        const failure = UniqueIdInvalidFormat();

        expect(failure, isA<UniqueIdInvalidFormat>());
        expect(failure, isA<UniqueIdFailure>());
        expect(failure, isA<ValueFailure<dynamic>>());
      });

      test('equality works correctly', () {
        const failure1 = UniqueIdInvalidFormat();
        const failure2 = UniqueIdInvalidFormat();

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });
    });

    group('inequality between variants', () {
      test('empty is not equal to invalidFormat', () {
        const empty = UniqueIdEmpty();
        const invalidFormat = UniqueIdInvalidFormat();

        expect(empty, isNot(equals(invalidFormat)));
      });
    });

    group('toString', () {
      test('empty returns meaningful representation', () {
        const failure = UniqueIdEmpty();

        expect(failure.toString(), contains('UniqueIdFailure'));
      });

      test('invalidFormat returns meaningful representation', () {
        const failure = UniqueIdInvalidFormat();

        expect(failure.toString(), contains('UniqueIdFailure'));
      });
    });

    group('exhaustive switch handling', () {
      test('handles all variants in single switch', () {
        const failures = <UniqueIdFailure>[
          UniqueIdEmpty(),
          UniqueIdInvalidFormat(),
        ];

        for (final failure in failures) {
          final message = switch (failure) {
            UniqueIdEmpty() => 'empty',
            UniqueIdInvalidFormat() => 'invalidFormat',
          };
          expect(message, isNotEmpty);
        }
      });
    });
  });
}

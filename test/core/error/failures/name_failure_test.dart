import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/domain/value_objects/name_failure.dart';
import 'package:starter_app/core/error/failures/value_failure.dart';

void main() {
  group('NameFailure', () {
    group('NameEmpty', () {
      test('creates correctly', () {
        const failure = NameEmpty();

        expect(failure, isA<NameEmpty>());
        expect(failure, isA<NameFailure>());
        expect(failure, isA<ValueFailure<dynamic>>());
      });

      test('equality works correctly', () {
        const failure1 = NameEmpty();
        const failure2 = NameEmpty();

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('toString returns meaningful representation', () {
        const failure = NameEmpty();

        expect(failure.toString(), contains('NameFailure'));
      });
    });

    group('NameTooLong', () {
      test('creates correctly', () {
        const failure = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );

        expect(failure, isA<NameTooLong>());
        expect(failure, isA<NameFailure>());
        expect(failure, isA<ValueFailure<dynamic>>());
      });

      test('stores maxLength and actualLength', () {
        const failure = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );

        expect(failure.maxLength, 100);
        expect(failure.actualLength, 150);
      });

      test('equality works correctly', () {
        const failure1 = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );
        const failure2 = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );

        expect(failure1, equals(failure2));
        expect(failure1.hashCode, equals(failure2.hashCode));
      });

      test('different values are not equal', () {
        const failure1 = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );
        const failure2 = NameTooLong(
          maxLength: 100,
          actualLength: 200,
        );

        expect(failure1, isNot(equals(failure2)));
      });
    });

    group('inequality between variants', () {
      test('empty is not equal to tooLong', () {
        const empty = NameEmpty();
        const tooLong = NameTooLong(maxLength: 100, actualLength: 150);

        expect(empty, isNot(equals(tooLong)));
      });
    });

    group('exhaustive switch handling', () {
      test('handles all variants in single switch', () {
        const failures = <NameFailure>[
          NameEmpty(),
          NameTooLong(maxLength: 50, actualLength: 75),
        ];

        for (final failure in failures) {
          final message = switch (failure) {
            NameEmpty() => 'empty',
            NameTooLong(:final maxLength, :final actualLength) =>
              'tooLong:$maxLength:$actualLength',
          };
          expect(message, isNotEmpty);
        }
      });

      test('switch with destructuring accesses properties', () {
        const NameFailure failure = NameTooLong(
          maxLength: 100,
          actualLength: 150,
        );

        final result = switch (failure) {
          NameEmpty() => 'empty',
          NameTooLong(:final actualLength) => 'tooLong: $actualLength',
        };

        expect(result, 'tooLong: 150');
      });
    });
  });
}

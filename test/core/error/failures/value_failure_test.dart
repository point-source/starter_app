import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/domain/base/unique_id_failure.dart';
import 'package:starter_app/core/domain/value_objects/email_failure.dart';
import 'package:starter_app/core/domain/value_objects/name_failure.dart';
import 'package:starter_app/core/domain/value_objects/password_failure.dart';
import 'package:starter_app/core/error/failures/value_failure.dart';
import 'package:starter_app/features/auth/domain/value_objects/token_failure.dart';

void main() {
  group('ValueFailure hierarchy', () {
    test('all domain-specific failures extend ValueFailure', () {
      const PasswordFailure passwordFailure = PasswordEmpty();
      const EmailFailure emailFailure = EmailEmpty();
      const NameFailure nameFailure = NameEmpty();
      const TokenFailure tokenFailure = TokenEmpty();
      const UniqueIdFailure uniqueIdFailure = UniqueIdEmpty();

      expect(passwordFailure, isA<ValueFailure<String>>());
      expect(emailFailure, isA<ValueFailure<String>>());
      expect(nameFailure, isA<ValueFailure<String>>());
      expect(tokenFailure, isA<ValueFailure<String>>());
      expect(uniqueIdFailure, isA<ValueFailure<String>>());
    });
  });

  group('PasswordFailure', () {
    group('empty', () {
      test('creates empty password failure', () {
        const failure = PasswordEmpty();

        expect(failure, isA<PasswordEmpty>());
      });

      test('equals another empty failure', () {
        const failure1 = PasswordEmpty();
        const failure2 = PasswordEmpty();

        expect(failure1, failure2);
      });
    });

    group('tooShort', () {
      test('creates too short failure with lengths', () {
        const failure = PasswordTooShort(minLength: 8, actualLength: 5);

        expect(failure, isA<PasswordTooShort>());
        expect(failure.minLength, 8);
        expect(failure.actualLength, 5);
      });

      test('equals another tooShort failure with same values', () {
        const failure1 = PasswordTooShort(minLength: 8, actualLength: 5);
        const failure2 = PasswordTooShort(minLength: 8, actualLength: 5);

        expect(failure1, failure2);
      });

      test('not equals tooShort failure with different values', () {
        const failure1 = PasswordTooShort(minLength: 8, actualLength: 5);
        const failure2 = PasswordTooShort(minLength: 10, actualLength: 5);

        expect(failure1, isNot(failure2));
      });
    });

    group('tooLong', () {
      test('creates too long failure with lengths', () {
        const failure = PasswordTooLong(maxLength: 128, actualLength: 150);

        expect(failure, isA<PasswordTooLong>());
        expect(failure.maxLength, 128);
        expect(failure.actualLength, 150);
      });
    });

    group('character requirements', () {
      test('creates missingUppercase failure', () {
        const failure = PasswordMissingUppercase();

        expect(failure, isA<PasswordMissingUppercase>());
      });

      test('creates missingLowercase failure', () {
        const failure = PasswordMissingLowercase();

        expect(failure, isA<PasswordMissingLowercase>());
      });

      test('creates missingDigit failure', () {
        const failure = PasswordMissingDigit();

        expect(failure, isA<PasswordMissingDigit>());
      });

      test('creates missingSpecialCharacter failure', () {
        const failure = PasswordMissingSpecialCharacter();

        expect(failure, isA<PasswordMissingSpecialCharacter>());
      });
    });

    group('pattern matching', () {
      test('switch handles all cases', () {
        const failures = <PasswordFailure>[
          PasswordEmpty(),
          PasswordTooShort(minLength: 8, actualLength: 5),
          PasswordTooLong(maxLength: 128, actualLength: 150),
          PasswordMissingUppercase(),
          PasswordMissingLowercase(),
          PasswordMissingDigit(),
          PasswordMissingSpecialCharacter(),
        ];

        for (final failure in failures) {
          final message = switch (failure) {
            PasswordEmpty() => 'empty',
            PasswordTooShort(:final minLength, :final actualLength) =>
              'tooShort:$minLength:$actualLength',
            PasswordTooLong(:final maxLength, :final actualLength) =>
              'tooLong:$maxLength:$actualLength',
            PasswordMissingUppercase() => 'uppercase',
            PasswordMissingLowercase() => 'lowercase',
            PasswordMissingDigit() => 'digit',
            PasswordMissingSpecialCharacter() => 'special',
          };
          expect(message, isNotEmpty);
        }
      });
    });
  });

  group('EmailFailure', () {
    test('creates empty failure', () {
      const failure = EmailEmpty();

      expect(failure, isA<EmailEmpty>());
    });

    test('creates tooLong failure with lengths', () {
      const failure = EmailTooLong(maxLength: 254, actualLength: 300);

      expect(failure, isA<EmailTooLong>());
      expect(failure.maxLength, 254);
      expect(failure.actualLength, 300);
    });

    test('creates invalidFormat failure with failed value', () {
      const failure = EmailInvalidFormat(failedValue: 'not-an-email');

      expect(failure, isA<EmailInvalidFormat>());
      expect(failure.failedValue, 'not-an-email');
    });

    test('switch handles all cases', () {
      const failures = <EmailFailure>[
        EmailEmpty(),
        EmailTooLong(maxLength: 254, actualLength: 300),
        EmailInvalidFormat(failedValue: 'invalid'),
      ];

      for (final failure in failures) {
        final message = switch (failure) {
          EmailEmpty() => 'empty',
          EmailTooLong(:final maxLength, :final actualLength) =>
            'tooLong:$maxLength:$actualLength',
          EmailInvalidFormat(:final failedValue) => 'invalid:$failedValue',
        };
        expect(message, isNotEmpty);
      }
    });
  });

  group('NameFailure', () {
    test('creates empty failure', () {
      const failure = NameEmpty();

      expect(failure, isA<NameEmpty>());
    });

    test('equals another empty failure', () {
      const failure1 = NameEmpty();
      const failure2 = NameEmpty();

      expect(failure1, failure2);
    });

    test('creates tooLong failure with lengths', () {
      const failure = NameTooLong(maxLength: 100, actualLength: 150);

      expect(failure, isA<NameTooLong>());
      expect(failure.maxLength, 100);
      expect(failure.actualLength, 150);
    });

    test('switch handles all cases', () {
      const failures = <NameFailure>[
        NameEmpty(),
        NameTooLong(maxLength: 100, actualLength: 150),
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
  });

  group('TokenFailure', () {
    test('creates empty failure', () {
      const failure = TokenEmpty();

      expect(failure, isA<TokenEmpty>());
    });

    test('creates tooShort failure', () {
      const failure = TokenTooShort(minLength: 10, actualLength: 5);

      expect(failure, isA<TokenTooShort>());
      expect(failure.minLength, 10);
      expect(failure.actualLength, 5);
    });

    test('creates invalidFormat failure', () {
      const failure = TokenInvalidFormat(expectedFormat: 'JWT');

      expect(failure, isA<TokenInvalidFormat>());
      expect(failure.expectedFormat, 'JWT');
    });

    test('creates expired failure', () {
      const failure = TokenExpired();

      expect(failure, isA<TokenExpired>());
    });

    test('switch handles all cases', () {
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
  });

  group('UniqueIdFailure', () {
    test('creates empty failure', () {
      const failure = UniqueIdEmpty();

      expect(failure, isA<UniqueIdEmpty>());
    });

    test('creates invalidFormat failure', () {
      const failure = UniqueIdInvalidFormat();

      expect(failure, isA<UniqueIdInvalidFormat>());
    });

    test('switch handles all cases', () {
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
}

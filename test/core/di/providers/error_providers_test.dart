import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/di/providers/environment_providers.dart';
import 'package:starter_app/core/di/providers/error_providers.dart';
import 'package:starter_app/core/domain/ports/i_data_filter.dart';
import 'package:starter_app/core/domain/ports/i_error_reporter.dart';
import 'package:starter_app/core/error/reporters/no_op_error_reporter.dart';
import 'package:starter_app/core/error/reporters/sentry_error_reporter.dart';
import 'package:starter_app/core/error/sensitive_data_filter.dart';

void main() {
  group('Error Providers', () {
    test('dataFilterProvider returns SensitiveDataFilter', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final filter = container.read(dataFilterProvider);

      expect(filter, isA<SensitiveDataFilter>());
    });

    test('errorReporterProvider returns NoOpErrorReporter in development', () {
      final container = ProviderContainer(
        overrides: [
          appEnvironmentProvider.overrideWithValue(AppEnvironment.development),
        ],
      );
      addTearDown(container.dispose);

      final reporter = container.read(errorReporterProvider);

      expect(reporter, isA<NoOpErrorReporter>());
    });

    test('errorReporterProvider returns SentryErrorReporter in staging', () {
      final container = ProviderContainer(
        overrides: [
          appEnvironmentProvider.overrideWithValue(AppEnvironment.staging),
        ],
      );
      addTearDown(container.dispose);

      final reporter = container.read(errorReporterProvider);

      expect(reporter, isA<SentryErrorReporter>());
    });

    test('errorReporterProvider returns SentryErrorReporter in production', () {
      final container = ProviderContainer(
        overrides: [
          appEnvironmentProvider.overrideWithValue(AppEnvironment.production),
        ],
      );
      addTearDown(container.dispose);

      final reporter = container.read(errorReporterProvider);

      expect(reporter, isA<SentryErrorReporter>());
    });
  });
}

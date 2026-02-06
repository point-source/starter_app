import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/logging/loggers/console_logger.dart';

void main() {
  group('Logging Providers', () {
    test('appLoggerProvider returns ConsoleLogger', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final logger = container.read(appLoggerProvider);

      expect(logger, isA<ConsoleLogger>());
    });
  });
}

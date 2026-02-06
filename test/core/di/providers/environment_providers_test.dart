import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/di/providers/environment_providers.dart';

void main() {
  group('Environment Providers', () {
    test('appEnvironmentProvider returns current environment', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final environment = container.read(appEnvironmentProvider);

      expect(environment, AppEnvironment.current);
    });
  });
}

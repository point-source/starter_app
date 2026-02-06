import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/application/di/application_providers.dart';
import 'package:url_strategy/url_strategy.dart';

/// Shared bootstrap logic for all app flavors.
Future<void> bootstrap<T extends Widget>({
  required AppEnvironment environment,
  required List<Override> overrides,
  required T Function() builder,
}) async {
  // Web-specific configuration
  if (kIsWeb) {
    // Remove '#' from URLs for cleaner web navigation
    setPathUrlStrategy();
  }

  // Wrap everything in a guarded zone to catch async errors
  return runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      // Create a container to initialize services before running the app
      final container = ProviderContainer(overrides: overrides);

      // Initialize BootstrapService
      try {
        final bootstrapService = container.read(bootstrapServiceProvider);
        await bootstrapService.initialize(environment);
        bootstrapService
          ..setupErrorHandling()
          ..setupNavigationLogging();
      } catch (e, stack) {
        debugPrint('Bootstrap initialization failed: $e\n$stack');
      }

      // Run the app with the initialized container
      runApp(
        UncontrolledProviderScope(
          container: container,
          child: builder(),
        ),
      );
    },
    (error, stack) {
      // Fallback logging for zone errors
      debugPrint('Uncaught async error: $error\n$stack');
      // Ideally we would access AppErrorHandlingService here, but we don't have reference to container easily.
    },
  );
}

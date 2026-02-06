import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/application/app_error_handling_service.dart';
import 'package:starter_app/core/application/app_monitoring_service.dart';
import 'package:starter_app/core/application/app_navigation_logging_service.dart';
import 'package:starter_app/core/application/bootstrap_service.dart';
import 'package:starter_app/core/domain/base/domain_event.dart';
import 'package:starter_app/core/domain/base/event_dispatcher.dart';
import 'package:starter_app/core/domain/ports/i_certificate_service.dart';
import 'package:starter_app/core/domain/ports/i_monitoring_initializer.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/domain/ports/i_session_manager.dart';
import 'package:starter_app/core/domain/ports/i_token_refresh_notifier.dart';
import 'package:starter_app/core/infrastructure/error/sentry_monitoring_initializer.dart';
import 'package:starter_app/core/infrastructure/security/certificate_service.dart';
import 'package:starter_app/core/infrastructure/session/session_manager_impl.dart';
import 'package:starter_app/core/infrastructure/token/token_refresh_notifier_impl.dart';
import 'package:starter_app/core/navigation/navigation_tracking_service.dart';
import 'package:starter_app/core/di/providers/bloc_providers.dart';
import 'package:starter_app/core/di/providers/error_providers.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/di/providers/platform_providers.dart';
import 'package:starter_app/core/di/providers/storage_providers.dart';

part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
ISessionManager sessionManager(SessionManagerRef ref) {
  final manager = SessionManagerImpl();
  ref.onDispose(() => manager.dispose());
  return manager;
}

@Riverpod(keepAlive: true)
ITokenRefreshNotifier tokenRefreshNotifier(TokenRefreshNotifierRef ref) {
  final notifier = TokenRefreshNotifierImpl();
  ref.onDispose(() => notifier.dispose());
  return notifier;
}

@Riverpod(keepAlive: true)
ICertificateService certificateService(CertificateServiceRef ref) {
  final logger = ref.watch(appLoggerProvider);
  return CertificateService(logger);
}

@Riverpod(keepAlive: true)
IEventDispatcher eventDispatcher(EventDispatcherRef ref) {
  final dispatcher = EventDispatcher();
  ref.onDispose(() => dispatcher.dispose());
  return dispatcher;
}

@Riverpod(keepAlive: true)
IMonitoringInitializer monitoringInitializer(MonitoringInitializerRef ref) {
  return const SentryMonitoringInitializer();
}

@Riverpod(keepAlive: true)
AppMonitoringService appMonitoringService(AppMonitoringServiceRef ref) {
  final logger = ref.watch(appLoggerProvider);
  final errorReporter = ref.watch(errorReporterProvider);
  final platformInfo = ref.watch(platformInfoProvider);
  final monitoringInitializer = ref.watch(monitoringInitializerProvider);

  return AppMonitoringService(
    logger,
    errorReporter,
    platformInfo,
    monitoringInitializer,
  );
}

@Riverpod(keepAlive: true)
AppErrorHandlingService appErrorHandlingService(AppErrorHandlingServiceRef ref) {
  final logger = ref.watch(appLoggerProvider);
  final errorReporter = ref.watch(errorReporterProvider);
  return AppErrorHandlingService(logger, errorReporter);
}

@Riverpod(keepAlive: true)
INavigationTrackingService navigationTrackingService(NavigationTrackingServiceRef ref) {
  final service = NavigationTrackingService();
  ref.onDispose(() => service.dispose());
  return service;
}

@Riverpod(keepAlive: true)
AppNavigationLoggingService appNavigationLoggingService(AppNavigationLoggingServiceRef ref) {
  final trackingService = ref.watch(navigationTrackingServiceProvider);
  final logger = ref.watch(appLoggerProvider);
  return AppNavigationLoggingService(trackingService, logger);
}

@Riverpod(keepAlive: true)
BootstrapService bootstrapService(BootstrapServiceRef ref) {
  final storage = ref.watch(hydratedStorageProvider);
  final observer = ref.watch(blocObserverProvider);
  final monitoring = ref.watch(appMonitoringServiceProvider);
  final errorHandling = ref.watch(appErrorHandlingServiceProvider);
  final navLogging = ref.watch(appNavigationLoggingServiceProvider);
  final certService = ref.watch(certificateServiceProvider);

  return BootstrapService(
    storage,
    observer,
    monitoring,
    errorHandling,
    navLogging,
    certService,
  );
}

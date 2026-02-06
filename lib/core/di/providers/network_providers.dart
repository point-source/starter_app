import 'package:chopper/chopper.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/api/interceptors/auth_interceptor.dart';
import 'package:starter_app/core/api/interceptors/circuit_breaker_interceptor.dart';
import 'package:starter_app/core/api/interceptors/error_interceptor.dart';
import 'package:starter_app/core/api/interceptors/logging_interceptor.dart';
import 'package:starter_app/core/api/interceptors/network_error_handler.dart';
import 'package:starter_app/core/api/interceptors/refresh_token_interceptor.dart';
import 'package:starter_app/core/application/application_environment.dart';
import 'package:starter_app/core/di/providers/environment_providers.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/di/providers/storage_providers.dart';
import 'package:starter_app/core/application/di/application_providers.dart';
import 'package:starter_app/core/domain/ports/ports.dart';
import 'package:starter_app/core/infrastructure/circuit_breaker/circuit_breaker_config.dart';
import 'package:starter_app/core/infrastructure/circuit_breaker/circuit_breaker_impl.dart';
import 'package:starter_app/core/infrastructure/networking/http_client_factory.dart';
import 'package:starter_app/core/infrastructure/websocket/websocket_manager.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_endpoints.dart';
import 'package:synchronized/synchronized.dart';

part 'network_providers.g.dart';

@Riverpod(keepAlive: true)
String webSocketBaseUrl(WebSocketBaseUrlRef ref) {
  return AppEnvironment.current.webSocketUrl;
}

@Riverpod(keepAlive: true)
IWebSocketManager webSocketManager(WebSocketManagerRef ref) {
  final baseUrl = ref.watch(webSocketBaseUrlProvider);
  final logger = ref.watch(appLoggerProvider);
  return WebSocketManager(baseUrl, logger);
}

@Riverpod(keepAlive: true)
NetworkErrorHandler networkErrorHandler(NetworkErrorHandlerRef ref) {
  return const NetworkErrorHandler();
}

@Riverpod(keepAlive: true)
Lock tokenRefreshLock(TokenRefreshLockRef ref) {
  return Lock();
}

@Riverpod(keepAlive: true)
CircuitBreakerConfig circuitBreakerConfig(CircuitBreakerConfigRef ref) {
  return CircuitBreakerConfig.defaultConfig;
}

@Riverpod(keepAlive: true)
ICircuitBreaker circuitBreaker(CircuitBreakerRef ref) {
  final logger = ref.watch(appLoggerProvider);
  final config = ref.watch(circuitBreakerConfigProvider);
  return CircuitBreakerImpl(logger: logger, config: config);
}

@Riverpod(keepAlive: true)
ChopperClient chopperClient(ChopperClientRef ref) {
  final logger = ref.watch(appLoggerProvider);
  final networkErrorHandler = ref.watch(networkErrorHandlerProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final sessionManager = ref.watch(sessionManagerProvider);
  final tokenRefreshNotifier = ref.watch(tokenRefreshNotifierProvider);
  final refreshLock = ref.watch(tokenRefreshLockProvider);
  final circuitBreaker = ref.watch(circuitBreakerProvider);
  final certificateService = ref.watch(certificateServiceProvider);

  final apiBaseUrl = AppEnvironment.current.apiBaseUrl;

  final httpClient = getHttpClientFactory().createClient(
    trustedCertificateBytes: certificateService.trustedCertificateBytes,
  );

  return ChopperClient(
    baseUrl: Uri.parse(apiBaseUrl),
    client: httpClient,
    converter: const JsonConverter(),
    errorConverter: const JsonConverter(),
    interceptors: [
      CircuitBreakerInterceptor(circuitBreaker),
      AuthInterceptor(() => tokenStorage.getAccessToken()),
      RefreshTokenInterceptor(
        tokenStorage: tokenStorage,
        refreshTokenEndpoint: AuthEndpoints.refreshToken,
        onRefreshFailed: sessionManager.notifySessionExpired,
        onRefreshSuccess: tokenRefreshNotifier.notifyTokenRefreshed,
        baseUrl: Uri.parse(apiBaseUrl),
        refreshLock: refreshLock,
      ),
      LoggingInterceptor(logger),
      ErrorInterceptor(networkErrorHandler),
    ],
  );
}

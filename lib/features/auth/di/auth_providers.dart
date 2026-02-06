import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/di/providers/network_providers.dart';
import 'package:starter_app/core/di/providers/storage_providers.dart';
import 'package:starter_app/core/application/di/application_providers.dart';
import 'package:starter_app/core/error/di/error_handlers_providers.dart';
import 'package:starter_app/core/presentation/di/presentation_providers.dart';
import 'package:starter_app/features/auth/application/usecases/check_user_exists.dart';
import 'package:starter_app/features/auth/application/usecases/get_current_user.dart';
import 'package:starter_app/features/auth/application/usecases/login.dart';
import 'package:starter_app/features/auth/application/usecases/logout.dart';
import 'package:starter_app/features/auth/application/usecases/register.dart';
import 'package:starter_app/features/auth/application/usecases/watch_auth_changes.dart';
import 'package:starter_app/features/auth/application/usecases/watch_session_expired.dart';
import 'package:starter_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_api_service.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_remote_data_source.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_websocket_data_source.dart';
import 'package:starter_app/features/auth/infrastructure/mappers/auth_exception_mapper.dart';
import 'package:starter_app/features/auth/infrastructure/repositories/auth_repository_impl.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/failure_message/auth_failure_mapper.dart';

part 'auth_providers.g.dart';

// --- Data Sources ---

@Riverpod(keepAlive: true)
AuthApiService authApiService(AuthApiServiceRef ref) {
  final client = ref.watch(chopperClientProvider);
  return AuthApiService.create(client);
}

@Riverpod(keepAlive: true)
IAuthRemoteDataSource authRemoteDataSource(AuthRemoteDataSourceRef ref) {
  final apiService = ref.watch(authApiServiceProvider);
  return AuthRemoteDataSourceImpl(apiService);
}

@Riverpod(keepAlive: true)
IAuthWebSocketDataSource authWebSocketDataSource(AuthWebSocketDataSourceRef ref) {
  final wsManager = ref.watch(webSocketManagerProvider);
  final tokenStorage = ref.watch(tokenStorageProvider);
  final notifier = ref.watch(tokenRefreshNotifierProvider);
  final logger = ref.watch(appLoggerProvider);
  return AuthWebSocketDataSource(wsManager, tokenStorage, notifier, logger);
}

@Riverpod(keepAlive: true)
AuthExceptionMapper authExceptionMapper(AuthExceptionMapperRef ref) {
  return const AuthExceptionMapper();
}

// --- Repository ---

@Riverpod(keepAlive: true)
IAuthRepository authRepository(AuthRepositoryRef ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final ws = ref.watch(authWebSocketDataSourceProvider);
  final storage = ref.watch(tokenStorageProvider);
  final exceptionHandler = ref.watch(exceptionHandlerProvider);
  final mapper = ref.watch(authExceptionMapperProvider);

  return AuthRepositoryImpl(remote, ws, storage, exceptionHandler, mapper);
}

// --- Use Cases ---

@Riverpod(keepAlive: true)
CheckUserExists checkUserExists(CheckUserExistsRef ref) {
  return CheckUserExists(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
Login login(LoginRef ref) {
  return Login(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
Register register(RegisterRef ref) {
  return Register(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
Logout logout(LogoutRef ref) {
  return Logout(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
GetCurrentUser getCurrentUser(GetCurrentUserRef ref) {
  return GetCurrentUser(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchAuthChanges watchAuthChanges(WatchAuthChangesRef ref) {
  return WatchAuthChanges(ref.watch(authRepositoryProvider));
}

@Riverpod(keepAlive: true)
WatchSessionExpired watchSessionExpired(WatchSessionExpiredRef ref) {
  // WatchSessionExpired depends on ISessionManager, NOT Repository.
  final sessionManager = ref.watch(sessionManagerProvider);
  return WatchSessionExpired(sessionManager);
}

// --- Bloc ---

@Riverpod(keepAlive: true)
AuthBloc authBloc(AuthBlocRef ref) {
  // Ensure failure mapper is registered
  ref.watch(authFailureMessageMapperProvider);

  final checkUserExists = ref.watch(checkUserExistsProvider);
  final login = ref.watch(loginProvider);
  final register = ref.watch(registerProvider);
  final logout = ref.watch(logoutProvider);
  final getCurrentUser = ref.watch(getCurrentUserProvider);
  final watchAuthChanges = ref.watch(watchAuthChangesProvider);
  final watchSessionExpired = ref.watch(watchSessionExpiredProvider);
  final logger = ref.watch(appLoggerProvider);

  final bloc = AuthBloc(
    checkUserExists,
    login,
    register,
    logout,
    getCurrentUser,
    watchAuthChanges,
    watchSessionExpired,
    logger,
  );

  bloc.add(const AuthGetCurrentUser());
  ref.onDispose(() => bloc.close());

  return bloc;
}

// --- Failure Mapper ---

@Riverpod(keepAlive: true)
AuthFailureMessageMapper authFailureMessageMapper(AuthFailureMessageMapperRef ref) {
  final mapper = AuthFailureMessageMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper);
  return mapper;
}

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:starter_app/core/di/providers/network_providers.dart';
import 'package:starter_app/core/error/di/error_handlers_providers.dart';
import 'package:starter_app/core/application/di/application_providers.dart';
import 'package:starter_app/core/presentation/di/presentation_providers.dart';
import 'package:starter_app/features/profile/application/usecases/get_profile.dart';
import 'package:starter_app/features/profile/domain/repositories/i_user_profile_repository.dart';
import 'package:starter_app/features/profile/infrastructure/datasources/profile_api_service.dart';
import 'package:starter_app/features/profile/infrastructure/datasources/user_profile_remote_data_source.dart';
import 'package:starter_app/features/profile/infrastructure/mappers/profile_exception_mapper.dart';
import 'package:starter_app/features/profile/infrastructure/repositories/user_profile_repository_impl.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/failure_message/profile_failure_mapper.dart';

part 'profile_providers.g.dart';

// --- Data Sources ---

@Riverpod(keepAlive: true)
ProfileApiService profileApiService(ProfileApiServiceRef ref) {
  final client = ref.watch(chopperClientProvider);
  return ProfileApiService.create(client);
}

@Riverpod(keepAlive: true)
IUserProfileRemoteDataSource userProfileRemoteDataSource(UserProfileRemoteDataSourceRef ref) {
  final apiService = ref.watch(profileApiServiceProvider);
  return UserProfileRemoteDataSourceImpl(apiService);
}

@Riverpod(keepAlive: true)
ProfileExceptionMapper profileExceptionMapper(ProfileExceptionMapperRef ref) {
  return const ProfileExceptionMapper();
}

// --- Repository ---

@Riverpod(keepAlive: true)
IUserProfileRepository userProfileRepository(UserProfileRepositoryRef ref) {
  final remote = ref.watch(userProfileRemoteDataSourceProvider);
  final exceptionHandler = ref.watch(exceptionHandlerProvider);
  final mapper = ref.watch(profileExceptionMapperProvider);

  return UserProfileRepositoryImpl(remote, exceptionHandler, mapper);
}

// --- Use Cases ---

@Riverpod(keepAlive: true)
GetProfile getProfile(GetProfileRef ref) {
  return GetProfile(ref.watch(userProfileRepositoryProvider));
}

// --- Bloc ---

@Riverpod(keepAlive: true)
ProfileBloc profileBloc(ProfileBlocRef ref) {
  // Ensure failure mapper is registered
  ref.watch(profileFailureMapperProvider);

  final getProfile = ref.watch(getProfileProvider);
  final eventDispatcher = ref.watch(eventDispatcherProvider);

  final bloc = ProfileBloc(getProfile, eventDispatcher);
  ref.onDispose(() => bloc.close());
  return bloc;
}

// --- Failure Mapper ---

@Riverpod(keepAlive: true)
ProfileFailureMapper profileFailureMapper(ProfileFailureMapperRef ref) {
  final mapper = ProfileFailureMapper();
  ref.watch(failureMapperRegistryProvider).register(mapper);
  return mapper;
}

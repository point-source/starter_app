import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/ports/i_token_storage.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/auth_guard.dart';
import 'package:starter_app/core/presentation/bloc/locale_cubit.dart';
import 'package:starter_app/core/presentation/bloc/theme_cubit.dart';
import 'package:starter_app/core/presentation/failure_message/failure_mapper_registry.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_remote_data_source.dart';
import 'package:starter_app/features/auth/infrastructure/datasources/auth_websocket_data_source.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/profile/domain/repositories/i_user_profile_repository.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';

// Navigation
class MockAppRouter extends Mock implements AppRouter {}

class MockStackRouter extends Mock implements StackRouter {}

class MockAuthChangeNotifier extends Mock implements AuthChangeNotifier {}

class MockAuthGuard extends Mock implements AuthGuard {}

// Repositories
class MockAuthRepository extends Mock implements IAuthRepository {}

class MockUserProfileRepository extends Mock
    implements IUserProfileRepository {}

// Data Sources
class MockAuthRemoteDataSource extends Mock implements IAuthRemoteDataSource {}

class MockAuthWebsocketDataSource extends Mock
    implements IAuthWebSocketDataSource {}

// Services
class MockTokenStorage extends Mock implements ITokenStorage {}

class MockAppLogger extends Mock implements IAppLogger {}

class MockFailureMessageService extends Mock implements FailureMessageService {}

// BLoCs
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class MockThemeCubit extends MockBloc<void, AppThemeMode>
    implements ThemeCubit {}

class MockLocaleCubit extends MockBloc<void, AppLocale>
    implements LocaleCubit {}

// Mappers
class MockFailureMapperRegistry extends Mock implements FailureMapperRegistry {}

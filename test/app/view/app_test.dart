import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/app/app.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/presentation/bloc/locale_cubit.dart';
import 'package:starter_app/core/presentation/bloc/theme_cubit.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_event.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';

// Mocks with correct types
class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockProfileBloc extends MockBloc<ProfileEvent, ProfileState>
    implements ProfileBloc {}

class MockThemeCubit extends MockCubit<AppThemeMode> implements ThemeCubit {}

class MockLocaleCubit extends MockCubit<AppLocale> implements LocaleCubit {}

class MockAuthChangeNotifier extends Mock implements AuthChangeNotifier {}

class MockFailureMessageService extends Mock implements FailureMessageService {}

class MockAppLogger extends Mock implements IAppLogger {}

class MockAppTheme extends Mock implements AppTheme {}

// Use a mixin to mock AutoRouterObserver effectively or just implement the
// interface?
// NavigationTrackingService extends AutoRouterObserver and
// implements INavigationTrackingService
// We can mock INavigationTrackingService. App checks if it is
// NavigatorObserver.
// So our mock must Implement NavigatorObserver.
class MockNavigationTrackingService extends Mock
    implements INavigationTrackingService, NavigatorObserver {}

void main() {
  group('App', () {
    late MockAuthBloc mockAuthBloc;
    late MockProfileBloc mockProfileBloc;
    late MockThemeCubit mockThemeCubit;
    late MockLocaleCubit mockLocaleCubit;
    late MockAuthChangeNotifier mockAuthChangeNotifier;
    late MockFailureMessageService mockFailureMessageService;
    late MockAppLogger mockAppLogger;
    late MockAppTheme mockAppTheme;
    late MockNavigationTrackingService mockNavigationTrackingService;
    late AppRouter appRouter;

    setUpAll(() {
      registerFallbackValue(AuthInitial.empty());
      registerFallbackValue(const ProfileInitial());
      registerFallbackValue(AppThemeMode.system);
      registerFallbackValue(AppLocale.en);
    });

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      mockProfileBloc = MockProfileBloc();
      mockThemeCubit = MockThemeCubit();
      mockLocaleCubit = MockLocaleCubit();
      mockAuthChangeNotifier = MockAuthChangeNotifier();
      mockFailureMessageService = MockFailureMessageService();
      mockAppLogger = MockAppLogger();
      mockAppTheme = MockAppTheme();
      mockNavigationTrackingService = MockNavigationTrackingService();

      // Use real AppRouter with mocked notifier
      appRouter = AppRouter(mockAuthChangeNotifier);

      when(() => mockAuthBloc.state).thenReturn(AuthInitial.empty());
      when(
        () => mockProfileBloc.state,
      ).thenReturn(const ProfileInitial());
      when(() => mockThemeCubit.state).thenReturn(AppThemeMode.system);
      when(() => mockLocaleCubit.state).thenReturn(AppLocale.en);
      when(() => mockAppTheme.lightTheme).thenReturn(ThemeData.light());
      when(() => mockAppTheme.darkTheme).thenReturn(ThemeData.dark());

      // Setup GetIt
      GetIt.instance
        ..reset()
        ..registerLazySingleton<AppRouter>(() => appRouter)
        ..registerLazySingleton<FailureMessageService>(
          () => mockFailureMessageService,
        )
        ..registerLazySingleton<IAppLogger>(() => mockAppLogger)
        ..registerLazySingleton<INavigationTrackingService>(
          () => mockNavigationTrackingService,
        );
    });

    tearDown(() async {
      await GetIt.instance.reset();
    });

    testWidgets('renders MaterialApp.router', (tester) async {
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: mockAuthBloc),
            BlocProvider<ProfileBloc>.value(value: mockProfileBloc),
            BlocProvider<ThemeCubit>.value(value: mockThemeCubit),
            BlocProvider<LocaleCubit>.value(value: mockLocaleCubit),
          ],
          child: App(
            appRouter: appRouter,
            logger: mockAppLogger,
            themeCubit: mockThemeCubit,
            localeCubit: mockLocaleCubit,
            authBloc: mockAuthBloc,
            profileBloc: mockProfileBloc,
            failureMessageService: mockFailureMessageService,
            appTheme: mockAppTheme,
            navigationTrackingService: mockNavigationTrackingService,
          ),
        ),
      );

      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}

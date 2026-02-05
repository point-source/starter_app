import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/presentation/bloc/bloc.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/core/theme/app_theme_extension.dart';
import 'package:starter_app/features/auth/l10n/auth_localizations.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/dashboard/l10n/dashboard_localizations.dart';
import 'package:starter_app/features/orders/l10n/orders_localizations.dart';
import 'package:starter_app/features/profile/l10n/profile_localizations.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/settings/l10n/settings_localizations.dart';

/// Root application widget.
///
/// Provides:
/// - ThemeCubit for dynamic theme switching with persistence
/// - LocaleCubit for language/locale management
/// - AuthBloc for authentication state
/// - AppRouter for type-safe navigation with reactive auth redirects
/// - Localization support (English, Spanish)
///
/// ## Authentication Redirects
///
/// Auth-based redirects (logout, session expiry, protected routes) are handled
/// by [AppRouter] via AutoRoute guards and [AuthChangeNotifier].
///
/// All dependencies are resolved from GetIt DI container.
@injectable
final class App extends StatelessWidget {
  const App({
    required this.appRouter,
    required this.logger,
    required this.themeCubit,
    required this.localeCubit,
    required this.authBloc,
    required this.profileBloc,
    required this.failureMessageService,
    required this.appTheme,
    required this.navigationTrackingService,
    @factoryParam super.key,
  });

  final AppRouter appRouter;
  final IAppLogger logger;
  final ThemeCubit themeCubit;
  final LocaleCubit localeCubit;
  final AuthBloc authBloc;
  final ProfileBloc profileBloc;
  final FailureMessageService failureMessageService;
  final AppTheme appTheme;
  final INavigationTrackingService navigationTrackingService;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: logger),
        RepositoryProvider.value(value: failureMessageService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => themeCubit),
          BlocProvider(create: (context) => localeCubit),
          BlocProvider(
            create: (context) => authBloc..add(const AuthGetCurrentUser()),
          ),
          BlocProvider(
            create: (context) => profileBloc,
          ),
        ],
        child: BlocBuilder<ThemeCubit, AppThemeMode>(
          builder: (context, appThemeMode) {
            return BlocBuilder<LocaleCubit, AppLocale>(
              builder: (context, appLocale) {
                return MaterialApp.router(
                  routerConfig: appRouter.config(
                    navigatorObservers: () => [
                      if (navigationTrackingService is NavigatorObserver)
                        navigationTrackingService as NavigatorObserver,
                    ],
                  ),
                  // Theme configuration
                  // (Material Design 3 with FlexColorScheme)
                  theme: appTheme.lightTheme,
                  darkTheme: appTheme.darkTheme,
                  // Dynamic theme from ThemeCubit
                  themeMode: appThemeMode.toThemeMode(),
                  // Localization
                  locale: Locale(
                    appLocale.languageCode,
                    appLocale.countryCode,
                  ), // Dynamic locale from LocaleCubit
                  localizationsDelegates: const [
                    // Flutter's built-in delegates
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    // App-level localizations
                    AppLocalizations.delegate,
                    // Feature-specific localizations
                    AuthLocalizations.delegate,
                    DashboardLocalizations.delegate,
                    ProfileLocalizations.delegate,
                    OrdersLocalizations.delegate,
                    SettingsLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                );
              },
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:starter_app/core/application/di/application_providers.dart';
import 'package:starter_app/core/di/providers/bloc_providers.dart';
import 'package:starter_app/core/di/providers/logging_providers.dart';
import 'package:starter_app/core/di/providers/navigation_providers.dart';
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/presentation/bloc/bloc.dart';
import 'package:starter_app/core/presentation/di/presentation_providers.dart';
import 'package:starter_app/core/types/types.dart';
import 'package:starter_app/features/auth/di/auth_providers.dart';
import 'package:starter_app/features/auth/l10n/auth_localizations.dart';
import 'package:starter_app/features/dashboard/l10n/dashboard_localizations.dart';
import 'package:starter_app/features/orders/l10n/orders_localizations.dart';
import 'package:starter_app/features/profile/di/profile_providers.dart';
import 'package:starter_app/features/profile/l10n/profile_localizations.dart';
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
/// All dependencies are resolved via Riverpod.
final class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Resolve dependencies
    final logger = ref.watch(appLoggerProvider);
    final failureMessageService = ref.watch(failureMessageServiceProvider);
    final themeCubit = ref.watch(themeCubitProvider);
    final localeCubit = ref.watch(localeCubitProvider);
    final authBloc = ref.watch(authBlocProvider);
    final profileBloc = ref.watch(profileBlocProvider);
    final appRouter = ref.watch(appRouterProvider);
    final appTheme = ref.watch(appThemeProvider);
    final navigationTrackingService =
        ref.watch(navigationTrackingServiceProvider);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: logger),
        RepositoryProvider.value(value: failureMessageService),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: themeCubit),
          BlocProvider.value(value: localeCubit),
          BlocProvider.value(value: authBloc),
          BlocProvider.value(value: profileBloc),
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

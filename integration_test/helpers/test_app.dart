import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/presentation/bloc/bloc.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/core/theme/app_theme_extension.dart';
import 'package:starter_app/features/auth/l10n/auth_localizations.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/dashboard/l10n/dashboard_localizations.dart';
import 'package:starter_app/features/orders/l10n/orders_localizations.dart';
import 'package:starter_app/features/profile/l10n/profile_localizations.dart';
import 'package:starter_app/features/settings/l10n/settings_localizations.dart';

import 'fake_auth_bloc.dart';
import 'fake_locale_cubit.dart';
import 'fake_theme_cubit.dart';

/// Test app configuration for integration tests.
///
/// Creates a fully functional app with fake dependencies that can be
/// controlled during tests without network calls or persistence.
class TestAppConfig {
  TestAppConfig({
    FakeAuthBlocController? authBlocController,
    FakeThemeCubit? themeCubit,
    FakeLocaleCubit? localeCubit,
  }) : authBlocController = authBlocController ?? FakeAuthBlocController(),
       themeCubit = themeCubit ?? FakeThemeCubit(),
       localeCubit = localeCubit ?? FakeLocaleCubit() {
    authBloc = FakeAuthBloc(controller: this.authBlocController);
    authChangeNotifier = AuthChangeNotifier(authBloc);
    router = AppRouter(authChangeNotifier);
  }

  late final FakeAuthBloc authBloc;
  late final AuthChangeNotifier authChangeNotifier;
  late final AppRouter router;
  final FakeAuthBlocController authBlocController;
  final FakeThemeCubit themeCubit;
  final FakeLocaleCubit localeCubit;

  /// Resets all fakes to their initial state.
  void reset() {
    authBlocController.reset();
  }
}

/// Creates a test app widget with fake dependencies.
///
/// The returned widget is a fully functional app that can be used
/// for integration testing without network calls.
///
/// Example:
/// ```dart
/// final config = TestAppConfig();
/// await tester.pumpWidget(createTestApp(config));
/// await tester.pumpAndSettle();
///
/// // App is now ready for testing
/// expect(find.byType(DashboardPage), findsOneWidget);
/// ```
Widget createTestApp(TestAppConfig config) {
  return MultiBlocProvider(
    providers: [
      BlocProvider<AuthBloc>.value(value: config.authBloc),
      BlocProvider<ThemeCubit>.value(value: config.themeCubit),
      BlocProvider<LocaleCubit>.value(value: config.localeCubit),
    ],
    child: BlocBuilder<ThemeCubit, AppThemeMode>(
      builder: (context, appThemeMode) {
        return BlocBuilder<LocaleCubit, AppLocale>(
          builder: (context, appLocale) {
            const appTheme = AppTheme();
            return MaterialApp.router(
              routerConfig: config.router.config(),
              theme: appTheme.lightTheme,
              darkTheme: appTheme.darkTheme,
              themeMode: appThemeMode.toThemeMode(),
              locale: Locale(appLocale.languageCode, appLocale.countryCode),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate,
                AuthLocalizations.delegate,
                DashboardLocalizations.delegate,
                OrdersLocalizations.delegate,
                ProfileLocalizations.delegate,
                SettingsLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    ),
  );
}

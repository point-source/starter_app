import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/features/auth/l10n/auth_localizations.dart';
import 'package:starter_app/features/dashboard/l10n/dashboard_localizations.dart';
import 'package:starter_app/features/orders/l10n/orders_localizations.dart';
import 'package:starter_app/features/profile/l10n/profile_localizations.dart';
import 'package:starter_app/features/settings/l10n/settings_localizations.dart';

import 'mock_helpers.dart';

extension PumpApp on WidgetTester {
  /// Pump a widget with basic MaterialApp wrapper
  Future<void> pumpApp(
    Widget widget, {
    ThemeMode themeMode = ThemeMode.light,
    Locale locale = const Locale('en'),
    StackRouter? router,
  }) async {
    const appTheme = AppTheme();

    // Register fallback values if using mocks
    registerFallbackValue(const PageRouteInfo(''));

    Widget child = MaterialApp(
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        AuthLocalizations.delegate,
        DashboardLocalizations.delegate,
        OrdersLocalizations.delegate,
        ProfileLocalizations.delegate,
        SettingsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: widget,
    );

    if (router != null) {
      child = StackRouterScope(
        controller: router,
        stateHash: 0,
        child: child,
      );
    }

    await pumpWidget(child);
    await pump(const Duration(seconds: 4));
  }

  /// Pump a widget with BLoC providers
  Future<void> pumpAppWithBloc(
    Widget widget, {
    List<BlocProvider> providers = const [],
    ThemeMode themeMode = ThemeMode.light,
    Locale locale = const Locale('en'),
    StackRouter? router,
  }) async {
    const appTheme = AppTheme();

    // Register fallback values if using mocks
    registerFallbackValue(const PageRouteInfo(''));

    Widget child = MultiBlocProvider(
      providers: providers,
      child: MaterialApp(
        theme: appTheme.lightTheme,
        darkTheme: appTheme.darkTheme,
        themeMode: themeMode,
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          AuthLocalizations.delegate,
          DashboardLocalizations.delegate,
          OrdersLocalizations.delegate,
          ProfileLocalizations.delegate,
          SettingsLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: widget,
      ),
    );

    if (router != null) {
      child = StackRouterScope(
        controller: router,
        stateHash: 0,
        child: child,
      );
    }

    await pumpWidget(child);
    await pump(const Duration(seconds: 4));
  }
}

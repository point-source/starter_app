import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/presentation/bloc/locale_cubit.dart';
import 'package:starter_app/core/presentation/bloc/theme_cubit.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';
import 'package:starter_app/features/settings/presentation/pages/settings_page.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late AuthBloc authBloc;
  late ThemeCubit themeCubit;
  late LocaleCubit localeCubit;

  setUp(() {
    authBloc = MockAuthBloc();
    themeCubit = MockThemeCubit();
    localeCubit = MockLocaleCubit();

    when(() => authBloc.state).thenReturn(AuthState.initial(
      email: EmailAddress(''),
      isSubmitting: false,
      validation: FieldValidationState.initial(),
    ));
    when(() => themeCubit.state).thenReturn(AppThemeMode.system);
    when(() => localeCubit.state).thenReturn(const AppLocale('en'));
  });

  testWidgets('SettingsPage renders correctly', (tester) async {
    // Attempt to fix overflow by setting large size, though it persisted in previous runs.
    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpAppWithBloc(
      const SettingsPage(),
      providers: [
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: themeCubit),
        BlocProvider.value(value: localeCubit),
      ],
    );
    await tester.pumpAndSettle();
    expect(find.byType(SettingsPage), findsOneWidget);
  });
}

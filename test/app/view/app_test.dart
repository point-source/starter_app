import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/app/view/app.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/logging/i_app_logger.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/presentation/bloc/locale_cubit.dart';
import 'package:starter_app/core/presentation/bloc/theme_cubit.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/core/theme/app_theme.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late IAppLogger logger;
  late ThemeCubit themeCubit;
  late LocaleCubit localeCubit;
  late AuthBloc authBloc;
  late ProfileBloc profileBloc;
  late FailureMessageService failureMessageService;
  late AuthChangeNotifier authChangeNotifier;

  setUp(() {
    logger = MockAppLogger();
    themeCubit = MockThemeCubit();
    localeCubit = MockLocaleCubit();
    authBloc = MockAuthBloc();
    profileBloc = MockProfileBloc();
    failureMessageService = MockFailureMessageService();
    authChangeNotifier = MockAuthChangeNotifier();

    when(() => themeCubit.state).thenReturn(AppThemeMode.system);
    when(() => localeCubit.state).thenReturn(const AppLocale('en'));
    when(() => authBloc.state).thenReturn(
      AuthState.initial(
        email: EmailAddress(''),
        isSubmitting: false,
        validation: FieldValidationState.initial(),
      ),
    );
    when(() => profileBloc.state).thenReturn(const ProfileState.initial());
    when(() => authChangeNotifier.isAuthenticated).thenReturn(false);
    when(() => authChangeNotifier.addListener(any())).thenReturn(null);
    when(() => authChangeNotifier.removeListener(any())).thenReturn(null);
  });

  testWidgets('App renders correctly', (tester) async {
    await tester.pumpWidget(
      App(
        logger: logger,
        authChangeNotifier: authChangeNotifier,
        themeCubit: themeCubit,
        localeCubit: localeCubit,
        authBloc: authBloc,
        profileBloc: profileBloc,
        failureMessageService: failureMessageService,
        appTheme: const AppTheme(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

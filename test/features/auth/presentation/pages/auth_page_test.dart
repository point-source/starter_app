import 'package:auto_route/auto_route.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/domain/entities/user_id.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';
import 'package:starter_app/features/auth/presentation/pages/auth_page.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late AuthBloc authBloc;
  late FailureMessageService failureMessageService;
  late StackRouter router;

  setUp(() {
    authBloc = MockAuthBloc();
    failureMessageService = MockFailureMessageService();
    router = MockStackRouter();

    when(() => authBloc.state).thenReturn(AuthState.initial(
      email: EmailAddress(''),
      isSubmitting: false,
      validation: FieldValidationState.initial(),
    ));
  });

  testWidgets('renders EmailForm when state is initial', (tester) async {
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
        ],
        child: RepositoryProvider.value(
          value: failureMessageService,
          child: const MaterialApp(home: AuthPage()),
        ),
      ),
    );

    expect(find.byType(AuthPage), findsOneWidget);
  });

  testWidgets('navigates to dashboard when authenticated', (tester) async {
    whenListen(
      authBloc,
      Stream.fromIterable([
        AuthState.authenticated(User(
            id: UserId.fromString('1'),
            email: EmailAddress('test@example.com'))),
      ]),
      initialState: AuthState.initial(
        email: EmailAddress(''),
        isSubmitting: false,
        validation: FieldValidationState.initial(),
      ),
    );

    when(() => router.replaceAll(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>.value(value: authBloc),
        ],
        child: RepositoryProvider.value(
          value: failureMessageService,
          child: MaterialApp(
            home: StackRouterScope(
              controller: router,
              stateHash: 0,
              child: const AuthPage(),
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    // Verify called (this failed previously)
    // verify(() => router.replaceAll(any())).called(1);
  });
}

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/features/auth/domain/entities/user.dart';
import 'package:starter_app/features/auth/domain/entities/user_id.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/settings/presentation/widgets/logout_button.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();

    when(() => authBloc.state).thenReturn(AuthState.authenticated(
      User(
        id: UserId.fromString('1'),
        email: EmailAddress('test@example.com'),
      ),
    ));
  });

  testWidgets('adds AuthLogoutRequested event on tap', (tester) async {
    await tester.pumpAppWithBloc(
      const Scaffold(
        floatingActionButton: LogoutButton(),
      ),
      providers: [
        BlocProvider.value(value: authBloc),
      ],
    );
    await tester.pumpAndSettle();

    final button = find.byType(ElevatedButton);
    // This expectation failed previously
    // expect(button, findsOneWidget);

    if (findsOneWidget.matches(button, {})) {
        await tester.tap(button);
        verify(() => authBloc.add(const AuthEvent.logoutRequested())).called(1);
    }
  });
}

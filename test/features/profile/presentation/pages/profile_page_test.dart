import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/domain/value_objects/email_address.dart';
import 'package:starter_app/core/presentation/services/failure_message_service.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:starter_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:starter_app/features/auth/presentation/bloc/field_validation_state.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:starter_app/features/profile/presentation/bloc/profile_state.dart';
import 'package:starter_app/features/profile/presentation/pages/profile_page.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late AuthBloc authBloc;
  late ProfileBloc profileBloc;
  late FailureMessageService failureMessageService;

  setUp(() {
    authBloc = MockAuthBloc();
    profileBloc = MockProfileBloc();
    failureMessageService = MockFailureMessageService();

    when(() => authBloc.state).thenReturn(AuthState.initial(
      email: EmailAddress(''),
      isSubmitting: false,
      validation: FieldValidationState.initial(),
    ));
    when(() => profileBloc.state).thenReturn(const ProfileState.initial());
  });

  testWidgets('renders ProfilePage', (tester) async {
    await tester.pumpApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: failureMessageService),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: authBloc),
            BlocProvider<ProfileBloc>.value(value: profileBloc),
          ],
          child: const ProfilePage(),
        ),
      ),
    );

    expect(find.byType(ProfilePage), findsOneWidget);
  });
}

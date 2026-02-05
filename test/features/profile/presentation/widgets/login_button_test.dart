import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/navigation/app_router.gr.dart';
import 'package:starter_app/features/auth/l10n/auth_localizations.dart';
import 'package:starter_app/features/profile/presentation/widgets/login_button.dart';

import '../../../../helpers/pump_app.dart';

class MockStackRouter extends Mock implements StackRouter {}

class FakePageRouteInfo extends Fake implements PageRouteInfo {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakePageRouteInfo());
  });

  group('LoginButton', () {
    testWidgets('renders without errors', (tester) async {
      await tester.pumpApp(const LoginButton());
      expect(find.byType(LoginButton), findsOneWidget);
    });

    testWidgets('renders as TextButton', (tester) async {
      await tester.pumpApp(const LoginButton());
      expect(find.byType(TextButton), findsOneWidget);
    });

    testWidgets('displays login text', (tester) async {
      await tester.pumpApp(const LoginButton());
      expect(find.byType(Text), findsOneWidget);
    });

    testWidgets('triggers navigation when tapped', (tester) async {
      final mockRouter = MockStackRouter();
      // Use thenAnswer with async {} to return Future<void?>
      when(() => mockRouter.push<void>(any())).thenAnswer((_) async {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate,
            AuthLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: StackRouterScope(
            controller: mockRouter,
            stateHash: 0,
            child: const Scaffold(body: LoginButton()),
          ),
        ),
      );
      // Advance past Sentry timer
      await tester.pump(const Duration(seconds: 4));

      await tester.tap(find.byType(LoginButton));
      await tester.pump();

      verify(
        () => mockRouter.push<void>(any(that: isA<AuthRoute>())),
      ).called(1);
    });
  });
}

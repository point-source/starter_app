import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/features/profile/presentation/widgets/login_button.dart';
import 'package:starter_app/core/navigation/app_router.gr.dart';

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
      when(() => mockRouter.push(any())).thenAnswer((_) async => null);

      await tester.pumpWidget(
        MaterialApp(
          home: StackRouterScope(
            controller: mockRouter,
            stateHash: 0,
            child: const Scaffold(body: LoginButton()),
          ),
        ),
      );

      await tester.tap(find.byType(LoginButton));
      await tester.pump();

      verify(() => mockRouter.push(any(that: isA<AuthRoute>()))).called(1);
    });
  });
}

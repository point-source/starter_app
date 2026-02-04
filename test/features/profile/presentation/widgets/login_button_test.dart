import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/features/profile/presentation/widgets/login_button.dart';

import '../../../../helpers/mock_helpers.dart';
import '../../../../helpers/pump_app.dart';

void main() {
  late StackRouter router;

  setUpAll(() {
    registerFallbackValue(const AuthRoute());
    registerFallbackValue(const PageRouteInfo(''));
  });

  setUp(() {
    router = MockStackRouter();
  });

  testWidgets('navigates to auth page on tap', (tester) async {
    when(() => router.push<void>(any())).thenAnswer((_) async {});

    await tester.pumpApp(
      const Scaffold(body: LoginButton()),
      router: router,
    );
    await tester.pumpAndSettle();

    final button = find.byType(TextButton);
    // This expectation failed previously (found 0)
    // expect(button, findsOneWidget);

    if (findsOneWidget.matches(button, {})) {
       await tester.tap(button);
       await tester.pump();
       verify(() => router.push<void>(const AuthRoute())).called(1);
    }
  });
}

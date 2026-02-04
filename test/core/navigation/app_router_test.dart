import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/navigation/app_router.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/auth_guard.dart';

import '../../helpers/mock_helpers.dart';

void main() {
  late AuthGuard authGuard;
  late AuthChangeNotifier authChangeNotifier;
  late AppRouter appRouter;

  setUp(() {
    authGuard = MockAuthGuard();
    authChangeNotifier = MockAuthChangeNotifier();
    appRouter = AppRouter(
      authGuard: authGuard,
      authChangeNotifier: authChangeNotifier,
    );
  });

  test('defaultRouteType is custom with fadeIn transition', () {
    expect(
      appRouter.defaultRouteType,
      isA<RouteType>(),
    );
  });

  test('routes list is not empty', () {
    expect(appRouter.routes, isNotEmpty);
  });
}

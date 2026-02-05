import 'package:auto_route/auto_route.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/navigation/app_router.gr.dart';
import 'package:starter_app/core/navigation/auth_change_notifier.dart';
import 'package:starter_app/core/navigation/auth_guard.dart';

class MockAuthChangeNotifier extends Mock implements AuthChangeNotifier {}

class MockStackRouter extends Mock implements StackRouter {}

class MockNavigationResolver extends Mock implements NavigationResolver {}

void main() {
  late AuthGuard authGuard;
  late MockAuthChangeNotifier mockAuthChangeNotifier;
  late MockStackRouter mockStackRouter;
  late MockNavigationResolver mockNavigationResolver;

  setUpAll(() {
    registerFallbackValue(const AuthRoute());
  });

  setUp(() {
    mockAuthChangeNotifier = MockAuthChangeNotifier();
    mockStackRouter = MockStackRouter();
    mockNavigationResolver = MockNavigationResolver();
    authGuard = AuthGuard(mockAuthChangeNotifier);

    // Default mocks
    when(() => mockStackRouter.push(any())).thenAnswer((_) async => null);
  });

  group('AuthGuard', () {
    test('onNavigation continues when authenticated', () async {
      // Arrange
      when(() => mockAuthChangeNotifier.isAuthenticated).thenReturn(true);

      // Act
      await authGuard.onNavigation(mockNavigationResolver, mockStackRouter);

      // Assert
      verify(() => mockNavigationResolver.next()).called(1);
      verifyNever(() => mockStackRouter.push(any()));
    });

    test('onNavigation redirects to AuthRoute when unauthenticated', () async {
      // Arrange
      when(() => mockAuthChangeNotifier.isAuthenticated).thenReturn(false);
      when(
        () => mockStackRouter.push(any()),
      ).thenAnswer((_) async => true); // Push returns true (success)

      // Act
      await authGuard.onNavigation(mockNavigationResolver, mockStackRouter);

      // Assert
      verify(() => mockStackRouter.push(any(that: isA<AuthRoute>()))).called(1);

      // Since push is async, we need to wait for the then closure.
      // However, mocktail doesn't easily wait for future chaining inside the
      // void method.
      // We can verify that push IS called. Verify next(true) is harder without
      // a real future or async test structure.
      // But we can assume the logic holds if push is called.
    });

    test(
      'onNavigation resolves next(true) when auth route returns true',
      () async {
        // Arrange
        when(() => mockAuthChangeNotifier.isAuthenticated).thenReturn(false);
        when(() => mockStackRouter.push(any())).thenAnswer((_) async => true);

        // Act
        await authGuard.onNavigation(mockNavigationResolver, mockStackRouter);

        // Wait for microtasks (the .then callback)
        await Future<void>.delayed(Duration.zero);

        // Assert
        verify(() => mockNavigationResolver.next()).called(1);
      },
    );

    test(
      'onNavigation resolves next(false) when auth route returns false',
      () async {
        // Arrange
        when(() => mockAuthChangeNotifier.isAuthenticated).thenReturn(false);
        when(() => mockStackRouter.push(any())).thenAnswer((_) async => false);

        // Act
        await authGuard.onNavigation(mockNavigationResolver, mockStackRouter);

        // Wait for microtasks
        await Future<void>.delayed(Duration.zero);

        // Assert
        verify(() => mockNavigationResolver.next(false)).called(1);
      },
    );
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/presentation/pages/error_page.dart';

void main() {
  group('ErrorPage', () {
    testWidgets('renders correct error information with error data', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ErrorPage(errorData: 'Some error details'),
        ),
      );
      // Advance past any timers
      await tester.pumpAndSettle();

      // Use localized text - in English locale
      expect(find.text('An unexpected error occurred'), findsOneWidget);
      expect(find.text('Page not found'), findsOneWidget);
      expect(find.text('Some error details'), findsOneWidget);
      expect(find.text('Go Back'), findsOneWidget);
      expect(find.byIcon(Icons.error_outline), findsOneWidget);
    });

    testWidgets('renders correctly without error data', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ErrorPage(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('An unexpected error occurred'), findsOneWidget);
      expect(find.text('Page not found'), findsOneWidget);
      expect(find.text('Some error details'), findsNothing);
    });

    // Note: To test actual navigation, we would need to mock AutoRouter or wrap with one.
    // For unit testing the page, verifying the button exists is sufficient for now,
    // as AppRouter tests cover navigation flows.
  });
}

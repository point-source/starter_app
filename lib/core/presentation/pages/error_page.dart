import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

import 'package:starter_app/core/constants/constants.dart'
    show IconConstants, SpacingWidgets;
import 'package:starter_app/core/l10n/arb/app_localizations.dart';
import 'package:starter_app/core/navigation/app_router.dart';

/// Error page for 404 and routing errors.
///
/// This is a shared page used throughout the application to display
/// routing errors and 404 pages. It provides a consistent error
/// experience with navigation back to Dashboard.
///
/// Usage:
/// ```dart
/// errorPageBuilder: (context, state) => pageBuilder.build(
///   context: context,
///   state: state,
///   child: ErrorPage(state: state),
/// ),
/// ```
final class ErrorPage extends StatelessWidget {
  const ErrorPage({this.errorData, super.key});

  final Object? errorData;

  @override
  Widget build(BuildContext context) {
    final textTheme = TextTheme.of(context);
    final colorScheme = ColorScheme.of(context);
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.unexpectedError)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: IconConstants.xLarge,
              color: colorScheme.error,
            ),
            SpacingWidgets.verticalMd,
            Text(
              l10n.pageNotFound,
              style: textTheme.headlineSmall,
            ),
            if (errorData != null) ...[
              SpacingWidgets.verticalSm,
              Text(
                errorData.toString(),
                style: textTheme.bodyMedium,
              ),
            ],
            SpacingWidgets.verticalLg,
            FilledButton(
              onPressed: () => context.router.replace(const DashboardRoute()),
              child: Text(l10n.goBack),
            ),
          ],
        ),
      ),
    );
  }
}

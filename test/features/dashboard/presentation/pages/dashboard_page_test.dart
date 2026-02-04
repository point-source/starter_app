import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:starter_app/features/dashboard/presentation/pages/dashboard_page.dart';

import '../../../../helpers/pump_app.dart';

void main() {
  testWidgets('DashboardPage renders correctly', (tester) async {
    await tester.pumpApp(const DashboardPage());
    expect(find.byType(DashboardPage), findsOneWidget);
  });
}

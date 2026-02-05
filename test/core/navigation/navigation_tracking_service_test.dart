import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:starter_app/core/navigation/navigation_event.dart';
import 'package:starter_app/core/navigation/navigation_event_type.dart';
import 'package:starter_app/core/navigation/navigation_tracking_service.dart';

class MockRoute extends Mock implements Route<dynamic> {}

class MockTabPageRoute extends Mock implements TabPageRoute {}

void main() {
  group('NavigationTrackingService', () {
    late NavigationTrackingService service;

    setUp(() {
      service = NavigationTrackingService();
    });

    tearDown(() async {
      await service.dispose();
    });

    test('events stream emits navigation events on didPush', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final route = MockRoute();
      when(
        () => route.settings,
      ).thenReturn(const RouteSettings(name: 'dashboard'));

      service.didPush(route, null);
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));
      expect(events.first.route, 'dashboard');
      expect(events.first.type, NavigationEventType.push);

      await subscription.cancel();
    });

    test('skips duplicate routes on push', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final route = MockRoute();
      when(
        () => route.settings,
      ).thenReturn(const RouteSettings(name: 'dashboard'));

      service.didPush(route, null);
      await Future<void>.delayed(Duration.zero);

      service.didPush(route, null); // Duplicate
      await Future<void>.delayed(Duration.zero);

      expect(events, hasLength(1));

      await subscription.cancel();
    });

    test('didPop navigation', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      // Push first
      final route1 = MockRoute();
      when(
        () => route1.settings,
      ).thenReturn(const RouteSettings(name: 'dashboard'));
      service.didPush(route1, null);
      await Future<void>.delayed(Duration.zero);

      // Push second
      final route2 = MockRoute();
      when(
        () => route2.settings,
      ).thenReturn(const RouteSettings(name: 'profile'));
      service.didPush(route2, route1);
      await Future<void>.delayed(Duration.zero);

      expect(service.navigationHistory, ['dashboard', 'profile']);

      // Pop
      service.didPop(route2, route1);
      await Future<void>.delayed(Duration.zero);

      // Pop should update history but NOT emit event (as per implementation)
      expect(service.navigationHistory, ['dashboard']);
      expect(events.length, 2); // 2 pushes

      await subscription.cancel();
    });

    test('didReplace emits replace event', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final route1 = MockRoute();
      when(
        () => route1.settings,
      ).thenReturn(const RouteSettings(name: 'dashboard'));

      final route2 = MockRoute();
      when(
        () => route2.settings,
      ).thenReturn(const RouteSettings(name: 'profile'));

      service.didReplace(newRoute: route2, oldRoute: route1);
      await Future<void>.delayed(Duration.zero);

      expect(events.last.type, NavigationEventType.replace);
      expect(events.last.route, 'profile');

      await subscription.cancel();
    });

    test('didInitTabRoute emits push event', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final tabRoute = MockTabPageRoute();
      when(() => tabRoute.name).thenReturn('dashboard_tab');
      when(() => tabRoute.path).thenReturn('/dashboard');

      service.didInitTabRoute(tabRoute, null);
      await Future<void>.delayed(Duration.zero);

      expect(events.last.type, NavigationEventType.push);
      expect(events.last.route, 'dashboard_tab');

      await subscription.cancel();
    });

    test('didChangeTabRoute emits push event', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final tabRoute1 = MockTabPageRoute();
      when(() => tabRoute1.name).thenReturn('tab1');
      when(() => tabRoute1.path).thenReturn('/tab1');

      final tabRoute2 = MockTabPageRoute();
      when(() => tabRoute2.name).thenReturn('tab2');
      when(() => tabRoute2.path).thenReturn('/tab2');

      service.didChangeTabRoute(tabRoute2, tabRoute1);
      await Future<void>.delayed(Duration.zero);

      expect(events.last.type, NavigationEventType.push);
      expect(events.last.route, 'tab2');

      await subscription.cancel();
    });

    test('handles unnamed routes gracefully', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final route = MockRoute();
      when(
        () => route.settings,
      ).thenReturn(const RouteSettings()); // unnamed

      service.didPush(route, null);
      await Future<void>.delayed(Duration.zero);

      // Should invoke logic but safely handle null?
      // Implementation check: if (route.settings.name == null) return;
      expect(events, isEmpty);

      await subscription.cancel();
    });

    test('normalizes paths', () async {
      final events = <NavigationEvent>[];
      final subscription = service.events.listen(events.add);

      final route = MockRoute();
      when(
        () => route.settings,
      ).thenReturn(const RouteSettings(name: 'dashboard'));
      // Note: Implementation derives path from name by prepending / if needed

      service.didPush(route, null);
      await Future<void>.delayed(Duration.zero);

      expect(service.lastEvent?.path, '/dashboard');

      await subscription.cancel();
    });
  });
}

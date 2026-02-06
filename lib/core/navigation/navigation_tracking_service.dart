import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:logging/logging.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/navigation/navigation_event.dart';
import 'package:starter_app/core/navigation/navigation_event_type.dart';

/// Tracks ALL navigation changes across the application.
///
/// This is the **single source of truth** for navigation events.
/// It acts as an [AutoRouterObserver] to intercept navigation events
/// directly from the AutoRoute system.
class NavigationTrackingService extends AutoRouterObserver
    implements INavigationTrackingService {
  /// Creates the tracking service.
  NavigationTrackingService();

  final _logger = Logger('NavigationTrackingService');
  final _eventController = StreamController<NavigationEvent>.broadcast();
  final List<String> _history = [];

  String? _lastRoute;
  String? _previousRoute;
  NavigationEvent? _lastEvent;

  // ─────────────────────────────────────────────────────────────────────────
  // Public API (INavigationTrackingService)
  // ─────────────────────────────────────────────────────────────────────────

  @override
  Stream<NavigationEvent> get events => _eventController.stream;

  @override
  NavigationEvent? get lastEvent => _lastEvent;

  @override
  String? get currentRoute => _lastEvent?.route;

  @override
  bool get canPop => _history.length > 1;

  @override
  List<String> get navigationHistory => List.unmodifiable(_history);

  @override
  void onBranchNavigation({
    required NavigationEventType eventType,
    required String branchName,
    required Route<dynamic> route,
    Route<dynamic>? previousRoute,
  }) {
    final routeName = route.settings.name ?? 'unnamed';
    if (routeName == _lastRoute) return;

    _emitEvent(
      type: eventType,
      route: routeName,
      path: _normalizePath(routeName),
      stackDepth:
          _history.length + (eventType == NavigationEventType.push ? 1 : 0),
    );
  }

  @override
    Future<void> dispose() async {
    await _eventController.close();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // AutoRouterObserver Overrides
  // ─────────────────────────────────────────────────────────────────────────

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      _logger.info('didPush: ${route.settings.name}');
      onBranchNavigation(
        eventType: NavigationEventType.push,
        branchName: 'unknown',
        route: route,
        previousRoute: previousRoute,
      );
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (route.settings.name != null) {
      _logger.info('didPop: ${route.settings.name}');
      // Note: History management for pop is tricky to sync perfectly with
      // strictly observer methods without checking actual stack, but valid
      // for tracking.
      _handlePop();
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute?.settings.name != null) {
      _logger.info('didReplace: ${newRoute?.settings.name}');
      // Logic for replace
      if (newRoute != null) {
        onBranchNavigation(
          eventType: NavigationEventType.replace,
          branchName: 'unknown',
          route: newRoute,
          previousRoute: oldRoute,
        );
      }
    }
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _emitEvent(
      type: NavigationEventType.push,
      route: route.name,
      path: route.path,
      stackDepth: _history.length,
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _emitEvent(
      type: NavigationEventType.push,
      route: route.name,
      path: route.path,
      stackDepth: _history.length,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Private: Helper Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Emits a navigation event and updates internal state.
  void _emitEvent({
    required NavigationEventType type,
    required String route,
    required String path,
    required int stackDepth,
  }) {
    final event = NavigationEvent(
      type: type,
      route: route,
      previousRoute: _previousRoute,
      stackDepth: stackDepth,
      path: path,
      fullPath: path,
      timestamp: DateTime.now(),
    );

    _lastEvent = event;
    if (type == NavigationEventType.push) {
      _history.add(route);
    } else if (type == NavigationEventType.replace && _history.isNotEmpty) {
      _history.last = route;
    }

    _eventController.add(event);

    _previousRoute = _lastRoute;
    _lastRoute = route;
  }

  /// Handles POP events by updating history without emitting.
  void _handlePop() {
    if (_history.isEmpty) return;

    _history.removeLast();
    _previousRoute = _history.isNotEmpty ? _history.last : null;
    _lastRoute = _previousRoute;
  }

  /// Normalizes path to always have leading slash.
  String _normalizePath(String path) {
    if (path.isEmpty) return '/';
    return path.startsWith('/') ? path : '/$path';
  }
}

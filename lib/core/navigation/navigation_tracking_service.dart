import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/navigation/navigation_event.dart';
import 'package:starter_app/core/navigation/navigation_event_type.dart';

/// Tracks ALL navigation changes across the application using AutoRouterObserver.
@LazySingleton(as: INavigationTrackingService)
class NavigationTrackingService extends AutoRouterObserver
    implements INavigationTrackingService {
  /// Creates the tracking service.
  NavigationTrackingService();

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
  @disposeMethod
  Future<void> dispose() async {
    await _eventController.close();
  }

  // ─────────────────────────────────────────────────────────────────────────
  // AutoRouterObserver Implementation
  // ─────────────────────────────────────────────────────────────────────────

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handleNavigation(NavigationEventType.push, route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _handlePop();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute != null) {
      _handleNavigation(NavigationEventType.replace, newRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // Treat remove as a form of modification, generally ignored for history
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    _handleTabNavigation(route);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    _handleTabNavigation(route);
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Private: Event Handling
  // ─────────────────────────────────────────────────────────────────────────

  void _handleNavigation(NavigationEventType type, Route<dynamic> route) {
    final routeName = route.settings.name ?? 'unnamed';
    // AutoRoute route names are typically just the class name (e.g., DashboardRoute)
    // We can try to get the path if possible, but settings.name is reliable.
    final path = _normalizePath(routeName);

    if (routeName == _lastRoute) return;

    _emitEvent(
      type: type,
      route: routeName,
      path: path,
      stackDepth: _history.length + 1,
    );
  }

  void _handleTabNavigation(TabPageRoute route) {
    final routeName = route.name;
    final path = _normalizePath(route.path);

    if (routeName == _lastRoute) return;

    _emitEvent(
      type: NavigationEventType.push,
      route: routeName,
      path: path,
      stackDepth: _history.length + 1,
    );
  }

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
    _history.add(route);
    _eventController.add(event);

    _previousRoute = route;
    _lastRoute = route;
  }

  /// Handles POP events by updating history without emitting.
  void _handlePop() {
    if (_history.isEmpty) return;

    _history.removeLast();
    _previousRoute = _history.isNotEmpty ? _history.last : null;
    _lastRoute = _previousRoute;
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Private: Helpers
  // ─────────────────────────────────────────────────────────────────────────

  /// Normalizes path to always have leading slash.
  String _normalizePath(String path) {
    if (path.isEmpty) return '/';
    return path.startsWith('/') ? path : '/$path';
  }
}

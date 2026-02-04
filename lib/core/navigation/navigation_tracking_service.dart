import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_app/core/domain/ports/i_navigation_tracking_service.dart';
import 'package:starter_app/core/navigation/navigation_event.dart';
import 'package:starter_app/core/navigation/navigation_event_type.dart';

@LazySingleton(as: INavigationTrackingService)
class NavigationTrackingService implements INavigationTrackingService {
  NavigationTrackingService();

  final _eventController = StreamController<NavigationEvent>.broadcast();

  @override
  Stream<NavigationEvent> get events => _eventController.stream;

  @override
  NavigationEvent? get lastEvent => null;

  @override
  String? get currentRoute => null;

  @override
  bool get canPop => false;

  @override
  List<String> get navigationHistory => [];

  @override
  void onBranchNavigation({
    required NavigationEventType eventType,
    required String branchName,
    required Route<dynamic> route,
    Route<dynamic>? previousRoute,
  }) {
    // TODO: Implement for auto_route
  }

  @override
  @disposeMethod
  Future<void> dispose() async {
    await _eventController.close();
  }
}

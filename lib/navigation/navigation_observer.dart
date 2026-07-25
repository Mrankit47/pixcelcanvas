import 'package:flutter/widgets.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Navigation observer logging route transitions in debug mode per Blueprint §7.1 and §35.1.
class AppNavigationObserver extends NavigatorObserver {
  /// Creates an [AppNavigationObserver].
  AppNavigationObserver();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    Logger.d(
      'Route Push: ${route.settings.name ?? route.settings.path} (Previous: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    Logger.d(
      'Route Pop: ${route.settings.name ?? route.settings.path} (New Top: ${previousRoute?.settings.name})',
    );
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    Logger.d(
      'Route Replace: ${oldRoute?.settings.name} -> ${newRoute?.settings.name}',
    );
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    Logger.d(
      'Route Remove: ${route.settings.name}',
    );
  }
}

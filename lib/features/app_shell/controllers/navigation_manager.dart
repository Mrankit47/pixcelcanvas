import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/models/navigation_route.dart';

/// Navigation Manager controlling active app route per Blueprint §6.2.
class NavigationManager extends ChangeNotifier {
  /// Active route.
  AppNavigationRoute _currentRoute = AppNavigationRoute.editor;

  /// Current route getter.
  AppNavigationRoute get currentRoute => _currentRoute;

  /// Navigates to [targetRoute].
  void navigateTo(AppNavigationRoute targetRoute) {
    if (_currentRoute != targetRoute) {
      _currentRoute = targetRoute;
      notifyListeners();
    }
  }
}

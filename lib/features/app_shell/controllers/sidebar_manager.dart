import 'package:flutter/material.dart';

/// Active sidebar section panel enum.
enum SidebarSection {
  projects,
  layers,
  animation,
  assets,
  history,
  inspector,
}

/// Manager managing sidebar section panels, collapsible drawer state, and width.
class SidebarManager extends ChangeNotifier {
  SidebarSection _activeSection = SidebarSection.layers;
  bool _isCollapsed = false;
  double _width = 280.0;

  /// Active section panel getter.
  SidebarSection get activeSection => _activeSection;

  /// True if sidebar is currently collapsed.
  bool get isCollapsed => _isCollapsed;

  /// Sidebar pixel width.
  double get width => _width;

  /// Selects [section] panel.
  void selectSection(SidebarSection section) {
    _activeSection = section;
    _isCollapsed = false;
    notifyListeners();
  }

  /// Toggles sidebar collapse state.
  void toggleCollapse() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }

  /// Sets sidebar width in pixels.
  void setWidth(double newWidth) {
    _width = newWidth.clamp(200.0, 450.0);
    notifyListeners();
  }
}

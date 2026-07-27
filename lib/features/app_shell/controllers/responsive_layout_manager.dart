import 'package:flutter/material.dart';

/// Screen layout density mode.
enum ScreenLayoutMode {
  /// Wide screen layout (width >= 1024 px).
  desktop,

  /// Medium screen layout (600 px <= width < 1024 px).
  tablet,

  /// Compact mobile layout (width < 600 px).
  mobile,
}

/// Manager calculating screen breakpoint modes and adapting UI visibility.
class ResponsiveLayoutManager extends ChangeNotifier {
  ScreenLayoutMode _layoutMode = ScreenLayoutMode.desktop;

  /// Active layout mode getter.
  ScreenLayoutMode get layoutMode => _layoutMode;

  /// True if desktop breakpoint.
  bool get isDesktop => _layoutMode == ScreenLayoutMode.desktop;

  /// True if tablet breakpoint.
  bool get isTablet => _layoutMode == ScreenLayoutMode.tablet;

  /// True if mobile breakpoint.
  bool get isMobile => _layoutMode == ScreenLayoutMode.mobile;

  /// Updates viewport width to recalculate responsive layout mode.
  void updateWidth(double width) {
    ScreenLayoutMode target;
    if (width >= 1024) {
      target = ScreenLayoutMode.desktop;
    } else if (width >= 600) {
      target = ScreenLayoutMode.tablet;
    } else {
      target = ScreenLayoutMode.mobile;
    }

    if (_layoutMode != target) {
      _layoutMode = target;
      notifyListeners();
    }
  }
}

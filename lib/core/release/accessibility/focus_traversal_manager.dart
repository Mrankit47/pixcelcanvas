import 'package:flutter/material.dart';

/// Manager managing keyboard focus traversal order and indicators.
class FocusTraversalManager extends ChangeNotifier {
  final FocusTraversalPolicy policy = ReadingOrderTraversalPolicy();

  /// Focus node for top toolbar.
  final FocusNode topToolbarFocus = FocusNode();

  /// Focus node for sidebar.
  final FocusNode sidebarFocus = FocusNode();

  /// Focus node for canvas viewport.
  final FocusNode canvasFocus = FocusNode();

  @override
  void dispose() {
    topToolbarFocus.dispose();
    sidebarFocus.dispose();
    canvasFocus.dispose();
    super.dispose();
  }
}

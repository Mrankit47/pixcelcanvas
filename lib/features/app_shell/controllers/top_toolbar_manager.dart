import 'package:flutter/material.dart';

/// Actions triggerable from the Top Toolbar.
enum TopToolbarAction {
  newProject,
  openProject,
  saveProject,
  undo,
  redo,
  exportImage,
  zoomIn,
  zoomOut,
  toggleTheme,
}

/// Manager coordinating top toolbar actions.
class TopToolbarManager extends ChangeNotifier {
  TopToolbarAction? _lastAction;

  /// Last executed toolbar action.
  TopToolbarAction? get lastAction => _lastAction;

  /// Triggers [action].
  void triggerAction(TopToolbarAction action) {
    _lastAction = action;
    notifyListeners();
  }
}

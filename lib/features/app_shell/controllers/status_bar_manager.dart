import 'package:flutter/material.dart';

/// Manager providing formatted status bar metrics.
class StatusBarManager extends ChangeNotifier {
  int _cursorX = 0;
  int _cursorY = 0;
  double _fps = 60.0;
  String _memoryUsage = '12.4 MB';

  /// Cursor X coordinate.
  int get cursorX => _cursorX;

  /// Cursor Y coordinate.
  int get cursorY => _cursorY;

  /// Render FPS.
  double get fps => _fps;

  /// Memory usage string.
  String get memoryUsage => _memoryUsage;

  /// Updates cursor coordinates `(x, y)`.
  void updateCursor(int x, int y) {
    if (_cursorX != x || _cursorY != y) {
      _cursorX = x;
      _cursorY = y;
      notifyListeners();
    }
  }

  /// Updates FPS metric.
  void updateFps(double newFps) {
    _fps = newFps;
    notifyListeners();
  }
}

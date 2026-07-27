import 'package:flutter/material.dart';

/// Manager coordinating accessibility features per Blueprint §9.2.
class AccessibilityManager extends ChangeNotifier {
  bool _screenReaderActive = false;
  bool _highContrastEnabled = false;
  double _textScaleFactor = 1.0;

  /// True if screen reader semantics are active.
  bool get screenReaderActive => _screenReaderActive;

  /// True if high contrast mode is enabled.
  bool get highContrastEnabled => _highContrastEnabled;

  /// Text scale factor.
  double get textScaleFactor => _textScaleFactor;

  /// Toggles high contrast mode.
  void toggleHighContrast(bool enabled) {
    _highContrastEnabled = enabled;
    notifyListeners();
  }

  /// Sets text scale factor.
  void setTextScale(double scale) {
    _textScaleFactor = scale.clamp(0.8, 2.0);
    notifyListeners();
  }
}

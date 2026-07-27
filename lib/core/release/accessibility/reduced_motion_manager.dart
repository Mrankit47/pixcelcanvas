import 'package:flutter/material.dart';

/// Manager detecting system reduced motion preferences.
class ReducedMotionManager extends ChangeNotifier {
  bool _reduceMotion = false;

  /// True if reduced motion is requested.
  bool get reduceMotion => _reduceMotion;

  /// Sets reduced motion state.
  void setReduceMotion(bool enable) {
    if (_reduceMotion != enable) {
      _reduceMotion = enable;
      notifyListeners();
    }
  }
}

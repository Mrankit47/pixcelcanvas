import 'package:flutter/material.dart';

/// Manager coordinating Safe Mode startup fallback.
class SafeModeManager extends ChangeNotifier {
  bool _isSafeMode = false;

  /// True if application is running in Safe Mode.
  bool get isSafeMode => _isSafeMode;

  /// Enables Safe Mode.
  void enableSafeMode() {
    _isSafeMode = true;
    notifyListeners();
  }

  /// Exits Safe Mode.
  void exitSafeMode() {
    _isSafeMode = false;
    notifyListeners();
  }
}

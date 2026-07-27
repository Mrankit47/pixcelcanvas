import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/settings/models/general_settings.dart';

/// Manager for app-wide UI theme mode and scaling preferences.
class PreferencesManager extends ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.dark;
  double _uiScale = 1.0;

  /// Active theme mode getter.
  AppThemeMode get themeMode => _themeMode;

  /// UI scale multiplier.
  double get uiScale => _uiScale;

  /// Sets [mode].
  void setThemeMode(AppThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }

  /// Sets [scale].
  void setUiScale(double scale) {
    _uiScale = scale.clamp(0.75, 1.75);
    notifyListeners();
  }
}

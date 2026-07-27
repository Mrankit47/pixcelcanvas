import 'package:flutter/material.dart';

/// Manager tracking dismissed contextual tooltips and feature discovery tips.
class FeatureDiscoveryManager extends ChangeNotifier {
  final Set<String> _dismissedTipIds = {};

  /// True if feature tip [tipId] has been dismissed.
  bool isDismissed(String tipId) => _dismissedTipIds.contains(tipId);

  /// Dismisses feature tip [tipId].
  void dismissTip(String tipId) {
    _dismissedTipIds.add(tipId);
    notifyListeners();
  }

  /// Resets dismissed tips history.
  void resetTips() {
    _dismissedTipIds.clear();
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

/// Manager handling first-launch onboarding welcome screen per Blueprint §7.5.
class OnboardingManager extends ChangeNotifier {
  bool _isCompleted = false;

  /// True if onboarding setup has been completed.
  bool get isCompleted => _isCompleted;

  /// Completes onboarding flow.
  void completeOnboarding() {
    _isCompleted = true;
    notifyListeners();
  }

  /// Resets onboarding flow for testing/re-run.
  void resetOnboarding() {
    _isCompleted = false;
    notifyListeners();
  }
}

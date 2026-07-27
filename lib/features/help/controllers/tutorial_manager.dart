import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/controllers/tutorial_progress_manager.dart';
import 'package:pixelcanvas/features/help/models/tutorial_models.dart';

/// Runner controller orchestrating interactive step-by-step tutorials.
class TutorialManager extends ChangeNotifier {
  TutorialManager({required this.progressManager});

  final TutorialProgressManager progressManager;

  Tutorial? _activeTutorial;
  int _currentStepIndex = 0;
  bool _isActive = false;

  /// Currently active tutorial, or null if inactive.
  Tutorial? get activeTutorial => _activeTutorial;

  /// Active step index.
  int get currentStepIndex => _currentStepIndex;

  /// True if tutorial mode is currently running.
  bool get isActive => _isActive;

  /// Current step model, or null if inactive.
  TutorialStep? get currentStep {
    if (!_isActive || _activeTutorial == null) return null;
    if (_currentStepIndex >= 0 && _currentStepIndex < _activeTutorial!.steps.length) {
      return _activeTutorial!.steps[_currentStepIndex];
    }
    return null;
  }

  /// Starts tutorial [tutorial].
  void startTutorial(Tutorial tutorial) {
    _activeTutorial = tutorial;
    _currentStepIndex = 0;
    _isActive = true;
    notifyListeners();
  }

  /// Advances to next tutorial step.
  void nextStep() {
    if (!_isActive || _activeTutorial == null) return;

    if (_currentStepIndex + 1 < _activeTutorial!.steps.length) {
      _currentStepIndex++;
    } else {
      // Completed tutorial!
      progressManager.markCompleted(_activeTutorial!.id);
      _isActive = false;
      _activeTutorial = null;
    }
    notifyListeners();
  }

  /// Stops / skips active tutorial.
  void stopTutorial() {
    _isActive = false;
    _activeTutorial = null;
    _currentStepIndex = 0;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/help/models/help_article_models.dart';
import 'package:pixelcanvas/features/help/models/tutorial_models.dart';

/// Progress manager tracking completed tutorials and unlocked achievements.
class TutorialProgressManager extends ChangeNotifier {
  final Map<String, TutorialProgress> _progressMap = {};

  final List<LearningAchievement> _achievements = [
    const LearningAchievement(
      id: 'ach_first_steps',
      title: 'First Steps',
      description: 'Complete your first interactive tutorial.',
      iconName: 'school_rounded',
    ),
    const LearningAchievement(
      id: 'ach_layer_master',
      title: 'Layer Master',
      description: 'Complete the Layer Stack Management tutorial.',
      iconName: 'layers_rounded',
    ),
    const LearningAchievement(
      id: 'ach_animator',
      title: 'Pixel Animator',
      description: 'Complete the Animation Timeline tutorial.',
      iconName: 'movie_creation_rounded',
    ),
  ];

  /// Unmodifiable achievements list.
  List<LearningAchievement> get achievements => List.unmodifiable(_achievements);

  /// Returns progress for [tutorialId].
  TutorialProgress getProgress(String tutorialId) {
    return _progressMap[tutorialId] ?? TutorialProgress(tutorialId: tutorialId);
  }

  /// Marks tutorial [tutorialId] as completed.
  void markCompleted(String tutorialId) {
    _progressMap[tutorialId] = TutorialProgress(
      tutorialId: tutorialId,
      currentStepIndex: 999,
      isCompleted: true,
    );

    // Unlock 'First Steps' achievement
    _unlockAchievement('ach_first_steps');
    notifyListeners();
  }

  void _unlockAchievement(String id) {
    final idx = _achievements.indexWhere((a) => a.id == id);
    if (idx >= 0) {
      _achievements[idx] = _achievements[idx].copyWith(isUnlocked: true);
    }
  }
}

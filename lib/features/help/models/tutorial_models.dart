import 'package:equatable/equatable.dart';

/// Interactive tutorial categories per Blueprint §7.5.
enum TutorialCategory {
  drawingBasics,
  canvasNavigation,
  layers,
  selections,
  animation,
  export,
  keyboardShortcuts,
  projectManagement,
  settings,
  templates,
}

/// Descriptor for a single step in an interactive tutorial.
class TutorialStep extends Equatable {
  /// Creates a [TutorialStep].
  const TutorialStep({
    required this.id,
    required this.title,
    required this.instruction,
    required this.targetUiKey,
    this.expectedAction = 'click',
  });

  final String id;
  final String title;
  final String instruction;
  final String targetUiKey;
  final String expectedAction;

  @override
  List<Object?> get props => [id, title, instruction, targetUiKey, expectedAction];
}

/// Interactive tutorial container.
class Tutorial extends Equatable {
  /// Creates a [Tutorial].
  const Tutorial({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.steps,
    this.estimatedMinutes = 3,
  });

  final String id;
  final String title;
  final String description;
  final TutorialCategory category;
  final List<TutorialStep> steps;
  final int estimatedMinutes;

  @override
  List<Object?> get props => [id, title, description, category, steps, estimatedMinutes];
}

/// Progress state tracker for a tutorial.
class TutorialProgress extends Equatable {
  /// Creates a [TutorialProgress].
  const TutorialProgress({
    required this.tutorialId,
    this.currentStepIndex = 0,
    this.isCompleted = false,
  });

  final String tutorialId;
  final int currentStepIndex;
  final bool isCompleted;

  TutorialProgress copyWith({
    String? tutorialId,
    int? currentStepIndex,
    bool? isCompleted,
  }) =>
      TutorialProgress(
        tutorialId: tutorialId ?? this.tutorialId,
        currentStepIndex: currentStepIndex ?? this.currentStepIndex,
        isCompleted: isCompleted ?? this.isCompleted,
      );

  @override
  List<Object?> get props => [tutorialId, currentStepIndex, isCompleted];
}

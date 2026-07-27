import 'package:pixelcanvas/features/help/models/tutorial_models.dart';

/// Catalog of built-in interactive tutorials per Blueprint §7.5.
class BuiltInTutorials {
  static final List<Tutorial> all = [
    // 1. Drawing Basics
    const Tutorial(
      id: 'tut_drawing_basics',
      title: 'Drawing Basics',
      description: 'Learn how to use the Brush, Eraser, and Bucket Fill tools.',
      category: TutorialCategory.drawingBasics,
      estimatedMinutes: 2,
      steps: [
        TutorialStep(
          id: 'step_1_brush',
          title: 'Select Brush Tool',
          instruction: 'Click the Brush tool icon in the left toolbar (Shortcut: B).',
          targetUiKey: 'tool_brush',
        ),
        TutorialStep(
          id: 'step_2_draw',
          title: 'Draw Pixels',
          instruction: 'Click and drag on the canvas grid matrix to paint pixels.',
          targetUiKey: 'canvas_viewport',
        ),
        TutorialStep(
          id: 'step_3_erase',
          title: 'Erase Mistakes',
          instruction: 'Switch to the Eraser tool (Shortcut: E) to clear unwanted pixels.',
          targetUiKey: 'tool_eraser',
        ),
      ],
    ),

    // 2. Canvas Navigation
    const Tutorial(
      id: 'tut_navigation',
      title: 'Canvas Navigation',
      description: 'Master pan, zoom, and pixel grid toggle controls.',
      category: TutorialCategory.canvasNavigation,
      estimatedMinutes: 2,
      steps: [
        TutorialStep(
          id: 'step_1_zoom',
          title: 'Zoom Viewport',
          instruction: 'Use the mouse scroll wheel or Zoom buttons in the top toolbar.',
          targetUiKey: 'top_toolbar_zoom',
        ),
        TutorialStep(
          id: 'step_2_grid',
          title: 'Toggle Pixel Grid',
          instruction: 'Toggle the pixel grid matrix overlay on or off.',
          targetUiKey: 'toggle_grid',
        ),
      ],
    ),

    // 3. Layer Stack
    const Tutorial(
      id: 'tut_layers',
      title: 'Layer Stack Management',
      description: 'Organize your artwork into non-destructive layer stacks.',
      category: TutorialCategory.layers,
      estimatedMinutes: 3,
      steps: [
        TutorialStep(
          id: 'step_1_create_layer',
          title: 'Create New Layer',
          instruction: 'Click the "+ New Layer" button in the right sidebar.',
          targetUiKey: 'create_layer_btn',
        ),
      ],
    ),
  ];
}

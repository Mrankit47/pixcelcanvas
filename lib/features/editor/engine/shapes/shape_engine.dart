import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_preview.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/circle_tool.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/ellipse_tool.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/line_tool.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/rectangle_tool.dart';

/// Central state manager for shape drawing drag interactions and point generation.
///
/// **Purpose**: Orchestrates in-progress shape preview drag state and point calculation.
/// **Architecture**: Pure Dart — no Riverpod, Widgets, or framework dependencies.
class ShapeEngine {
  /// Current shape configuration settings.
  ShapeSettings settings = const ShapeSettings();

  /// Active shape preview state, or null if idle.
  ShapePreview? _preview;

  /// Active shape preview state getter.
  ShapePreview? get preview => _preview;

  /// True if a shape drag is currently in progress.
  bool get isDrawing => _preview != null && _preview!.isVisible;

  /// Begins a new shape drawing drag interaction at canvas pixel `(x, y)`.
  void beginShape(int x, int y) {
    _preview = ShapePreview(
      startX: x,
      startY: y,
      endX: x,
      endY: y,
      settings: settings,
    );
  }

  /// Updates current drag destination to canvas pixel `(x, y)`.
  void updateShape(int x, int y) {
    if (_preview == null) return;
    _preview!.updateDestination(x, y);
  }

  /// Calculates rasterized integer pixel points for the current shape preview.
  List<Point<int>> getShapePoints() {
    if (_preview == null) return const [];
    return generatePointsForPreview(_preview!);
  }

  /// Calculates rasterized integer pixel points for a given [ShapePreview].
  static List<Point<int>> generatePointsForPreview(ShapePreview preview) {
    final x0 = preview.startX;
    final y0 = preview.startY;
    final x1 = preview.endX;
    final y1 = preview.endY;
    final fillMode = preview.settings.fillMode;

    switch (preview.settings.type) {
      case ShapeType.line:
        return LineTool.generateLinePoints(x0, y0, x1, y1);
      case ShapeType.rectangle:
        return RectangleTool.generateRectanglePoints(x0, y0, x1, y1, fillMode);
      case ShapeType.circle:
        return CircleTool.generateCirclePoints(x0, y0, x1, y1, fillMode);
      case ShapeType.ellipse:
        return EllipseTool.generateEllipsePoints(x0, y0, x1, y1, fillMode);
    }
  }

  /// Finalizes and returns the current [ShapePreview], resetting preview state.
  ShapePreview? commitShape() {
    final active = _preview;
    _preview = null;
    return active;
  }

  /// Cancels the current shape drag, discarding preview state.
  void cancelShape() {
    _preview = null;
  }
}

import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';

/// State container holding in-progress drag coordinates for live shape preview.
///
/// **Purpose**: Tracks drag origin `(startX, startY)` and current position `(endX, endY)`
/// along with shape configuration settings.
///
/// **Architecture**: Pure Dart container — no framework dependencies.
class ShapePreview {
  /// Creates a [ShapePreview].
  ShapePreview({
    required this.startX,
    required this.startY,
    required this.endX,
    required this.endY,
    required this.settings,
    this.isVisible = true,
  });

  /// Drag origin X coordinate in canvas pixels.
  final int startX;

  /// Drag origin Y coordinate in canvas pixels.
  final int startY;

  /// Current drag X coordinate in canvas pixels.
  int endX;

  /// Current drag Y coordinate in canvas pixels.
  int endY;

  /// Active shape configuration settings.
  ShapeSettings settings;

  /// Preview visibility flag.
  bool isVisible;

  /// Returns bounding box enclosing start and end points.
  SelectionBounds get bounds {
    final left = startX < endX ? startX : endX;
    final top = startY < endY ? startY : endY;
    final right = (startX > endX ? startX : endX) + 1;
    final bottom = (startY > endY ? startY : endY) + 1;
    return SelectionBounds(left: left, top: top, right: right, bottom: bottom);
  }

  /// Updates drag destination coordinates.
  void updateDestination(int x, int y) {
    endX = x;
    endY = y;
  }
}

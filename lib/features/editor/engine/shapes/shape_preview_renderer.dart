import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_preview.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/shape_engine.dart';

/// Static overlay painter for rendering shape drag preview.
///
/// **Purpose**: Renders rasterized shape preview points directly to Flutter [Canvas]
/// without modifying [LayerBuffer] pixels.
///
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class ShapePreviewRenderer {
  /// Paints the live shape preview onto [canvas].
  ///
  /// Renders each preview pixel as a filled cell scaled by [cellSize].
  /// Enforces visual clipping if [selectionRegion] is present.
  static void paintPreview({
    required Canvas canvas,
    required Size size,
    required ShapePreview? preview,
    required double cellSize,
    required int canvasWidth,
    required int canvasHeight,
    SelectionRegion? selectionRegion,
  }) {
    if (preview == null || !preview.isVisible) return;

    final points = ShapeEngine.generatePointsForPreview(preview);
    final paint = Paint()..style = PaintingStyle.fill;
    final color = preview.settings.color;

    paint.color = color;

    for (final pt in points) {
      final x = pt.x;
      final y = pt.y;

      // Skip out-of-bounds canvas points
      if (x < 0 || x >= canvasWidth || y < 0 || y >= canvasHeight) {
        continue;
      }

      // Selection clipping visually
      if (selectionRegion != null && selectionRegion.isValid) {
        if (!selectionRegion.containsPoint(x, y)) {
          continue;
        }
      }

      final rect = Rect.fromLTWH(
        x * cellSize,
        y * cellSize,
        cellSize,
        cellSize,
      );
      canvas.drawRect(rect, paint);
    }
  }
}

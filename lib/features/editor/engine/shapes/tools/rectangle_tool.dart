import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/shape_tool.dart';

/// Pixel-perfect Rectangle generator for outline and filled rectangles.
///
/// **Algorithm**: Coordinate normalisation + perimeter line generation or solid scanlines.
/// **Performance**: Direct coordinate bounds iteration.
class RectangleTool implements ShapeTool {
  /// Creates a [RectangleTool].
  const RectangleTool();

  @override
  List<Point<int>> generatePoints({
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required ShapeFillMode fillMode,
  }) {
    return generateRectanglePoints(x0, y0, x1, y1, fillMode);
  }

  /// Generates integer points for a rectangle between `(x0, y0)` and `(x1, y1)`.
  static List<Point<int>> generateRectanglePoints(
    int x0,
    int y0,
    int x1,
    int y1,
    ShapeFillMode fillMode,
  ) {
    final points = <Point<int>>[];

    final minX = math.min(x0, x1);
    final maxX = math.max(x0, x1);
    final minY = math.min(y0, y1);
    final maxY = math.max(y0, y1);

    if (fillMode == ShapeFillMode.filled) {
      for (var y = minY; y <= maxY; y++) {
        for (var x = minX; x <= maxX; x++) {
          points.add(Point(x, y));
        }
      }
    } else {
      // Outline: perimeter pixels only
      // Top and bottom horizontal edges
      for (var x = minX; x <= maxX; x++) {
        points.add(Point(x, minY));
        if (minY != maxY) {
          points.add(Point(x, maxY));
        }
      }
      // Left and right vertical edges (excluding corners already added)
      for (var y = minY + 1; y < maxY; y++) {
        points.add(Point(minX, y));
        if (minX != maxX) {
          points.add(Point(maxX, y));
        }
      }
    }

    return points;
  }
}

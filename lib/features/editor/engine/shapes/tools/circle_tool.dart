import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/shape_tool.dart';

/// Pixel-perfect Circle generator using Midpoint Circle Algorithm.
///
/// **Algorithm**: Midpoint Circle Algorithm (Bresenham Circle).
/// **Performance**: Pure integer arithmetic with deduplicated point sets.
class CircleTool implements ShapeTool {
  /// Creates a [CircleTool].
  const CircleTool();

  @override
  List<Point<int>> generatePoints({
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required ShapeFillMode fillMode,
  }) {
    return generateCirclePoints(x0, y0, x1, y1, fillMode);
  }

  /// Generates integer points for a circle bounded between `(x0, y0)` and `(x1, y1)`.
  static List<Point<int>> generateCirclePoints(
    int x0,
    int y0,
    int x1,
    int y1,
    ShapeFillMode fillMode,
  ) {
    final cx = (x0 + x1) ~/ 2;
    final cy = (y0 + y1) ~/ 2;
    final rx = (x1 - x0).abs() ~/ 2;
    final ry = (y1 - y0).abs() ~/ 2;
    final r = math.min(rx, ry);

    if (r <= 0) {
      return [Point(cx, cy)];
    }

    final pointSet = <int>{};
    final points = <Point<int>>[];

    void addPoint(int px, int py) {
      final key = (px & 0xFFFF) | ((py & 0xFFFF) << 16);
      if (pointSet.add(key)) {
        points.add(Point(px, py));
      }
    }

    void addHLine(int xStart, int xEnd, int py) {
      final start = math.min(xStart, xEnd);
      final end = math.max(xStart, xEnd);
      for (var px = start; px <= end; px++) {
        addPoint(px, py);
      }
    }

    var x = 0;
    var y = r;
    var d = 3 - 2 * r;

    while (y >= x) {
      if (fillMode == ShapeFillMode.filled) {
        addHLine(cx - x, cx + x, cy + y);
        addHLine(cx - x, cx + x, cy - y);
        addHLine(cx - y, cx + y, cy + x);
        addHLine(cx - y, cx + y, cy - x);
      } else {
        // Outline 8-way symmetry
        addPoint(cx + x, cy + y);
        addPoint(cx - x, cy + y);
        addPoint(cx + x, cy - y);
        addPoint(cx - x, cy - y);
        addPoint(cx + y, cy + x);
        addPoint(cx - y, cy + x);
        addPoint(cx + y, cy - x);
        addPoint(cx - y, cy - x);
      }

      if (d < 0) {
        d = d + 4 * x + 6;
      } else {
        d = d + 4 * (x - y) + 10;
        y--;
      }
      x++;
    }

    return points;
  }
}

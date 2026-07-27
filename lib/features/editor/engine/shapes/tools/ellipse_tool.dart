import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/shape_tool.dart';

/// Pixel-perfect Ellipse generator using Midpoint Ellipse Algorithm.
///
/// **Algorithm**: Midpoint Ellipse Algorithm (Region 1 and Region 2).
/// **Performance**: Pure integer arithmetic with deduplicated point sets.
class EllipseTool implements ShapeTool {
  /// Creates an [EllipseTool].
  const EllipseTool();

  @override
  List<Point<int>> generatePoints({
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required ShapeFillMode fillMode,
  }) {
    return generateEllipsePoints(x0, y0, x1, y1, fillMode);
  }

  /// Generates integer points for an ellipse bounded between `(x0, y0)` and `(x1, y1)`.
  static List<Point<int>> generateEllipsePoints(
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

    if (rx <= 0 && ry <= 0) {
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

    // Fallback for 1D line degenerate ellipse
    if (rx <= 0) {
      addHLine(cx, cx, cy - ry);
      for (var y = cy - ry; y <= cy + ry; y++) {
        addPoint(cx, y);
      }
      return points;
    }
    if (ry <= 0) {
      addHLine(cx - rx, cx + rx, cy);
      return points;
    }

    final rx2 = rx * rx;
    final ry2 = ry * ry;

    var x = 0;
    var y = ry;

    var dx = 2 * ry2 * x;
    var dy = 2 * rx2 * y;

    // Region 1 Decision parameter
    var d1 = ry2 - (rx2 * ry) + ((rx2 + 2) ~/ 4);

    while (dx < dy) {
      if (fillMode == ShapeFillMode.filled) {
        addHLine(cx - x, cx + x, cy + y);
        addHLine(cx - x, cx + x, cy - y);
      } else {
        addPoint(cx + x, cy + y);
        addPoint(cx - x, cy + y);
        addPoint(cx + x, cy - y);
        addPoint(cx - x, cy - y);
      }

      x++;
      dx += 2 * ry2;

      if (d1 < 0) {
        d1 += dx + ry2;
      } else {
        y--;
        dy -= 2 * rx2;
        d1 += dx - dy + ry2;
      }
    }

    // Region 2 Decision parameter
    var d2 = (ry2 * (x * 2 + 1) * (x * 2 + 1) ~/ 4) +
        (rx2 * (y - 1) * (y - 1)) -
        (rx2 * ry2);

    while (y >= 0) {
      if (fillMode == ShapeFillMode.filled) {
        addHLine(cx - x, cx + x, cy + y);
        addHLine(cx - x, cx + x, cy - y);
      } else {
        addPoint(cx + x, cy + y);
        addPoint(cx - x, cy + y);
        addPoint(cx + x, cy - y);
        addPoint(cx - x, cy - y);
      }

      y--;
      dy -= 2 * rx2;

      if (d2 > 0) {
        d2 += rx2 - dy;
      } else {
        x++;
        dx += 2 * ry2;
        d2 += dx - dy + rx2;
      }
    }

    return points;
  }
}

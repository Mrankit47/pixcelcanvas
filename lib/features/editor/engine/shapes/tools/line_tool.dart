import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/tools/shape_tool.dart';

/// Pixel-perfect Line generator using Bresenham's Integer Line Algorithm.
///
/// **Algorithm**: Bresenham's Line Algorithm.
/// **Performance**: Pure integer arithmetic `O(N)` loop steps ensuring maximum speed and zero aliasing.
class LineTool implements ShapeTool {
  /// Creates a [LineTool].
  const LineTool();

  @override
  List<Point<int>> generatePoints({
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required ShapeFillMode fillMode,
  }) {
    return generateLinePoints(x0, y0, x1, y1);
  }

  /// Generates integer points along the line segment from `(x0, y0)` to `(x1, y1)`.
  static List<Point<int>> generateLinePoints(int x0, int y0, int x1, int y1) {
    final points = <Point<int>>[];

    final dx = (x1 - x0).abs();
    final sx = x0 < x1 ? 1 : -1;
    final dy = -(y1 - y0).abs();
    final sy = y0 < y1 ? 1 : -1;
    var err = dx + dy;

    var curX = x0;
    var curY = y0;

    while (true) {
      points.add(Point(curX, curY));
      if (curX == x1 && curY == y1) break;

      final e2 = 2 * err;
      if (e2 >= dy) {
        err += dy;
        curX += sx;
      }
      if (e2 <= dx) {
        err += dx;
        curY += sy;
      }
    }

    return points;
  }
}

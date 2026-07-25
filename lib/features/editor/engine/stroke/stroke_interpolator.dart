import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';

/// Bresenham-based line interpolation engine for continuous pixel art drawing per Blueprint §8.1.
///
/// **Algorithm**: Bresenham's Integer Line Algorithm.
/// **Interpolation Strategy**: Calculates integer pixel steps between start `(x0, y0)` and end `(x1, y1)` points.
/// **Performance Characteristics**: Zero floating point arithmetic, integer `O(N)` loop steps ensuring seamless 60 FPS lines.
class StrokeInterpolator {
  /// Computes all intermediate contiguous pixel points between `(x0, y0)` and `(x1, y1)`.
  static List<Point<int>> interpolateLine(int x0, int y0, int x1, int y1) {
    final points = <Point<int>>[];

    var dx = (x1 - x0).abs();
    final sx = x0 < x1 ? 1 : -1;
    var dy = -(y1 - y0).abs();
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

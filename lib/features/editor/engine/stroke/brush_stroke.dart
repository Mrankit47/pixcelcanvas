import 'package:pixelcanvas/features/editor/engine/stroke/stroke_point.dart';

/// Continuous stroke sequence container per Blueprint §8.1.
class BrushStroke {
  /// Ordered list of sampled points.
  final List<StrokePoint> points = [];

  /// Adds a point to the stroke.
  void addPoint(StrokePoint point) {
    points.add(point);
  }

  /// Clears stroke points.
  void clear() {
    points.clear();
  }
}

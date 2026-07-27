import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';

/// Abstract base class / utility interface for pixel-perfect shape point generation.
///
/// **Architecture Rules**: Integer arithmetic only, zero anti-aliasing, zero smoothing.
/// Pure Dart — no framework or widget dependencies.
abstract class ShapeTool {
  /// Generates a list of canvas pixel grid points `List<Point<int>>` for a shape.
  List<Point<int>> generatePoints({
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required ShapeFillMode fillMode,
  });
}

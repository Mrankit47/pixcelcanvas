import 'package:pixelcanvas/features/editor/engine/eraser/eraser_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/stroke_interpolator.dart';

/// Configurable Eraser Tool per Blueprint §8.1.
class EraserTool {
  /// Erases along an interpolated stroke between `(x0, y0)` and `(x1, y1)` using [settings].
  static void eraseStroke({
    required LayerBuffer layer,
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required EraserSettings settings,
  }) {
    final points = StrokeInterpolator.interpolateLine(x0, y0, x1, y1);
    for (final pt in points) {
      EraserRenderer.eraseBrush(
        layer: layer,
        centerX: pt.x,
        centerY: pt.y,
        settings: settings,
      );
    }
  }
}

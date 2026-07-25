import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/brush/brush_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/stroke_interpolator.dart';

/// 1-Pixel Precision Pencil Drawing Tool per Blueprint §8.1.
class PencilTool {
  /// Plots a interpolated 1-pixel pencil line between `(x0, y0)` and `(x1, y1)`.
  static void drawLine({
    required LayerBuffer layer,
    required int x0,
    required int y0,
    required int x1,
    required int y1,
    required Color color,
  }) {
    final points = StrokeInterpolator.interpolateLine(x0, y0, x1, y1);
    for (final pt in points) {
      BrushRenderer.plotPixel(
        layer: layer,
        x: pt.x,
        y: pt.y,
        color: color,
      );
    }
  }
}

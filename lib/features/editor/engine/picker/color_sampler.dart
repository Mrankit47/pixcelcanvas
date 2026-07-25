import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_grid.dart';

/// Color Sampler Engine per Blueprint §8.1.
///
/// **Purpose**: Samples exact pixel color from active composited canvas matrix.
class ColorSampler {
  /// Samples composite pixel color at `(x, y)`.
  static Color sampleColor({
    required PixelGrid grid,
    required int x,
    required int y,
  }) {
    if (x < 0 || x >= grid.width || y < 0 || y >= grid.height) {
      return Colors.transparent;
    }
    final pixel = grid.compositeBuffer.getPixel(x, y);
    return pixel.color;
  }
}

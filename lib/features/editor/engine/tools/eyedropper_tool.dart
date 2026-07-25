import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/picker/color_sampler.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_grid.dart';

/// Eyedropper Color Picker Tool per Blueprint §8.1.
class EyedropperTool {
  /// Samples pixel color at `(x, y)` from [grid].
  static Color sample({
    required PixelGrid grid,
    required int x,
    required int y,
  }) {
    return ColorSampler.sampleColor(
      grid: grid,
      x: x,
      y: y,
    );
  }
}

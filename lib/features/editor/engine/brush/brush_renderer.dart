import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Brush Renderer Engine executing pixel plots on layer buffers per Blueprint §8.1.
///
/// **Purpose**: Plots single pixel or N×N square/round brush stamps on target [LayerBuffer].
/// **Performance Characteristics**: Direct boundary-checked `setPixel` calls with cached [Pixel] objects.
class BrushRenderer {
  /// Plots a brush stamp centered at `(centerX, centerY)` with given [settings] and [color].
  static void plotBrush({
    required LayerBuffer layer,
    required int centerX,
    required int centerY,
    required Color color,
    required BrushSettings settings,
  }) {
    if (layer.isLocked || !layer.isVisible) return;

    final radius = settings.size ~/ 2;
    final pixel = Pixel(color: color, opacity: settings.opacity);

    if (settings.size == 1) {
      layer.setPixel(centerX, centerY, pixel);
      return;
    }

    // Square brush footprint (1x1, 2x2, 3x3, ..., 8x8)
    final startX = centerX - radius;
    final startY = centerY - radius;
    final endX = startX + settings.size;
    final endY = startY + settings.size;

    for (var y = startY; y < endY; y++) {
      for (var x = startX; x < endX; x++) {
        layer.setPixel(x, y, pixel);
      }
    }
  }

  /// Plots a single pixel at `(x, y)`.
  static void plotPixel({
    required LayerBuffer layer,
    required int x,
    required int y,
    required Color color,
  }) {
    if (layer.isLocked || !layer.isVisible) return;
    layer.setPixel(x, y, Pixel(color: color));
  }
}

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/export/models/export_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_buffer.dart';

/// Canvas flattening renderer per Blueprint §8.1.
///
/// **Purpose**: Produces a scaled RGBA byte buffer from the composited [PixelBuffer].
/// **Flattening Pipeline**: Reads composited buffer → scales via nearest-neighbour → outputs raw RGBA bytes.
/// **Memory Usage**: Output buffer = `outputWidth × outputHeight × 4` bytes (RGBA).
/// For 1024×1024 @ 1x = ~4 MB.
class CanvasRenderer {
  /// Renders the composited [buffer] into raw RGBA pixel bytes.
  ///
  /// Uses nearest-neighbour scaling to preserve pixel-art crispness (no smoothing).
  static Uint8List renderToRgba({
    required PixelBuffer buffer,
    required ExportSettings settings,
  }) {
    final scale = settings.scale;
    final outW = buffer.width * scale;
    final outH = buffer.height * scale;
    final bytes = Uint8List(outW * outH * 4);

    for (var y = 0; y < buffer.height; y++) {
      for (var x = 0; x < buffer.width; x++) {
        final pixel = buffer.getPixel(x, y);

        int r, g, b, a;
        if (pixel.isEmpty && settings.preserveTransparency) {
          r = g = b = a = 0;
        } else if (pixel.isEmpty) {
          r = g = b = 255;
          a = 255;
        } else {
          r = (pixel.color.r * 255).round();
          g = (pixel.color.g * 255).round();
          b = (pixel.color.b * 255).round();
          a = (pixel.color.a * pixel.opacity * 255).round();
        }

        // Nearest-neighbour scale: stamp each source pixel into scale×scale output block.
        for (var sy = 0; sy < scale; sy++) {
          for (var sx = 0; sx < scale; sx++) {
            final outX = x * scale + sx;
            final outY = y * scale + sy;
            final idx = (outY * outW + outX) * 4;
            bytes[idx] = r;
            bytes[idx + 1] = g;
            bytes[idx + 2] = b;
            bytes[idx + 3] = a;
          }
        }
      }
    }

    return bytes;
  }
}

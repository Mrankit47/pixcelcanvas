import 'dart:ui';
import 'package:image/image.dart' as img;

import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Converts decoded RGBA image buffers into PixelCanvas `List<Pixel>` array buffers.
///
/// **Algorithm**: Nearest-Neighbor sampling with alpha transparency preservation.
/// **Performance**: Pure integer ratio scaling, zero anti-aliasing, zero floating-point interpolation.
class PixelConverter {
  /// Converts [decoded] image to a 1D row-major `List<Pixel>` scaled to [targetWidth] × [targetHeight].
  static List<Pixel> convertAndScale({
    required img.Image decoded,
    required int targetWidth,
    required int targetHeight,
    bool preserveTransparency = true,
  }) {
    final srcW = decoded.width;
    final srcH = decoded.height;
    final targetW = targetWidth.clamp(1, 4096);
    final targetH = targetHeight.clamp(1, 4096);

    final pixels = List<Pixel>.filled(targetW * targetH, Pixel.empty);

    for (var ty = 0; ty < targetH; ty++) {
      for (var tx = 0; tx < targetW; tx++) {
        // Nearest-neighbor integer mapping
        final ox = ((tx * srcW) ~/ targetW).clamp(0, srcW - 1);
        final oy = ((ty * srcH) ~/ targetH).clamp(0, srcH - 1);

        final p = decoded.getPixel(ox, oy);
        final a = preserveTransparency ? p.a.toInt() : 255;

        if (a <= 0) {
          pixels[(ty * targetW) + tx] = Pixel.empty;
        } else {
          final r = p.r.toInt();
          final g = p.g.toInt();
          final b = p.b.toInt();

          final color = Color.fromARGB(a, r, g, b);
          pixels[(ty * targetW) + tx] = Pixel(color: color);
        }
      }
    }

    return pixels;
  }
}

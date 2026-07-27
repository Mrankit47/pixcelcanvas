import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Color quantization and dithering engine for palette reduction.
///
/// **Supported Modes**: 16, 32, 64, 128, 256 colors.
/// **Dithering**: Floyd–Steinberg error diffusion dithering.
/// **Performance**: Euclidean RGB color matching with palette frequency sorting.
class PaletteReducer {
  /// Reduces palette of [pixels] to target color count according to [paletteMode] and [ditherMode].
  static List<Pixel> reducePalette({
    required List<Pixel> pixels,
    required int width,
    required int height,
    required ImportPaletteMode paletteMode,
    required ImportDitherMode ditherMode,
  }) {
    final maxColors = _getMaxColors(paletteMode);
    if (maxColors == null) return pixels; // Unlimited mode

    // Extract unique colors and frequencies
    final colorCounts = <int, int>{};
    for (final p in pixels) {
      if (!p.isEmpty) {
        final argb = p.color.toARGB32();
        colorCounts[argb] = (colorCounts[argb] ?? 0) + 1;
      }
    }

    // If existing colors fit within palette budget, no reduction needed
    if (colorCounts.length <= maxColors) {
      return pixels;
    }

    // Generate quantized color palette
    final palette = _buildPalette(colorCounts, maxColors);

    if (ditherMode == ImportDitherMode.floydSteinberg) {
      return _applyFloydSteinbergDithering(
        pixels: pixels,
        width: width,
        height: height,
        palette: palette,
      );
    } else {
      return _applyDirectQuantization(
        pixels: pixels,
        palette: palette,
      );
    }
  }

  static int? _getMaxColors(ImportPaletteMode mode) {
    switch (mode) {
      case ImportPaletteMode.unlimited:
      case ImportPaletteMode.customPalette:
        return null;
      case ImportPaletteMode.c16:
        return 16;
      case ImportPaletteMode.c32:
        return 32;
      case ImportPaletteMode.c64:
        return 64;
      case ImportPaletteMode.c128:
        return 128;
      case ImportPaletteMode.c256:
        return 256;
    }
  }

  /// Builds a palette of size [maxColors] using frequency sorting and Euclidean distance.
  static List<Color> _buildPalette(Map<int, int> colorCounts, int maxColors) {
    // Sort colors by frequency descending
    final sortedEntries = colorCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final palette = <Color>[];
    for (final entry in sortedEntries) {
      if (palette.length >= maxColors) break;
      palette.add(Color(entry.key));
    }

    return palette;
  }

  /// Finds nearest color in [palette] using Euclidean RGB distance.
  static Color _findNearestColor(Color target, List<Color> palette) {
    if (palette.isEmpty) return target;

    var minDistance = double.infinity;
    var nearest = palette.first;

    final tr = (target.r * 255).round();
    final tg = (target.g * 255).round();
    final tb = (target.b * 255).round();

    for (final c in palette) {
      final cr = (c.r * 255).round();
      final cg = (c.g * 255).round();
      final cb = (c.b * 255).round();

      final dr = tr - cr;
      final dg = tg - cg;
      final db = tb - cb;

      final dist = (dr * dr + dg * dg + db * db).toDouble();
      if (dist < minDistance) {
        minDistance = dist;
        nearest = c;
      }
    }

    return nearest;
  }

  /// Direct palette mapping without error diffusion.
  static List<Pixel> _applyDirectQuantization({
    required List<Pixel> pixels,
    required List<Color> palette,
  }) {
    final result = List<Pixel>.filled(pixels.length, Pixel.empty);
    final cache = <int, Color>{};

    for (var i = 0; i < pixels.length; i++) {
      final p = pixels[i];
      if (p.isEmpty) continue;

      final argb = p.color.toARGB32();
      final mappedColor = cache.putIfAbsent(
        argb,
        () => _findNearestColor(p.color, palette),
      );

      result[i] = Pixel(color: mappedColor);
    }

    return result;
  }

  /// Floyd-Steinberg error diffusion dithering algorithm.
  static List<Pixel> _applyFloydSteinbergDithering({
    required List<Pixel> pixels,
    required int width,
    required int height,
    required List<Color> palette,
  }) {
    // Working RGB buffers for error accumulation
    final rBuf = List<double>.filled(pixels.length, 0);
    final gBuf = List<double>.filled(pixels.length, 0);
    final bBuf = List<double>.filled(pixels.length, 0);
    final aBuf = List<double>.filled(pixels.length, 0);

    for (var i = 0; i < pixels.length; i++) {
      final p = pixels[i];
      if (!p.isEmpty) {
        rBuf[i] = p.color.r * 255;
        gBuf[i] = p.color.g * 255;
        bBuf[i] = p.color.b * 255;
        aBuf[i] = p.color.a * 255;
      }
    }

    final result = List<Pixel>.filled(pixels.length, Pixel.empty);

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final idx = (y * width) + x;
        if (aBuf[idx] <= 0) continue;

        final curColor = Color.fromARGB(
          aBuf[idx].round().clamp(0, 255),
          rBuf[idx].round().clamp(0, 255),
          gBuf[idx].round().clamp(0, 255),
          bBuf[idx].round().clamp(0, 255),
        );

        final nearest = _findNearestColor(curColor, palette);
        result[idx] = Pixel(color: nearest);

        // Compute quantization errors
        final errR = rBuf[idx] - (nearest.r * 255);
        final errG = gBuf[idx] - (nearest.g * 255);
        final errB = bBuf[idx] - (nearest.b * 255);

        // Distribute error to 4 neighbors:
        // (x+1, y)   : 7/16
        // (x-1, y+1) : 3/16
        // (x,   y+1) : 5/16
        // (x+1, y+1) : 1/16
        void distribute(int nx, int ny, double factor) {
          if (nx >= 0 && nx < width && ny >= 0 && ny < height) {
            final nIdx = (ny * width) + nx;
            if (aBuf[nIdx] > 0) {
              rBuf[nIdx] += errR * factor;
              gBuf[nIdx] += errG * factor;
              bBuf[nIdx] += errB * factor;
            }
          }
        }

        distribute(x + 1, y, 7.0 / 16.0);
        distribute(x - 1, y + 1, 3.0 / 16.0);
        distribute(x, y + 1, 5.0 / 16.0);
        distribute(x + 1, y + 1, 1.0 / 16.0);
      }
    }

    return result;
  }
}

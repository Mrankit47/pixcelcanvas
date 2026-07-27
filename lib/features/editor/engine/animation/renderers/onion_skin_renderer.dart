import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Static painter for rendering onion skin translucent frame overlays onto Canvas.
///
/// **Purpose**: Draws translucent previous and next frame overlays with red/green color tinting.
/// **Architecture**: Pure static painter — no state, no framework dependencies.
class OnionSkinRenderer {
  /// Paints onion skin overlays for active [clip] at [currentFrameIndex] onto [canvas].
  static void paintOnionSkin({
    required Canvas canvas,
    required Size size,
    required AnimationClip? clip,
    required int currentFrameIndex,
    required AnimationSettings settings,
    required double cellSize,
  }) {
    if (!settings.onionSkinEnabled || clip == null || clip.frames.isEmpty) return;

    final totalFrames = clip.frameCount;
    final paint = Paint()..style = PaintingStyle.fill;

    final prevColor = _parseColorHex(settings.onionSkinPreviousColorHex);
    final nextColor = _parseColorHex(settings.onionSkinNextColorHex);

    // 1. Render previous frame overlays (Red tint default)
    for (var step = 1; step <= settings.onionSkinPreviousFrames; step++) {
      final prevIndex = currentFrameIndex - step;
      if (prevIndex >= 0) {
        final frame = clip.frames[prevIndex];
        final opacityStep = settings.onionSkinOpacity / step;
        _paintFrameOverlay(
          canvas: canvas,
          size: size,
          pixels: frame.pixels,
          tintColor: prevColor,
          opacity: opacityStep,
          cellSize: cellSize,
          paint: paint,
        );
      }
    }

    // 2. Render next frame overlays (Green tint default)
    for (var step = 1; step <= settings.onionSkinNextFrames; step++) {
      final nextIndex = currentFrameIndex + step;
      if (nextIndex < totalFrames) {
        final frame = clip.frames[nextIndex];
        final opacityStep = settings.onionSkinOpacity / step;
        _paintFrameOverlay(
          canvas: canvas,
          size: size,
          pixels: frame.pixels,
          tintColor: nextColor,
          opacity: opacityStep,
          cellSize: cellSize,
          paint: paint,
        );
      }
    }
  }

  static void _paintFrameOverlay({
    required Canvas canvas,
    required Size size,
    required List<Pixel> pixels,
    required Color tintColor,
    required double opacity,
    required double cellSize,
    required Paint paint,
  }) {
    if (pixels.isEmpty) return;

    final width = (size.width / cellSize).round();
    final height = (size.height / cellSize).round();

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final idx = (y * width) + x;
        if (idx >= pixels.length) continue;

        final px = pixels[idx];
        if (px.isEmpty) continue;

        final screenX = x * cellSize;
        final screenY = y * cellSize;

        if (screenX + cellSize < 0 ||
            screenX > size.width ||
            screenY + cellSize < 0 ||
            screenY > size.height) {
          continue;
        }

        // Tint overlay with translucent alpha
        final finalAlpha = (opacity * px.opacity * px.color.a).clamp(0.0, 1.0);
        paint.color = Color.fromARGB(
          (finalAlpha * 255).round(),
          (tintColor.r * 255).round(),
          (tintColor.g * 255).round(),
          (tintColor.b * 255).round(),
        );

        canvas.drawRect(
          Rect.fromLTWH(screenX, screenY, cellSize, cellSize),
          paint,
        );
      }
    }
  }

  static Color _parseColorHex(String hex) {
    try {
      final clean = hex.replaceAll('#', '');
      final val = int.parse('FF$clean', radix: 16);
      return Color(val);
    } catch (_) {
      return const Color(0xFFFF0000);
    }
  }
}

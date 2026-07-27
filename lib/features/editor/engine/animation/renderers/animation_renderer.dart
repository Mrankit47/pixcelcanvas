import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_settings.dart';
import 'package0/pixelcanvas/features/editor/engine/animation/renderers/onion_skin_renderer.dart';

/// Static renderer for active animation frames and onion skin overlays.
///
/// **Purpose**: Paints active frame pixel grid and onion skin translucent overlays onto [Canvas].
/// **Architecture**: Pure static painter — no state, no framework dependencies.
class AnimationRenderer {
  /// Paints active frame and onion skins for [clip] at [currentFrameIndex] onto [canvas].
  static void paintAnimation({
    required Canvas canvas,
    required Size size,
    required AnimationClip? clip,
    required int currentFrameIndex,
    required AnimationSettings settings,
    required double cellSize,
  }) {
    if (clip == null || clip.frames.isEmpty) return;

    // 1. Paint Onion Skin Translucent Overlays if enabled
    if (settings.onionSkinEnabled) {
      OnionSkinRenderer.paintOnionSkin(
        canvas: canvas,
        size: size,
        clip: clip,
        currentFrameIndex: currentFrameIndex,
        settings: settings,
        cellSize: cellSize,
      );
    }

    // 2. Paint Active Frame Pixels
    final frameIdx = currentFrameIndex.clamp(0, clip.frameCount - 1);
    final activeFrame = clip.frames[frameIdx];

    if (activeFrame.pixels.isEmpty) return;

    final width = (size.width / cellSize).round();
    final height = (size.height / cellSize).round();
    final paint = Paint()..style = PaintingStyle.fill;

    for (var y = 0; y < height; y++) {
      for (var x = 0; x < width; x++) {
        final idx = (y * width) + x;
        if (idx >= activeFrame.pixels.length) continue;

        final px = activeFrame.pixels[idx];
        if (px.isEmpty) continue;

        final screenX = x * cellSize;
        final screenY = y * cellSize;

        if (screenX + cellSize < 0 ||
            screenX > size.width ||
            screenY + cellSize < 0 ||
            screenY > size.height) {
          continue;
        }

        paint.color = px.color.withValues(
          alpha: px.opacity * px.color.a,
        );

        canvas.drawRect(
          Rect.fromLTWH(screenX, screenY, cellSize, cellSize),
          paint,
        );
      }
    }
  }
}

import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection.dart';

/// Static renderer for floating selection pixels.
///
/// **Purpose**: Paints the floating selection's pixel buffer above all canvas
/// layers, independently from [PixelCanvasPainter]. This ensures that floating
/// pixels are visible during a move/paste operation without being composited
/// into the layer stack.
///
/// **Architecture**: Pure static methods — no state, no framework dependencies.
/// Receives a [FloatingSelection] and paints directly onto a [Canvas].
///
/// **Future**: Transform handles (rotation, scaling) will be added as a separate
/// render pass in this class when transform operations are implemented.
class FloatingSelectionRenderer {
  /// Paints the floating selection's pixels onto [canvas].
  ///
  /// Each non-empty pixel is rendered as a filled rectangle at its translated
  /// position: `(originalBounds.left + offsetX + localX) * cellSize`.
  ///
  /// Does nothing if [floating] is null or not visible.
  static void paint({
    required Canvas canvas,
    required Size size,
    required FloatingSelection? floating,
    required double cellSize,
  }) {
    if (floating == null || !floating.isVisible) return;

    final bounds = floating.currentBounds;
    final paint = Paint()..style = PaintingStyle.fill;

    for (var localY = 0; localY < floating.height; localY++) {
      for (var localX = 0; localX < floating.width; localX++) {
        final pixel = floating.getPixel(localX, localY);
        if (pixel.isEmpty) continue;

        final canvasX = bounds.left + localX;
        final canvasY = bounds.top + localY;

        // Skip pixels that are completely outside the visible canvas area
        final screenX = canvasX * cellSize;
        final screenY = canvasY * cellSize;
        if (screenX + cellSize < 0 ||
            screenX > size.width ||
            screenY + cellSize < 0 ||
            screenY > size.height) {
          continue;
        }

        paint.color = pixel.color.withValues(
          alpha: pixel.opacity * pixel.color.a,
        );

        final rect = Rect.fromLTWH(screenX, screenY, cellSize, cellSize);
        canvas.drawRect(rect, paint);
      }
    }
  }

  /// Paints a border outline around the floating selection bounds.
  ///
  /// Provides visual feedback for the floating selection area during movement.
  static void paintBorder({
    required Canvas canvas,
    required FloatingSelection? floating,
    required double cellSize,
    Color borderColor = const Color(0xFF2196F3),
    double strokeWidth = 1.5,
  }) {
    if (floating == null || !floating.isVisible) return;

    final bounds = floating.currentBounds;
    final rect = Rect.fromLTRB(
      bounds.left * cellSize,
      bounds.top * cellSize,
      bounds.right * cellSize,
      bounds.bottom * cellSize,
    );

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRect(rect, borderPaint);
  }
}

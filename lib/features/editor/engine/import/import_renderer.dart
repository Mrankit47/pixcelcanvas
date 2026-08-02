import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/import/models/import_preview.dart';

/// Static painter for rendering image import live preview.
///
/// **Purpose**: Draws preview pixels and target dimension bounding box onto [Canvas].
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class ImportRenderer {
  /// Paints the live import preview onto [canvas].
  static void paintImportPreview({
    required Canvas canvas,
    required Size size,
    required ImportPreview? preview,
    required double cellSize,
  }) {
    if (preview == null || !preview.isVisible || preview.isCorrupted) return;

    final targetW = preview.targetWidth;
    final targetH = preview.targetHeight;
    final paint = Paint()..style = PaintingStyle.fill;

    // 1. Draw preview pixels
    for (var y = 0; y < targetH; y++) {
      for (var x = 0; x < targetW; x++) {
        final pixel = preview.getPixel(x, y);
        if (pixel.isEmpty) continue;

        final screenX = x * cellSize;
        final screenY = y * cellSize;

        if (screenX + cellSize < 0 ||
            screenX > size.width ||
            screenY + cellSize < 0 ||
            screenY > size.height) {
          continue;
        }

        final clampedAlpha = (pixel.opacity * (pixel.color.a / 255.0)).clamp(0.0, 1.0);
        paint.color = pixel.color.withOpacity(clampedAlpha);

        final rect = Rect.fromLTWH(screenX, screenY, cellSize, cellSize);
        canvas.drawRect(rect, paint);
      }
    }

    // 2. Draw target bounding outline
    final boundsRect = Rect.fromLTWH(
      0,
      0,
      targetW * cellSize,
      targetH * cellSize,
    );

    final borderPaint = Paint()
      ..color = const Color(0xFF0984E3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawRect(boundsRect, borderPaint);
  }
}

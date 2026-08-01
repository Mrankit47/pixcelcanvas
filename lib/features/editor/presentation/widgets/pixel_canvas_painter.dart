import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// High-performance CustomPainter rendering pixel canvas matrix per Blueprint §8.1.
///
/// **Purpose**: Draws background checkerboard, composite pixels via `Canvas.drawRect()`, and pixel grid lines.
/// **Performance Considerations**: Listens directly to [CanvasEngine] for repaints without triggering widget rebuilds.
class PixelCanvasPainter extends CustomPainter {
  /// Creates a [PixelCanvasPainter].
  PixelCanvasPainter({
    required this.engine,
    this.showGrid = true,
  }) : super(repaint: engine);

  /// Engine reference.
  final CanvasEngine engine;

  /// Grid lines visibility.
  final bool showGrid;

  @override
  void paint(Canvas canvas, Size size) {
    final cellSize = size.width / engine.width;
    final paint = Paint()..style = PaintingStyle.fill;

    // 1. Draw Checkerboard Background
    final bgLight = Paint()..color = AppColors.neutral0;
    final bgDark = Paint()..color = AppColors.neutral100;

    for (var y = 0; y < engine.height; y++) {
      for (var x = 0; x < engine.width; x++) {
        final rect = Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize);
        canvas.drawRect(rect, (x + y) % 2 == 0 ? bgLight : bgDark);
      }
    }

    // 2. Draw Composite Pixels
    for (var y = 0; y < engine.height; y++) {
      for (var x = 0; x < engine.width; x++) {
        final pixel = engine.grid.compositeBuffer.getPixel(x, y);
        if (!pixel.isEmpty) {
          paint.color = pixel.color.withValues(alpha: pixel.opacity * (pixel.color.a));
          final rect = Rect.fromLTWH(x * cellSize, y * cellSize, cellSize, cellSize);
          canvas.drawRect(rect, paint);
        }
      }
    }

    // 3. Draw Active Shape Preview
    if (engine.shapeEngine.isDrawing) {
      final shapePaint = Paint()
        ..color = engine.session.activeColor
        ..style = PaintingStyle.fill;
      for (final p in engine.shapeEngine.getShapePoints()) {
        if (p.x >= 0 && p.x < engine.width && p.y >= 0 && p.y < engine.height) {
          final rect = Rect.fromLTWH(p.x * cellSize, p.y * cellSize, cellSize, cellSize);
          canvas.drawRect(rect, shapePaint);
        }
      }
    }

    // 4. Draw Selection Overlay
    if (engine.hasSelection && engine.selectionEngine.isSelectionVisible) {
      final bounds = engine.selectionEngine.selectionBounds;
      if (bounds != null) {
        final selPaint = Paint()
          ..color = AppColors.primary500
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5;
        final selRect = Rect.fromLTRB(
          bounds.left * cellSize,
          bounds.top * cellSize,
          (bounds.right + 1) * cellSize,
          (bounds.bottom + 1) * cellSize,
        );
        canvas.drawRect(selRect, selPaint);
      }
    }

    // 5. Draw Grid Lines
    if (showGrid) {
      final gridPaint = Paint()
        ..color = AppColors.neutral200.withValues(alpha: 0.4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.5;

      for (var i = 0; i <= engine.width; i++) {
        canvas.drawLine(
          Offset(i * cellSize, 0),
          Offset(i * cellSize, size.height),
          gridPaint,
        );
      }
      for (var j = 0; j <= engine.height; j++) {
        canvas.drawLine(
          Offset(0, j * cellSize),
          Offset(size.width, j * cellSize),
          gridPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant PixelCanvasPainter oldDelegate) =>
      oldDelegate.showGrid != showGrid;
}

import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_preview.dart';

/// Static renderer for drawing transform bounding box, handles, and live pixel preview.
///
/// **Purpose**: Paints the transform preview overlay independently from canvas drawing layers.
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class TransformRenderer {
  /// Paints the complete transform preview onto [canvas].
  ///
  /// Renders floating pixels, bounding box, 8 resize handles (corners + midpoints),
  /// and the rotation handle placeholder.
  static void paintTransformPreview({
    required Canvas canvas,
    required Size size,
    required TransformPreview? preview,
    required double cellSize,
  }) {
    if (preview == null || !preview.isVisible) return;

    final floating = preview.floatingSelection;
    final bounds = preview.bounds;
    final settings = preview.settings;

    // 1. Render floating pixels
    FloatingSelectionRenderer.paint(
      canvas: canvas,
      size: size,
      floating: floating,
      cellSize: cellSize,
    );

    // 2. Render bounding box outline
    final rect = bounds.toRect(cellSize);
    final borderPaint = Paint()
      ..color = settings.borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = settings.borderWidth;

    canvas.drawRect(rect, borderPaint);

    // 3. Render 8 corner & edge handles
    final fillPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    final handleStrokePaint = Paint()
      ..color = settings.handleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final hs = settings.handleSize;
    final positions = <Offset>[
      // Corners
      Offset(rect.left, rect.top),
      Offset(rect.right, rect.top),
      Offset(rect.left, rect.bottom),
      Offset(rect.right, rect.bottom),
      // Edge midpoints
      Offset(rect.center.dx, rect.top),
      Offset(rect.right, rect.center.dy),
      Offset(rect.center.dx, rect.bottom),
      Offset(rect.left, rect.center.dy),
    ];

    for (final pos in positions) {
      final handleRect = Rect.fromCenter(
        center: pos,
        width: hs,
        height: hs,
      );
      canvas.drawRect(handleRect, fillPaint);
      canvas.drawRect(handleRect, handleStrokePaint);
    }

    // 4. Render rotation handle placeholder (positioned above top-center)
    if (settings.showRotationHandle) {
      final rotPos = Offset(rect.center.dx, rect.top - (hs * 2.0));

      // Draw connecting line from top-center to rotation handle
      final linePaint = Paint()
        ..color = settings.borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(rect.center.dx, rect.top), rotPos, linePaint);

      // Draw circular rotation handle
      final circleFill = Paint()
        ..color = const Color(0xFFFFFFFF)
        ..style = PaintingStyle.fill;

      canvas.drawCircle(rotPos, hs / 2.0, circleFill);
      canvas.drawCircle(rotPos, hs / 2.0, handleStrokePaint);
    }
  }
}

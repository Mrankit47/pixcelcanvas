import 'dart:math' as math;
import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_settings.dart';

/// Static selection overlay renderer.
///
/// **Purpose**: Paints the selection overlay independently of pixel data.
/// Renders three layers:
/// 1. Semi-transparent dimming overlay outside the selection
/// 2. Dashed border (static marching ants pattern)
/// 3. Resize handles at corners and edge midpoints
///
/// **Architecture**: Pure static methods — no state, no framework dependencies.
/// Receives geometry and paints directly onto a [Canvas].
///
/// **Future**: Marching ants animation will be achieved by passing a varying
/// [dashOffset] from a ticker/animation controller. The rendering infrastructure
/// is ready — only the animation driver is deferred.
class SelectionRenderer {
  // ---------------------------------------------------------------------------
  // Main Entry Point
  // ---------------------------------------------------------------------------

  /// Paints the complete selection overlay onto [canvas].
  ///
  /// Renders overlay, dashed border, and resize handles for the given [bounds].
  /// Does nothing if [bounds] is null or invalid.
  static void paintSelectionOverlay({
    required Canvas canvas,
    required Size size,
    required SelectionBounds? bounds,
    required double cellSize,
    required SelectionSettings settings,
    double dashOffset = 0.0,
  }) {
    if (bounds == null || bounds.isEmpty) return;

    final selectionRect = bounds.toRect(cellSize);

    // 1. Dimming overlay outside selection
    if (settings.showOverlay) {
      _paintDimmingOverlay(
        canvas: canvas,
        fullSize: size,
        selectionRect: selectionRect,
        opacity: settings.overlayOpacity,
      );
    }

    // 2. Dashed border (marching ants)
    paintMarchingAntsBorder(
      canvas: canvas,
      rect: selectionRect,
      color: settings.borderColor,
      strokeWidth: settings.borderWidth,
      dashLength: 4.0,
      dashOffset: dashOffset,
    );

    // 3. Resize handles
    paintResizeHandles(
      canvas: canvas,
      rect: selectionRect,
      color: settings.borderColor,
      handleSize: settings.handleSize,
    );
  }

  // ---------------------------------------------------------------------------
  // Dimming Overlay
  // ---------------------------------------------------------------------------

  /// Paints a semi-transparent overlay outside the selection rectangle.
  static void _paintDimmingOverlay({
    required Canvas canvas,
    required Size fullSize,
    required Rect selectionRect,
    required double opacity,
  }) {
    final overlayPaint = Paint()
      ..color = Color.fromRGBO(0, 0, 0, opacity)
      ..style = PaintingStyle.fill;

    final fullRect = Rect.fromLTWH(0, 0, fullSize.width, fullSize.height);

    // Save canvas state, clip out the selection, fill with overlay
    canvas.save();
    canvas.clipRect(selectionRect, clipOp: ClipOp.difference);
    canvas.drawRect(fullRect, overlayPaint);
    canvas.restore();
  }

  // ---------------------------------------------------------------------------
  // Marching Ants Border
  // ---------------------------------------------------------------------------

  /// Paints a dashed border around [rect].
  ///
  /// **Marching ants abstraction**: The [dashOffset] parameter shifts the dash
  /// pattern along the border perimeter. Passing a monotonically increasing
  /// offset from an animation ticker creates the classic marching ants effect.
  ///
  /// **Phase 5 Step 1**: [dashOffset] defaults to 0.0 (static pattern).
  static void paintMarchingAntsBorder({
    required Canvas canvas,
    required Rect rect,
    required Color color,
    double strokeWidth = 1.0,
    double dashLength = 4.0,
    double dashOffset = 0.0,
  }) {
    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // Draw white background border first for contrast
    final bgPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawRect(rect, bgPaint);

    // Draw dashed foreground border
    final path = _createDashedRectPath(
      rect: rect,
      dashLength: dashLength,
      dashOffset: dashOffset,
    );
    canvas.drawPath(path, borderPaint);
  }

  /// Creates a dashed path tracing the perimeter of [rect].
  static Path _createDashedRectPath({
    required Rect rect,
    required double dashLength,
    required double dashOffset,
  }) {
    final path = Path();
    final gapLength = dashLength;

    // Collect all four edges as line segments
    final edges = <_Edge>[
      _Edge(Offset(rect.left, rect.top), Offset(rect.right, rect.top)),
      _Edge(Offset(rect.right, rect.top), Offset(rect.right, rect.bottom)),
      _Edge(Offset(rect.right, rect.bottom), Offset(rect.left, rect.bottom)),
      _Edge(Offset(rect.left, rect.bottom), Offset(rect.left, rect.top)),
    ];

    var accumulatedLength = dashOffset % (dashLength + gapLength);

    for (final edge in edges) {
      final dx = edge.end.dx - edge.start.dx;
      final dy = edge.end.dy - edge.start.dy;
      final edgeLength =
          (dx * dx + dy * dy) > 0 ? (dx * dx + dy * dy).toDouble() : 0.0;
      final edgeLengthSqrt = edgeLength > 0 ? math.sqrt(edgeLength) : 0.0;

      if (edgeLengthSqrt == 0) continue;

      final unitDx = dx / edgeLengthSqrt;
      final unitDy = dy / edgeLengthSqrt;

      var travelled = 0.0;
      var isDash = accumulatedLength < dashLength;
      var remaining = isDash
          ? dashLength - accumulatedLength
          : gapLength - (accumulatedLength - dashLength);

      while (travelled < edgeLengthSqrt) {
        final segmentLength = (edgeLengthSqrt - travelled).clamp(0.0, remaining);

        if (isDash) {
          final startX = edge.start.dx + unitDx * travelled;
          final startY = edge.start.dy + unitDy * travelled;
          final endX = startX + unitDx * segmentLength;
          final endY = startY + unitDy * segmentLength;
          path.moveTo(startX, startY);
          path.lineTo(endX, endY);
        }

        travelled += segmentLength;
        remaining -= segmentLength;

        if (remaining <= 0) {
          isDash = !isDash;
          remaining = isDash ? dashLength : gapLength;
        }
      }

      accumulatedLength =
          (accumulatedLength + edgeLengthSqrt) % (dashLength + gapLength);
    }

    return path;
  }

  // ---------------------------------------------------------------------------
  // Resize Handles
  // ---------------------------------------------------------------------------

  /// Paints resize handles at 8 positions around the selection [rect].
  ///
  /// Handles are rendered at: four corners and four edge midpoints.
  static void paintResizeHandles({
    required Canvas canvas,
    required Rect rect,
    required Color color,
    double handleSize = 6.0,
  }) {
    final fillPaint = Paint()
      ..color = const Color(0xFFFFFFFF)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;


    // 8 handle positions: corners + edge midpoints
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
        width: handleSize,
        height: handleSize,
      );
      canvas.drawRect(handleRect, fillPaint);
      canvas.drawRect(handleRect, strokePaint);
    }
  }
}

/// Internal helper for edge line segments.
class _Edge {
  const _Edge(this.start, this.end);
  final Offset start;
  final Offset end;
}

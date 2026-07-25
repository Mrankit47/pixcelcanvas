import 'package:flutter/material.dart';

/// Coordinate Transformation Math Engine per Blueprint §8.1.
///
/// **Purpose**: Bi-directional coordinate mapping between Screen Viewport Offsets and Canvas (x, y) Pixel Grid Coordinates.
/// **Performance Considerations**: Direct floating-point matrix transformations.
class CoordinateTransformer {
  /// Transforms screen offset position into canvas pixel grid coordinate (x, y).
  static Point<int>? screenToCanvas({
    required Offset screenOffset,
    required Offset panOffset,
    required double zoomLevel,
    required double cellSize,
    required int canvasWidth,
    required int canvasHeight,
  }) {
    final relativeX = (screenOffset.dx - panOffset.dx) / (cellSize * zoomLevel);
    final relativeY = (screenOffset.dy - panOffset.dy) / (cellSize * zoomLevel);

    final x = relativeX.floor();
    final y = relativeY.floor();

    if (x < 0 || x >= canvasWidth || y < 0 || y >= canvasHeight) {
      return null;
    }

    return Point(x, y);
  }

  /// Transforms canvas pixel coordinate (x, y) into screen offset position.
  static Offset canvasToScreen({
    required int x,
    required int y,
    required Offset panOffset,
    required double zoomLevel,
    required double cellSize,
  }) {
    final dx = panOffset.dx + (x * cellSize * zoomLevel);
    final dy = panOffset.dy + (y * cellSize * zoomLevel);
    return Offset(dx, dy);
  }
}

/// Simple 2D integer Point representation.
class Point<T extends num> {
  /// Creates a [Point].
  const Point(this.x, this.y);

  /// X coordinate.
  final T x;

  /// Y coordinate.
  final T y;
}

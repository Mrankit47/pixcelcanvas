import 'dart:math' as math;

import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/selection_engine.dart';

/// Static utility for selection tool operations.
///
/// **Purpose**: Coordinate normalisation, hit testing, and handle-based resize
/// computation. Mirrors the [BrushTool] static utility pattern.
///
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class SelectionTool {
  /// Creates a normalised [SelectionBounds] from two corner points.
  ///
  /// Handles any drag direction — the result always has `left <= right`
  /// and `top <= bottom`.
  static SelectionBounds createRectangleSelection(
    int x0,
    int y0,
    int x1,
    int y1,
  ) {
    return SelectionBounds(
      left: math.min(x0, x1),
      top: math.min(y0, y1),
      right: math.max(x0, x1) + 1,
      bottom: math.max(y0, y1) + 1,
    );
  }

  /// Determines which [SelectionHitZone] the point `(x, y)` falls in
  /// relative to [bounds].
  ///
  /// Checks corner handles first (highest priority), then edge handles,
  /// then interior, and finally returns [SelectionHitZone.none].
  ///
  /// [handleSize] defines the tolerance in canvas pixels for handle detection.
  static SelectionHitZone hitTest(
    SelectionBounds bounds,
    int x,
    int y, {
    int handleSize = 1,
  }) {
    if (!bounds.isValid) return SelectionHitZone.none;

    // Corner handles
    if (_near(x, bounds.left, handleSize) &&
        _near(y, bounds.top, handleSize)) {
      return SelectionHitZone.topLeft;
    }
    if (_near(x, bounds.right - 1, handleSize) &&
        _near(y, bounds.top, handleSize)) {
      return SelectionHitZone.topRight;
    }
    if (_near(x, bounds.left, handleSize) &&
        _near(y, bounds.bottom - 1, handleSize)) {
      return SelectionHitZone.bottomLeft;
    }
    if (_near(x, bounds.right - 1, handleSize) &&
        _near(y, bounds.bottom - 1, handleSize)) {
      return SelectionHitZone.bottomRight;
    }

    // Edge handles
    if (_near(y, bounds.top, handleSize) &&
        x >= bounds.left &&
        x < bounds.right) {
      return SelectionHitZone.top;
    }
    if (_near(y, bounds.bottom - 1, handleSize) &&
        x >= bounds.left &&
        x < bounds.right) {
      return SelectionHitZone.bottom;
    }
    if (_near(x, bounds.left, handleSize) &&
        y >= bounds.top &&
        y < bounds.bottom) {
      return SelectionHitZone.left;
    }
    if (_near(x, bounds.right - 1, handleSize) &&
        y >= bounds.top &&
        y < bounds.bottom) {
      return SelectionHitZone.right;
    }

    // Interior
    if (bounds.contains(x, y)) {
      return SelectionHitZone.inside;
    }

    return SelectionHitZone.none;
  }

  /// Computes new [SelectionBounds] after dragging the specified [zone] handle
  /// to canvas pixel `(x, y)`.
  ///
  /// Returns the original [current] bounds if the resulting bounds would be
  /// invalid (zero or negative area).
  static SelectionBounds resizeFromHandle(
    SelectionBounds current,
    SelectionHitZone zone,
    int x,
    int y,
  ) {
    SelectionBounds newBounds;
    switch (zone) {
      case SelectionHitZone.topLeft:
        newBounds = current.copyWith(left: x, top: y);
      case SelectionHitZone.topRight:
        newBounds = current.copyWith(right: x + 1, top: y);
      case SelectionHitZone.bottomLeft:
        newBounds = current.copyWith(left: x, bottom: y + 1);
      case SelectionHitZone.bottomRight:
        newBounds = current.copyWith(right: x + 1, bottom: y + 1);
      case SelectionHitZone.top:
        newBounds = current.copyWith(top: y);
      case SelectionHitZone.bottom:
        newBounds = current.copyWith(bottom: y + 1);
      case SelectionHitZone.left:
        newBounds = current.copyWith(left: x);
      case SelectionHitZone.right:
        newBounds = current.copyWith(right: x + 1);
      case SelectionHitZone.inside:
      case SelectionHitZone.none:
        return current;
    }

    return newBounds.isValid ? newBounds : current;
  }

  /// Returns true if [value] is within [tolerance] of [target].
  static bool _near(int value, int target, int tolerance) {
    return (value - target).abs() <= tolerance;
  }
}

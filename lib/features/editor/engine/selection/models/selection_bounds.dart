import 'dart:math' as math;
import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Immutable bounding rectangle for a selection region in canvas pixel coordinates.
///
/// **Purpose**: Defines the axis-aligned bounding box of a selection using integer
/// pixel coordinates (left, top, right, bottom inclusive).
/// **Performance**: O(1) containment check, zero allocation on reads.
/// **Coordinate System**: Canvas pixel grid — (0,0) is top-left.
class SelectionBounds extends Equatable {
  /// Creates a [SelectionBounds].
  const SelectionBounds({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  /// Creates an empty (degenerate) [SelectionBounds].
  static const SelectionBounds empty = SelectionBounds(
    left: 0,
    top: 0,
    right: 0,
    bottom: 0,
  );

  /// Left edge X coordinate (inclusive).
  final int left;

  /// Top edge Y coordinate (inclusive).
  final int top;

  /// Right edge X coordinate (inclusive).
  final int right;

  /// Bottom edge Y coordinate (inclusive).
  final int bottom;

  /// Selection width in pixels.
  int get width => (right - left).abs() + 1;

  /// Selection height in pixels.
  int get height => (bottom - top).abs() + 1;

  /// True if the bounds describe a zero or negative area.
  bool get isEmpty => left >= right || top >= bottom;

  /// True if the bounds describe a positive area within valid range.
  bool get isValid => left < right && top < bottom;

  /// Center point of the selection bounds.
  math.Point<double> get center => math.Point(
        (left + right) / 2.0,
        (top + bottom) / 2.0,
      );

  /// Returns true if the canvas pixel coordinate `(x, y)` is inside this bounds.
  bool contains(int x, int y) {
    return x >= left && x < right && y >= top && y < bottom;
  }

  /// Returns true if this bounds intersects with [other].
  bool intersects(SelectionBounds other) {
    return left < other.right &&
        right > other.left &&
        top < other.bottom &&
        bottom > other.top;
  }

  /// Returns a new [SelectionBounds] clamped to the given canvas dimensions.
  ///
  /// Ensures bounds never extend outside `[0, canvasWidth)` × `[0, canvasHeight)`.
  SelectionBounds clampTo(int canvasWidth, int canvasHeight) {
    return SelectionBounds(
      left: left.clamp(0, canvasWidth),
      top: top.clamp(0, canvasHeight),
      right: right.clamp(0, canvasWidth),
      bottom: bottom.clamp(0, canvasHeight),
    );
  }

  /// Converts to a Flutter [Rect] for rendering, scaled by [cellSize].
  Rect toRect(double cellSize) {
    return Rect.fromLTRB(
      left * cellSize,
      top * cellSize,
      right * cellSize,
      bottom * cellSize,
    );
  }

  /// Returns a normalised copy where `left <= right` and `top <= bottom`.
  SelectionBounds normalised() {
    return SelectionBounds(
      left: math.min(left, right),
      top: math.min(top, bottom),
      right: math.max(left, right),
      bottom: math.max(top, bottom),
    );
  }

  /// Creates a copy of [SelectionBounds] with updated fields.
  SelectionBounds copyWith({
    int? left,
    int? top,
    int? right,
    int? bottom,
  }) =>
      SelectionBounds(
        left: left ?? this.left,
        top: top ?? this.top,
        right: right ?? this.right,
        bottom: bottom ?? this.bottom,
      );

  @override
  List<Object?> get props => [left, top, right, bottom];

  @override
  String toString() =>
      'SelectionBounds(left: $left, top: $top, right: $right, bottom: $bottom)';
}

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';

/// Bounding geometry container for an active transformation.
///
/// **Purpose**: Maintains location, size, and scale parameters of the transform bounding box.
/// **Architecture**: Pure Dart value object with `Equatable`.
class TransformBounds extends Equatable {
  /// Creates a [TransformBounds].
  const TransformBounds({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
    this.rotationDegrees = 0,
    this.isFlippedHorizontal = false,
    this.isFlippedVertical = false,
  });

  /// Left edge X coordinate (inclusive).
  final int left;

  /// Top edge Y coordinate (inclusive).
  final int top;

  /// Right edge X coordinate (inclusive).
  final int right;

  /// Bottom edge Y coordinate (inclusive).
  final int bottom;

  /// Rotation angle in degrees (0, 90, 180, 270).
  final int rotationDegrees;

  /// Horizontal flip status.
  final bool isFlippedHorizontal;

  /// Vertical flip status.
  final bool isFlippedVertical;

  /// Width of transform bounds in pixels.
  int get width => (right - left).abs();

  /// Height of transform bounds in pixels.
  int get height => (bottom - top).abs();

  /// Converts to [SelectionBounds].
  SelectionBounds toSelectionBounds() {
    return SelectionBounds(
      left: left,
      top: top,
      right: right,
      bottom: bottom,
    );
  }

  /// Converts to Flutter [Rect] scaled by [cellSize].
  Rect toRect(double cellSize) {
    return Rect.fromLTRB(
      left * cellSize,
      top * cellSize,
      right * cellSize,
      bottom * cellSize,
    );
  }

  /// Creates a copy of [TransformBounds] with updated fields.
  TransformBounds copyWith({
    int? left,
    int? top,
    int? right,
    int? bottom,
    int? rotationDegrees,
    bool? isFlippedHorizontal,
    bool? isFlippedVertical,
  }) =>
      TransformBounds(
        left: left ?? this.left,
        top: top ?? this.top,
        right: right ?? this.right,
        bottom: bottom ?? this.bottom,
        rotationDegrees: rotationDegrees ?? this.rotationDegrees,
        isFlippedHorizontal: isFlippedHorizontal ?? this.isFlippedHorizontal,
        isFlippedVertical: isFlippedVertical ?? this.isFlippedVertical,
      );

  @override
  List<Object?> get props => [
        left,
        top,
        right,
        bottom,
        rotationDegrees,
        isFlippedHorizontal,
        isFlippedVertical,
      ];
}

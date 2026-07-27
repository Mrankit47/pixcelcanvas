import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Immutable configuration settings for the Transform Engine.
///
/// **Purpose**: Controls handle sizing, colors, and snapping behavior.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class TransformSettings extends Equatable {
  /// Creates a [TransformSettings].
  const TransformSettings({
    this.borderColor = const Color(0xFF00CEC9),
    this.handleColor = const Color(0xFF00CEC9),
    this.borderWidth = 1.5,
    this.handleSize = 8.0,
    this.snapToGrid = true,
    this.showRotationHandle = true,
  });

  /// Transform bounding box stroke color.
  final Color borderColor;

  /// Transform handle color.
  final Color handleColor;

  /// Border stroke width in logical pixels.
  final double borderWidth;

  /// Size of resize/rotation handles in logical pixels.
  final double handleSize;

  /// Whether to snap transform bounds to integer pixel grid.
  final bool snapToGrid;

  /// Whether to show the rotation handle placeholder.
  final bool showRotationHandle;

  /// Creates a copy of [TransformSettings] with updated parameters.
  TransformSettings copyWith({
    Color? borderColor,
    Color? handleColor,
    double? borderWidth,
    double? handleSize,
    bool? snapToGrid,
    bool? showRotationHandle,
  }) =>
      TransformSettings(
        borderColor: borderColor ?? this.borderColor,
        handleColor: handleColor ?? this.handleColor,
        borderWidth: borderWidth ?? this.borderWidth,
        handleSize: handleSize ?? this.handleSize,
        snapToGrid: snapToGrid ?? this.snapToGrid,
        showRotationHandle: showRotationHandle ?? this.showRotationHandle,
      );

  @override
  List<Object?> get props => [
        borderColor,
        handleColor,
        borderWidth,
        handleSize,
        snapToGrid,
        showRotationHandle,
      ];
}

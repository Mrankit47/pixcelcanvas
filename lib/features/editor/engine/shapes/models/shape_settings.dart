import 'dart:ui';

import 'package:equatable/equatable.dart';

/// Supported shape types for the shape drawing engine.
enum ShapeType {
  /// Line segment between two points.
  line,

  /// Rectangle (outline or filled).
  rectangle,

  /// Circle (outline or filled).
  circle,

  /// Ellipse (outline or filled).
  ellipse,
}

/// Fill mode options for shape rendering.
enum ShapeFillMode {
  /// Border outline only.
  outline,

  /// Solid interior fill.
  filled,
}

/// Immutable configuration settings for the Shape Drawing Engine.
///
/// **Purpose**: Defines active shape type, fill mode, stroke width, and color.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class ShapeSettings extends Equatable {
  /// Creates a [ShapeSettings].
  const ShapeSettings({
    this.type = ShapeType.rectangle,
    this.fillMode = ShapeFillMode.outline,
    this.strokeWidth = 1,
    this.color = const Color(0xFF6C5CE7),
  });

  /// Active shape type.
  final ShapeType type;

  /// Active fill mode.
  final ShapeFillMode fillMode;

  /// Stroke width in pixels (default: 1).
  final int strokeWidth;

  /// Active shape drawing color.
  final Color color;

  /// Creates a copy of [ShapeSettings] with updated parameters.
  ShapeSettings copyWith({
    ShapeType? type,
    ShapeFillMode? fillMode,
    int? strokeWidth,
    Color? color,
  }) =>
      ShapeSettings(
        type: type ?? this.type,
        fillMode: fillMode ?? this.fillMode,
        strokeWidth: (strokeWidth ?? this.strokeWidth).clamp(1, 8),
        color: color ?? this.color,
      );

  @override
  List<Object?> get props => [type, fillMode, strokeWidth, color];
}

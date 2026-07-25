import 'package:equatable/equatable.dart';

/// Immutable configuration settings for pixel brush and pencil tools per Blueprint §8.1.
///
/// **Purpose**: Defines brush size (1 to 8 px) and future-ready properties (opacity, hardness, pressure, spacing).
/// **Performance Considerations**: Immutable value object for zero allocation mutation.
class BrushSettings extends Equatable {
  /// Creates a [BrushSettings].
  const BrushSettings({
    this.size = 1,
    this.opacity = 1.0,
    this.hardness = 1.0,
    this.pressureSensitive = false,
    this.spacing = 1.0,
  });

  /// Brush diameter in pixels (1 to 8).
  final int size;

  /// Brush opacity multiplier (0.0 to 1.0).
  final double opacity;

  /// Edge hardness (1.0 = hard pixel edge).
  final double hardness;

  /// Stylus pressure sensitivity toggle.
  final bool pressureSensitive;

  /// Distance spacing between interpolated stamps.
  final double spacing;

  /// Creates a copy of [BrushSettings] with updated parameters.
  BrushSettings copyWith({
    int? size,
    double? opacity,
    double? hardness,
    bool? pressureSensitive,
    double? spacing,
  }) =>
      BrushSettings(
        size: (size ?? this.size).clamp(1, 8),
        opacity: opacity ?? this.opacity,
        hardness: hardness ?? this.hardness,
        pressureSensitive: pressureSensitive ?? this.pressureSensitive,
        spacing: spacing ?? this.spacing,
      );

  @override
  List<Object?> get props => [
        size,
        opacity,
        hardness,
        pressureSensitive,
        spacing,
      ];
}

import 'package:equatable/equatable.dart';

/// Immutable configuration settings for pixel eraser tool per Blueprint §8.1.
///
/// **Purpose**: Defines eraser size (1 to 8 px) and future-ready properties (opacity, softness, pressure).
/// **Performance Considerations**: Immutable value object for zero allocation mutation.
class EraserSettings extends Equatable {
  /// Creates an [EraserSettings].
  const EraserSettings({
    this.size = 2,
    this.opacity = 1.0,
    this.softness = 0.0,
    this.pressureSensitive = false,
  });

  /// Eraser diameter in pixels (1 to 8).
  final int size;

  /// Eraser opacity multiplier.
  final double opacity;

  /// Edge softness (0.0 = hard pixel eraser).
  final double softness;

  /// Pressure sensitivity flag.
  final bool pressureSensitive;

  /// Creates a copy of [EraserSettings] with updated parameters.
  EraserSettings copyWith({
    int? size,
    double? opacity,
    double? softness,
    bool? pressureSensitive,
  }) =>
      EraserSettings(
        size: (size ?? this.size).clamp(1, 8),
        opacity: opacity ?? this.opacity,
        softness: softness ?? this.softness,
        pressureSensitive: pressureSensitive ?? this.pressureSensitive,
      );

  @override
  List<Object?> get props => [
        size,
        opacity,
        softness,
        pressureSensitive,
      ];
}

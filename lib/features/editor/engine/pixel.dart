import 'package:flutter/material.dart';

/// Represents a single pixel cell within the canvas matrix per Blueprint §8.1.
///
/// **Purpose**: Immutable pixel data container specifying color, opacity, visibility, and layer index.
/// **Performance Considerations**: Ultra-lightweight value object designed for fast array allocation up to 512x512 grids.
class Pixel {
  /// Creates a [Pixel].
  const Pixel({
    required this.color,
    this.opacity = 1.0,
    this.isVisible = true,
    this.layerIndex = 0,
  });

  /// Fully transparent empty pixel.
  static const Pixel empty = Pixel(
    color: Colors.transparent,
    opacity: 0.0,
    isVisible: false,
    layerIndex: 0,
  );

  /// Pixel color.
  final Color color;

  /// Opacity multiplier (0.0 to 1.0).
  final double opacity;

  /// Visibility toggle.
  final bool isVisible;

  /// Associated layer index.
  final int layerIndex;

  /// Returns true if pixel is transparent or invisible.
  bool get isEmpty => color.alpha == 0 || opacity == 0.0 || !isVisible;

  /// Creates a copy of [Pixel] with updated fields.
  Pixel copyWith({
    Color? color,
    double? opacity,
    bool? isVisible,
    int? layerIndex,
  }) =>
      Pixel(
        color: color ?? this.color,
        opacity: opacity ?? this.opacity,
        isVisible: isVisible ?? this.isVisible,
        layerIndex: layerIndex ?? this.layerIndex,
      );
}

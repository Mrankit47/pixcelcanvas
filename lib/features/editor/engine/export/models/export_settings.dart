import 'package:equatable/equatable.dart';

/// Supported export format types per Blueprint §8.1.
enum ExportFormat {
  /// Standard PNG with transparency support.
  png,

  /// Sprite sheet (future).
  spriteSheet,

  /// Native PixelCanvas project file (future).
  pxc,

  /// Animated GIF (future).
  gif,

  /// Animated PNG (future).
  apng,
}

/// Immutable export configuration settings per Blueprint §8.1.
///
/// **Purpose**: Defines export parameters including format, scale, and transparency.
/// **Future Extensions**: Sprite sheet grid size, animation frame range, compression level.
class ExportSettings extends Equatable {
  /// Creates an [ExportSettings].
  const ExportSettings({
    this.format = ExportFormat.png,
    this.scale = 1,
    this.preserveTransparency = true,
    this.includeHiddenLayers = false,
  });

  /// Target export format.
  final ExportFormat format;

  /// Integer scale multiplier (1x = native pixel size, 2x = doubled, etc.).
  final int scale;

  /// Whether to preserve transparent pixels in the output.
  final bool preserveTransparency;

  /// Whether to include hidden layers in the flattened output.
  final bool includeHiddenLayers;

  /// Creates a copy with updated fields.
  ExportSettings copyWith({
    ExportFormat? format,
    int? scale,
    bool? preserveTransparency,
    bool? includeHiddenLayers,
  }) =>
      ExportSettings(
        format: format ?? this.format,
        scale: (scale ?? this.scale).clamp(1, 16),
        preserveTransparency: preserveTransparency ?? this.preserveTransparency,
        includeHiddenLayers: includeHiddenLayers ?? this.includeHiddenLayers,
      );

  @override
  List<Object?> get props => [format, scale, preserveTransparency, includeHiddenLayers];
}

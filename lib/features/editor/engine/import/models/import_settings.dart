import 'package:equatable/equatable.dart';

/// Supported image formats for the Import Engine.
enum ImageFormat {
  /// Portable Network Graphics (active).
  png,

  /// Joint Photographic Experts Group (future placeholder).
  jpeg,

  /// Web Picture format (future placeholder).
  webp,

  /// Static GIF format (future placeholder).
  gif,
}

/// Scaling mode options for image import.
enum ImportScaleMode {
  /// Keep original image dimensions.
  original,

  /// Scale to fit within canvas dimensions preserving aspect ratio.
  fitCanvas,

  /// Scale to fill canvas dimensions preserving aspect ratio (cropping overflow).
  fillCanvas,

  /// Stretch to exact canvas width and height.
  stretch,

  /// Custom target width and height specified by user.
  custom,
}

/// Palette reduction options for quantization.
enum ImportPaletteMode {
  /// Keep all original colors without reduction.
  unlimited,

  /// Quantize to 16 colors.
  c16,

  /// Quantize to 32 colors.
  c32,

  /// Quantize to 64 colors.
  c64,

  /// Quantize to 128 colors.
  c128,

  /// Quantize to 256 colors.
  c256,

  /// Custom palette list (future placeholder).
  customPalette,
}

/// Dithering algorithm options.
enum ImportDitherMode {
  /// No dithering.
  none,

  /// Floyd–Steinberg error diffusion dithering.
  floydSteinberg,
}

/// Destination layer target for the imported image.
enum ImportDestination {
  /// Create a new layer for the imported image.
  newLayer,

  /// Replace the contents of the currently active layer.
  replaceActive,

  /// Reset canvas grid dimensions to match imported image and clear layers.
  newCanvas,
}

/// Immutable configuration settings for the PNG Import Engine.
///
/// **Purpose**: Defines scaling mode, palette reduction, dithering, destination, and custom dimensions.
/// **Architecture**: Pure Dart value object with `copyWith` and `Equatable`.
class ImportSettings extends Equatable {
  /// Creates an [ImportSettings].
  const ImportSettings({
    this.format = ImageFormat.png,
    this.scaleMode = ImportScaleMode.fitCanvas,
    this.paletteMode = ImportPaletteMode.unlimited,
    this.ditherMode = ImportDitherMode.none,
    this.destination = ImportDestination.newLayer,
    this.customWidth,
    this.customHeight,
    this.preserveTransparency = true,
  });

  /// Target image format.
  final ImageFormat format;

  /// Active scaling mode.
  final ImportScaleMode scaleMode;

  /// Active palette reduction mode.
  final ImportPaletteMode paletteMode;

  /// Active dithering algorithm mode.
  final ImportDitherMode ditherMode;

  /// Active destination layer strategy.
  final ImportDestination destination;

  /// Custom width in pixels (used when [scaleMode] is `custom`).
  final int? customWidth;

  /// Custom height in pixels (used when [scaleMode] is `custom`).
  final int? customHeight;

  /// Whether to preserve the RGBA alpha transparency.
  final bool preserveTransparency;

  /// Creates a copy of [ImportSettings] with updated parameters.
  ImportSettings copyWith({
    ImageFormat? format,
    ImportScaleMode? scaleMode,
    ImportPaletteMode? paletteMode,
    ImportDitherMode? ditherMode,
    ImportDestination? destination,
    int? customWidth,
    int? customHeight,
    bool? preserveTransparency,
  }) =>
      ImportSettings(
        format: format ?? this.format,
        scaleMode: scaleMode ?? this.scaleMode,
        paletteMode: paletteMode ?? this.paletteMode,
        ditherMode: ditherMode ?? this.ditherMode,
        destination: destination ?? this.destination,
        customWidth: customWidth ?? this.customWidth,
        customHeight: customHeight ?? this.customHeight,
        preserveTransparency:
            preserveTransparency ?? this.preserveTransparency,
      );

  @override
  List<Object?> get props => [
        format,
        scaleMode,
        paletteMode,
        ditherMode,
        destination,
        customWidth,
        customHeight,
        preserveTransparency,
      ];
}

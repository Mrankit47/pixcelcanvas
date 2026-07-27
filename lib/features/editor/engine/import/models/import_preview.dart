import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Active preview container for an in-progress PNG import session.
///
/// **Purpose**: Tracks original and target dimensions, settings, estimated memory,
/// and converted pixel buffer before committing to a canvas layer.
///
/// **Architecture**: Pure Dart container — no framework dependencies.
class ImportPreview {
  /// Creates an [ImportPreview].
  ImportPreview({
    required this.sourceWidth,
    required this.sourceHeight,
    required this.targetWidth,
    required this.targetHeight,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.settings,
    required this.pixels,
    required this.estimatedMemoryBytes,
    this.isCorrupted = false,
    this.errorMessage,
    this.isVisible = true,
  });

  /// Original source image width in pixels.
  final int sourceWidth;

  /// Original source image height in pixels.
  final int sourceHeight;

  /// Target scaled width in pixels.
  final int targetWidth;

  /// Target scaled height in pixels.
  final int targetHeight;

  /// Active canvas width in pixels.
  final int canvasWidth;

  /// Active canvas height in pixels.
  final int canvasHeight;

  /// Import configuration settings used to generate this preview.
  final ImportSettings settings;

  /// Converted and quantized 1D pixel buffer (size = [targetWidth] × [targetHeight]).
  final List<Pixel> pixels;

  /// Estimated memory footprint in bytes.
  final int estimatedMemoryBytes;

  /// Flag set to true if the source file was corrupted or unreadable.
  final bool isCorrupted;

  /// Diagnostic error message if [isCorrupted] is true.
  final String? errorMessage;

  /// Preview visibility flag.
  bool isVisible;

  /// Returns the pixel at local coordinates `(x, y)` within the preview buffer.
  Pixel getPixel(int x, int y) {
    if (x < 0 || x >= targetWidth || y < 0 || y >= targetHeight) {
      return Pixel.empty;
    }
    return pixels[(y * targetWidth) + x];
  }
}

import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Result record container for pixel array transformation functions.
class TransformResult {
  /// Creates a [TransformResult].
  const TransformResult({
    required this.pixels,
    required this.width,
    required this.height,
  });

  /// Transformed pixel list.
  final List<Pixel> pixels;

  /// Transformed width in pixels.
  final int width;

  /// Transformed height in pixels.
  final int height;
}

/// Pure static pixel manipulation algorithms for the Transform Engine.
///
/// **Architecture Rules**: Integer coordinate math, Nearest-Neighbor sampling only,
/// zero anti-aliasing, zero smoothing. Pure Dart — no framework dependencies.
class TransformTool {
  /// Rotates pixel buffer 90 degrees Clockwise.
  static TransformResult rotate90CW(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newWidth = height;
    final newHeight = width;
    final newPixels = List<Pixel>.filled(newWidth * newHeight, Pixel.empty);

    for (var ny = 0; ny < newHeight; ny++) {
      for (var nx = 0; nx < newWidth; nx++) {
        final ox = ny;
        final oy = (height - 1) - nx;
        newPixels[(ny * newWidth) + nx] = pixels[(oy * width) + ox];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: newWidth,
      height: newHeight,
    );
  }

  /// Rotates pixel buffer 90 degrees Counter-Clockwise.
  static TransformResult rotate90CCW(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newWidth = height;
    final newHeight = width;
    final newPixels = List<Pixel>.filled(newWidth * newHeight, Pixel.empty);

    for (var ny = 0; ny < newHeight; ny++) {
      for (var nx = 0; nx < newWidth; nx++) {
        final ox = (width - 1) - ny;
        final oy = nx;
        newPixels[(ny * newWidth) + nx] = pixels[(oy * width) + ox];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: newWidth,
      height: newHeight,
    );
  }

  /// Rotates pixel buffer 180 degrees.
  static TransformResult rotate180(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newPixels = List<Pixel>.filled(width * height, Pixel.empty);

    for (var ny = 0; ny < height; ny++) {
      for (var nx = 0; nx < width; nx++) {
        final ox = (width - 1) - nx;
        final oy = (height - 1) - ny;
        newPixels[(ny * width) + nx] = pixels[(oy * width) + ox];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: width,
      height: height,
    );
  }

  /// Flips pixel buffer horizontally (left-right mirror).
  static TransformResult flipHorizontal(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newPixels = List<Pixel>.filled(width * height, Pixel.empty);

    for (var ny = 0; ny < height; ny++) {
      for (var nx = 0; nx < width; nx++) {
        final ox = (width - 1) - nx;
        newPixels[(ny * width) + nx] = pixels[(ny * width) + ox];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: width,
      height: height,
    );
  }

  /// Flips pixel buffer vertically (top-bottom mirror).
  static TransformResult flipVertical(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newPixels = List<Pixel>.filled(width * height, Pixel.empty);

    for (var ny = 0; ny < height; ny++) {
      for (var nx = 0; nx < width; nx++) {
        final oy = (height - 1) - ny;
        newPixels[(ny * width) + nx] = pixels[(oy * width) + nx];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: width,
      height: height,
    );
  }

  /// Mirrors horizontal left half to right half.
  static TransformResult mirrorHorizontal(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newPixels = List<Pixel>.filled(width * height, Pixel.empty);

    for (var ny = 0; ny < height; ny++) {
      for (var nx = 0; nx < width; nx++) {
        final ox = nx < (width / 2) ? nx : (width - 1 - nx);
        newPixels[(ny * width) + nx] = pixels[(ny * width) + ox];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: width,
      height: height,
    );
  }

  /// Mirrors vertical top half to bottom half.
  static TransformResult mirrorVertical(
    List<Pixel> pixels,
    int width,
    int height,
  ) {
    final newPixels = List<Pixel>.filled(width * height, Pixel.empty);

    for (var ny = 0; ny < height; ny++) {
      for (var nx = 0; nx < width; nx++) {
        final oy = ny < (height / 2) ? ny : (height - 1 - ny);
        newPixels[(ny * width) + nx] = pixels[(oy * width) + nx];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: width,
      height: height,
    );
  }

  /// Scales pixel buffer to [newWidth] × [newHeight] using Nearest-Neighbor sampling.
  static TransformResult scaleNearestNeighbor(
    List<Pixel> pixels,
    int width,
    int height,
    int newWidth,
    int newHeight,
  ) {
    final targetW = newWidth.clamp(1, 4096);
    final targetH = newHeight.clamp(1, 4096);
    final newPixels = List<Pixel>.filled(targetW * targetH, Pixel.empty);

    for (var ny = 0; ny < targetH; ny++) {
      for (var nx = 0; nx < targetW; nx++) {
        final ox = (nx * width) ~/ targetW;
        final oy = (ny * height) ~/ targetH;
        final clampedOx = ox.clamp(0, width - 1);
        final clampedOy = oy.clamp(0, height - 1);
        newPixels[(ny * targetW) + nx] = pixels[(clampedOy * width) + clampedOx];
      }
    }

    return TransformResult(
      pixels: newPixels,
      width: targetW,
      height: targetH,
    );
  }
}

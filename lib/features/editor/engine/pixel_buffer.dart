import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Dense 1D pixel memory array representing a 2D canvas grid per Blueprint §8.1.
///
/// **Purpose**: High-performance contiguous pixel storage backing a single layer.
/// **Performance Considerations**: Fast `O(1)` index calculation `(y * width) + x`. Supports up to 512×512 (262,144 cells).
class PixelBuffer {
  /// Creates a [PixelBuffer] with specified dimensions.
  PixelBuffer({
    required this.width,
    required this.height,
  }) : _pixels = List<Pixel>.filled(width * height, Pixel.empty);

  /// Canvas width in pixels.
  final int width;

  /// Canvas height in pixels.
  final int height;

  /// Contiguous 1D pixel list.
  final List<Pixel> _pixels;

  /// Exposes read-only pixel list.
  List<Pixel> get pixels => List<Pixel>.from(_pixels);

  /// Reads pixel at (x, y).
  Pixel getPixel(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return Pixel.empty;
    return _pixels[(y * width) + x];
  }

  /// Writes pixel at (x, y).
  void setPixel(int x, int y, Pixel pixel) {
    if (x < 0 || x >= width || y < 0 || y >= height) return;
    _pixels[(y * width) + x] = pixel;
  }

  /// Clears buffer to transparent empty pixels.
  void clear() {
    _pixels.fillRange(0, _pixels.length, Pixel.empty);
  }

  /// Deep copy of PixelBuffer.
  PixelBuffer clone() {
    final copy = PixelBuffer(width: width, height: height);
    for (var i = 0; i < _pixels.length; i++) {
      copy._pixels[i] = _pixels[i];
    }
    return copy;
  }
}

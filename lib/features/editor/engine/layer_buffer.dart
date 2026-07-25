import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_buffer.dart';

/// Single layer buffer wrapping [PixelBuffer] per Blueprint §8.1.
class LayerBuffer {
  /// Creates a [LayerBuffer].
  LayerBuffer({
    required this.id,
    required this.name,
    required int width,
    required int height,
    this.isVisible = true,
    this.isLocked = false,
    this.opacity = 1.0,
    this.index = 0,
  }) : buffer = PixelBuffer(width: width, height: height);

  /// Layer unique identifier.
  final String id;

  /// Layer display name.
  String name;

  /// Visibility flag.
  bool isVisible;

  /// Lock flag.
  bool isLocked;

  /// Layer opacity.
  double opacity;

  /// Stack order index.
  int index;

  /// Underlying pixel buffer.
  final PixelBuffer buffer;

  /// Reads pixel at (x, y).
  Pixel getPixel(int x, int y) => buffer.getPixel(x, y);

  /// Writes pixel at (x, y).
  void setPixel(int x, int y, Pixel pixel) => buffer.setPixel(x, y, pixel);

  /// Clears layer buffer.
  void clear() => buffer.clear();
}

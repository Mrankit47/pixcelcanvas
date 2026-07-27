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

  /// Exposes width.
  int get width => buffer.width;

  /// Exposes height.
  int get height => buffer.height;

  /// Exposes pixels list.
  List<Pixel> get pixels => buffer.pixels;

  /// Reads pixel at (x, y).
  Pixel getPixel(int x, int y) => buffer.getPixel(x, y);

  /// Writes pixel at (x, y).
  void setPixel(int x, int y, Pixel pixel) => buffer.setPixel(x, y, pixel);

  /// Clears layer buffer.
  void clear() => buffer.clear();

  /// Deep copy of LayerBuffer.
  LayerBuffer clone() {
    final copy = LayerBuffer(
      id: id,
      name: name,
      width: buffer.width,
      height: buffer.height,
      isVisible: isVisible,
      isLocked: isLocked,
      opacity: opacity,
      index: index,
    );
    for (var y = 0; y < buffer.height; y++) {
      for (var x = 0; x < buffer.width; x++) {
        copy.setPixel(x, y, getPixel(x, y));
      }
    }
    return copy;
  }
}

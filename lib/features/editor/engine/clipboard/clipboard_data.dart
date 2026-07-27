import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';

/// Immutable snapshot of selected pixels for clipboard operations.
///
/// **Purpose**: Stores a rectangular region of pixels extracted from a layer
/// for copy/cut/paste operations. Only the pixels within the selection bounds
/// are captured — no full-canvas copies.
///
/// **Memory Layout**: Row-major 1D `List<Pixel>` of size [width] × [height].
/// Transparent pixels pad the rectangle where the selection contained empty cells.
///
/// **Architecture**: Pure Dart value object — no framework dependencies.
class ClipboardData {
  /// Creates a [ClipboardData].
  const ClipboardData({
    required this.pixels,
    required this.width,
    required this.height,
    required this.sourceBounds,
    required this.sourceLayerIndex,
    required this.canvasWidth,
    required this.canvasHeight,
    required this.timestamp,
  });

  /// Pixel buffer in row-major order (size = [width] × [height]).
  final List<Pixel> pixels;

  /// Width of the captured region in pixels.
  final int width;

  /// Height of the captured region in pixels.
  final int height;

  /// Original selection bounds on the source canvas.
  final SelectionBounds sourceBounds;

  /// Layer index the pixels were captured from.
  final int sourceLayerIndex;

  /// Source canvas width (for validation on paste).
  final int canvasWidth;

  /// Source canvas height (for validation on paste).
  final int canvasHeight;

  /// Timestamp of when the clipboard data was created.
  final DateTime timestamp;

  /// Returns the pixel at local coordinates `(x, y)` within the captured region.
  ///
  /// Returns [Pixel.empty] if out of bounds.
  Pixel getPixel(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return Pixel.empty;
    return pixels[(y * width) + x];
  }

  /// True if the clipboard contains no meaningful pixels.
  bool get isEmpty => pixels.isEmpty || (width <= 0) || (height <= 0);

  /// True if the clipboard contains pixel data.
  bool get isNotEmpty => !isEmpty;

  /// Total number of non-empty pixels in the clipboard.
  int get nonEmptyPixelCount {
    var count = 0;
    for (final p in pixels) {
      if (!p.isEmpty) count++;
    }
    return count;
  }
}

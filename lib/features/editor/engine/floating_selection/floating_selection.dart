import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';

/// Temporary floating pixel buffer during a move or paste operation.
///
/// **Purpose**: Holds pixels that have been "lifted" from a layer and are
/// being repositioned by the user. Pixels are NOT committed to the canvas
/// until [commitMoveSelection] is called on the engine.
///
/// **Lifecycle**:
/// 1. Created by `beginMoveSelection()` or `pasteSelection()`
/// 2. Updated via `translate()` during drag
/// 3. Committed via `commitMoveSelection()` → pixels written to layer
/// 4. Or cancelled via `cancelMoveSelection()` → pixels restored to source
///
/// **Architecture**: Pure Dart — no framework dependencies.
/// Stores a compact pixel buffer only for the selected region.
class FloatingSelection {
  /// Creates a [FloatingSelection].
  FloatingSelection({
    required this.pixels,
    required this.width,
    required this.height,
    required this.originalBounds,
    required this.sourceLayerIndex,
    this.offsetX = 0,
    this.offsetY = 0,
    this.isVisible = true,
  });

  /// Pixel buffer in row-major order (size = [width] × [height]).
  final List<Pixel> pixels;

  /// Width of the floating region in pixels.
  final int width;

  /// Height of the floating region in pixels.
  final int height;

  /// Original bounds where the pixels were extracted from.
  final SelectionBounds originalBounds;

  /// Source layer index.
  final int sourceLayerIndex;

  /// Current horizontal drag offset from original position (in canvas pixels).
  int offsetX;

  /// Current vertical drag offset from original position (in canvas pixels).
  int offsetY;

  /// Whether the floating selection is visible for rendering.
  bool isVisible;

  /// Returns the current bounds of the floating selection, translated by offset.
  SelectionBounds get currentBounds => SelectionBounds(
        left: originalBounds.left + offsetX,
        top: originalBounds.top + offsetY,
        right: originalBounds.right + offsetX,
        bottom: originalBounds.bottom + offsetY,
      );

  /// Returns the pixel at local coordinates `(x, y)` within the floating buffer.
  ///
  /// Returns [Pixel.empty] if out of bounds.
  Pixel getPixel(int x, int y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return Pixel.empty;
    return pixels[(y * width) + x];
  }

  /// Translates the floating selection by `(dx, dy)` canvas pixels.
  ///
  /// Pixel-perfect movement — no interpolation, no sub-pixel offsets.
  void translate(int dx, int dy) {
    offsetX += dx;
    offsetY += dy;
  }

  /// Resets the offset to zero (returns to original position).
  void resetOffset() {
    offsetX = 0;
    offsetY = 0;
  }

  /// True if the floating selection has any non-empty pixels.
  bool get hasPixels {
    for (final p in pixels) {
      if (!p.isEmpty) return true;
    }
    return false;
  }
}

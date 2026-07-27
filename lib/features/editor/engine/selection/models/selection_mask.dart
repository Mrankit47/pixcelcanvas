import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';

/// Future-ready pixel-level selection mask for non-rectangular selections.
///
/// **Phase 5 Step 1**: This is a placeholder class. For rectangle selections,
/// containment is delegated directly to [SelectionRegion.containsPoint] which
/// uses an O(1) bounds check.
///
/// **Future expansion**: When freehand, magic wand, or polygon selections are
/// implemented, this class will maintain a bitmap mask (`List<bool>` or
/// `Uint8List`) of dimensions [width] × [height] where each cell indicates
/// whether that pixel is inside the selection.
///
/// **Performance target**: Up to 4096×4096 canvases (16M booleans ≈ 16 MB
/// bitmap or 2 MB packed bits).
class SelectionMask {
  /// Creates a [SelectionMask] for the given canvas dimensions.
  SelectionMask({
    required this.width,
    required this.height,
  });

  /// Canvas width in pixels.
  final int width;

  /// Canvas height in pixels.
  final int height;

  /// The selection region this mask represents.
  SelectionRegion? _region;

  /// Binds this mask to a [SelectionRegion].
  ///
  /// For rectangle selections, no bitmap is allocated — containment is
  /// delegated to [SelectionRegion.containsPoint].
  void bindToRegion(SelectionRegion? region) {
    _region = region;
  }

  /// Returns true if the pixel at `(x, y)` is inside the selection.
  ///
  /// Returns false if no region is bound or coordinates are out of bounds.
  bool isSelected(int x, int y) {
    if (_region == null) return false;
    if (x < 0 || x >= width || y < 0 || y >= height) return false;
    return _region!.containsPoint(x, y);
  }

  /// Clears the mask by unbinding the region.
  void clear() {
    _region = null;
  }

  /// True if a region is currently bound to this mask.
  bool get hasMask => _region != null;
}

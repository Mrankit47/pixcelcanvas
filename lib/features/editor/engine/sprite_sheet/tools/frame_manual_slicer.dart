import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_metadata.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';

/// Manual rectangular selection slicing algorithm for custom frame creation.
class FrameManualSlicer {
  /// Extracts pixels within [bounds] from [canvasPixels] buffer into a new [SpriteFrame].
  static SpriteFrame sliceManual({
    required List<Pixel> canvasPixels,
    required int canvasWidth,
    required int canvasHeight,
    required SelectionBounds bounds,
    required String frameId,
    required String frameName,
  }) {
    final width = (bounds.right - bounds.left).abs();
    final height = (bounds.bottom - bounds.top).abs();

    final targetW = width > 0 ? width : 1;
    final targetH = height > 0 ? height : 1;

    final framePixels = List<Pixel>.filled(targetW * targetH, Pixel.empty);

    for (var localY = 0; localY < targetH; localY++) {
      for (var localX = 0; localX < targetW; localX++) {
        final srcX = bounds.left + localX;
        final srcY = bounds.top + localY;
        if (srcX >= 0 && srcX < canvasWidth && srcY >= 0 && srcY < canvasHeight) {
          framePixels[(localY * targetW) + localX] =
              canvasPixels[(srcY * canvasWidth) + srcX];
        }
      }
    }

    final metadata = FrameMetadata(
      id: frameId,
      name: frameName,
      width: targetW,
      height: targetH,
    );

    return SpriteFrame(
      metadata: metadata,
      bounds: bounds,
      pixels: framePixels,
    );
  }
}

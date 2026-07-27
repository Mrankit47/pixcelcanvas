import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/frame_metadata.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_frame.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';

/// Automatic grid slicing algorithm for sprite sheets.
///
/// **Algorithm**: Iterates grid cells step-by-step using cell dimensions, padding, margins, and offsets.
/// **Performance**: Efficient 1D buffer extraction without unnecessary pixel copies.
class FrameGridSlicer {
  /// Slices [sheetPixels] buffer into a list of [SpriteFrame] objects according to [settings].
  static List<SpriteFrame> sliceGrid({
    required List<Pixel> sheetPixels,
    required int sheetWidth,
    required int sheetHeight,
    required SpriteSheetSettings settings,
  }) {
    final frames = <SpriteFrame>[];

    final cellW = settings.cellWidth;
    final cellH = settings.cellHeight;
    final padX = settings.paddingX;
    final padY = settings.paddingY;
    final startX = settings.offsetX + settings.marginX;
    final startY = settings.offsetY + settings.marginY;

    var frameIndex = 0;

    for (var y = startY; y + cellH <= sheetHeight; y += cellH + padY) {
      for (var x = startX; x + cellW <= sheetWidth; x += cellW + padX) {
        final framePixels = List<Pixel>.filled(cellW * cellH, Pixel.empty);

        for (var localY = 0; localY < cellH; localY++) {
          for (var localX = 0; localX < cellW; localX++) {
            final srcX = x + localX;
            final srcY = y + localY;
            if (srcX >= 0 && srcX < sheetWidth && srcY >= 0 && srcY < sheetHeight) {
              framePixels[(localY * cellW) + localX] =
                  sheetPixels[(srcY * sheetWidth) + srcX];
            }
          }
        }

        final bounds = SelectionBounds(
          left: x,
          top: y,
          right: x + cellW,
          bottom: y + cellH,
        );

        final metadata = FrameMetadata(
          id: 'frame_$frameIndex',
          name: 'Frame_$frameIndex',
          width: cellW,
          height: cellH,
          originX: 0,
          originY: 0,
        );

        frames.add(SpriteFrame(
          metadata: metadata,
          bounds: bounds,
          pixels: framePixels,
        ));

        frameIndex++;
      }
    }

    return frames;
  }
}

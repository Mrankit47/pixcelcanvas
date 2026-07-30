import 'dart:ui';

import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';
import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';

/// Static renderer for committing shape pixel points to a [LayerBuffer].
///
/// **Purpose**: Plots shape points to a layer buffer, enforcing selection clipping
/// and returning a list of [PixelDelta] records for undo/redo commands.
///
/// **Architecture**: Pure static methods — no state, no framework dependencies.
class ShapeRenderer {
  /// Plots a list of shape [points] onto [layer] with optional [selectionRegion] clipping.
  ///
  /// Returns a `List<PixelDelta>` containing all modified pixel state changes.
  static List<PixelDelta> drawShapePoints({
    required LayerBuffer layer,
    required List<Point<int>> points,
    required Color color,
    required int layerIndex,
    SelectionRegion? selectionRegion,
  }) {
    final deltas = <PixelDelta>[];
    final targetPixel = Pixel(color: color);

    for (final pt in points) {
      final x = pt.x;
      final y = pt.y;

      // Skip out-of-bounds pixels
      if (x < 0 || x >= layer.buffer.width || y < 0 || y >= layer.buffer.height) {
        continue;
      }

      // Selection clipping: if selection exists, skip points outside selection
      if (selectionRegion != null && selectionRegion.isValid) {
        if (!selectionRegion.containsPoint(x, y)) {
          continue;
        }
      }

      final oldPixel = layer.getPixel(x, y);

      // Only plot and record delta if color actually changes
      if (oldPixel.color.value != color.value || oldPixel.opacity != 1.0) {
        deltas.add(PixelDelta(
          x: x,
          y: y,
          oldPixel: oldPixel,
          newPixel: targetPixel,
          layerIndex: layerIndex,
        ));
        layer.setPixel(x, y, targetPixel);
      }
    }

    return deltas;
  }
}

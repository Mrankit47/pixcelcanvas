import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Reversible history command for a completed Ellipse shape.
class EllipseCommand extends HistoryCommand {
  /// Creates an [EllipseCommand].
  EllipseCommand({
    required List<PixelDelta> deltas,
  }) : _deltas = deltas;

  final List<PixelDelta> _deltas;

  @override
  String get name => 'Draw Ellipse';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    for (final delta in _deltas.reversed) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    for (final delta in _deltas) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.newPixel);
      }
    }
    engine.compositeVisibleLayers();
  }
}

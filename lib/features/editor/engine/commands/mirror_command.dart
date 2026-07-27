import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Reversible history command for Mirror operations (Horizontal or Vertical half-mirror).
class MirrorCommand extends HistoryCommand {
  /// Creates a [MirrorCommand].
  MirrorCommand({
    required List<PixelDelta> sourceDeltas,
    required List<PixelDelta> destDeltas,
    required this.isHorizontal,
  })  : _sourceDeltas = sourceDeltas,
        _destDeltas = destDeltas;

  final List<PixelDelta> _sourceDeltas;
  final List<PixelDelta> _destDeltas;

  /// True if horizontal mirror, false if vertical mirror.
  final bool isHorizontal;

  @override
  String get name => isHorizontal ? 'Mirror Horizontal' : 'Mirror Vertical';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    for (final delta in _destDeltas.reversed) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }
    for (final delta in _sourceDeltas.reversed) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    for (final delta in _sourceDeltas) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.newPixel);
      }
    }
    for (final delta in _destDeltas) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.newPixel);
      }
    }
    engine.compositeVisibleLayers();
  }
}

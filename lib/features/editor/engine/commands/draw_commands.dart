import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Command batch grouping multiple pixel deltas from a single continuous stroke per Blueprint §8.1.
class CommandBatch extends HistoryCommand {
  /// Creates a [CommandBatch].
  CommandBatch(this.batchName);

  /// Batch name (e.g., "Brush Stroke", "Eraser Stroke", "Bucket Fill").
  final String batchName;

  /// List of recorded pixel deltas.
  final List<PixelDelta> deltas = [];

  @override
  String get name => batchName;

  /// Adds a pixel delta to batch.
  void addDelta(PixelDelta delta) {
    deltas.add(delta);
  }

  @override
  void execute(CanvasEngine engine) {
    redo(engine);
  }

  @override
  void undo(CanvasEngine engine) {
    for (final delta in deltas.reversed) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    for (final delta in deltas) {
      if (delta.layerIndex >= 0 && delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex].setPixel(delta.x, delta.y, delta.newPixel);
      }
    }
    engine.compositeVisibleLayers();
  }
}

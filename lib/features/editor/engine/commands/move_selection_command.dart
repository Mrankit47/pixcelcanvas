import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Undoable command for a complete selection move operation.
///
/// **Design**: A move is recorded as two sets of pixel deltas:
/// - [_sourceDeltas]: pixels cleared at the original location
/// - [_destDeltas]: pixels written at the new location
///
/// The entire move (begin → drag → commit) collapses into ONE undo step.
/// On undo, destination pixels are reversed and source pixels restored.
///
/// **Architecture**: Extends [HistoryCommand] — no framework dependencies.
class MoveSelectionCommand extends HistoryCommand {
  /// Creates a [MoveSelectionCommand].
  MoveSelectionCommand({
    required List<PixelDelta> sourceDeltas,
    required List<PixelDelta> destDeltas,
  })  : _sourceDeltas = sourceDeltas,
        _destDeltas = destDeltas;

  /// Pixel deltas for clearing the source location.
  final List<PixelDelta> _sourceDeltas;

  /// Pixel deltas for writing to the destination location.
  final List<PixelDelta> _destDeltas;

  @override
  String get name => 'Move Selection';

  @override
  void execute(CanvasEngine engine) {
    // Execute is a no-op because both source clearing and destination writing
    // have already been applied by the time this command is pushed to history.
    // The command only needs to support undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    // 1. Reverse destination writes (restore old pixels at destination)
    for (final delta in _destDeltas.reversed) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }

    // 2. Restore source pixels (reverse the clearing)
    for (final delta in _sourceDeltas.reversed) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }

    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    // 1. Re-clear source pixels
    for (final delta in _sourceDeltas) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.newPixel);
      }
    }

    // 2. Re-write destination pixels
    for (final delta in _destDeltas) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.newPixel);
      }
    }

    engine.compositeVisibleLayers();
  }
}

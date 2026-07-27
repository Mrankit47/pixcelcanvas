import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Undoable command for a paste operation — writes clipboard pixels to the layer.
///
/// **Design**: Paste writes clipboard pixel data onto the active layer at the
/// target position. Each written pixel is recorded as a [PixelDelta] for undo.
///
/// **Architecture**: Extends [HistoryCommand] — no framework dependencies.
class PasteSelectionCommand extends HistoryCommand {
  /// Creates a [PasteSelectionCommand].
  PasteSelectionCommand({
    required List<PixelDelta> deltas,
  }) : _deltas = deltas;

  /// Pixel deltas recording old → new for each pasted pixel.
  final List<PixelDelta> _deltas;

  @override
  String get name => 'Paste Selection';

  @override
  void execute(CanvasEngine engine) {
    // Execute is a no-op because the pixels have already been written by the
    // time this command is pushed to history. The command only supports undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    // Restore old pixels at each pasted position.
    for (final delta in _deltas.reversed) {
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
    // Re-write pasted pixels.
    for (final delta in _deltas) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < engine.grid.layers.length) {
        engine.grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.newPixel);
      }
    }
    engine.compositeVisibleLayers();
  }
}

import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';

/// Undoable command for a cut operation — clears selected pixels from the layer.
///
/// **Design**: Cut = copy to clipboard + clear source pixels. The clipboard
/// population is handled by [ClipboardManager]; this command handles only the
/// pixel clearing and its undo/redo.
///
/// **Architecture**: Extends [HistoryCommand] — no framework dependencies.
class CutSelectionCommand extends HistoryCommand {
  /// Creates a [CutSelectionCommand].
  CutSelectionCommand({
    required List<PixelDelta> deltas,
  }) : _deltas = deltas;

  /// Pixel deltas recording old → empty for each cleared pixel.
  final List<PixelDelta> _deltas;

  @override
  String get name => 'Cut Selection';

  @override
  void execute(CanvasEngine engine) {
    // Execute is a no-op because the pixels have already been cleared by the
    // time this command is pushed to history. The command only supports undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    // Restore old pixels at each cleared position.
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
    // Re-clear pixels (set to empty).
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

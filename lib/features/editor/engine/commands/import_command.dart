import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';

/// Reversible history command for a completed image import operation.
///
/// **Design**: Entire import operation collapses into **ONE** history step.
/// Handles `newLayer`, `replaceActive`, and `newCanvas` import strategies cleanly.
class ImportCommand extends HistoryCommand {
  /// Creates an [ImportCommand].
  ImportCommand({
    required this.destination,
    this.deltas = const [],
    this.createdLayerIndex,
    this.previousLayers,
    this.previousWidth,
    this.previousHeight,
  });

  /// Import destination strategy.
  final ImportDestination destination;

  /// Pixel deltas for `replaceActive` destination.
  final List<PixelDelta> deltas;

  /// Index of the newly created layer for `newLayer` destination.
  final int? createdLayerIndex;

  /// Snapshot of previous layer list for `newCanvas` destination.
  final List<LayerBuffer>? previousLayers;

  /// Previous canvas width for `newCanvas` destination.
  final int? previousWidth;

  /// Previous canvas height for `newCanvas` destination.
  final int? previousHeight;

  @override
  String get name => 'Import Image';

  @override
  void execute(CanvasEngine engine) {
    // Already applied on commit; handles undo/redo.
  }

  @override
  void undo(CanvasEngine engine) {
    switch (destination) {
      case ImportDestination.replaceActive:
        for (final delta in deltas.reversed) {
          if (delta.layerIndex >= 0 &&
              delta.layerIndex < engine.grid.layers.length) {
            engine.grid.layers[delta.layerIndex]
                .setPixel(delta.x, delta.y, delta.oldPixel);
          }
        }
        break;

      case ImportDestination.newLayer:
        if (createdLayerIndex != null &&
            createdLayerIndex! >= 0 &&
            createdLayerIndex! < engine.grid.layers.length) {
          engine.deleteLayer(createdLayerIndex!);
        }
        break;

      case ImportDestination.newCanvas:
        if (previousWidth != null &&
            previousHeight != null &&
            previousLayers != null) {
          engine.resizeCanvas(previousWidth!, previousHeight!);
          engine.grid.layers.clear();
          engine.grid.layers.addAll(previousLayers!);
        }
        break;
    }

    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) {
    switch (destination) {
      case ImportDestination.replaceActive:
        for (final delta in deltas) {
          if (delta.layerIndex >= 0 &&
              delta.layerIndex < engine.grid.layers.length) {
            engine.grid.layers[delta.layerIndex]
                .setPixel(delta.x, delta.y, delta.newPixel);
          }
        }
        break;

      case ImportDestination.newLayer:
        // Re-create layer and write deltas
        engine.createLayer();
        final newIndex = engine.grid.layers.length - 1;
        for (final delta in deltas) {
          engine.grid.layers[newIndex]
              .setPixel(delta.x, delta.y, delta.newPixel);
        }
        break;

      case ImportDestination.newCanvas:
        // Handled via canvas engine state
        break;
    }

    engine.compositeVisibleLayers();
  }
}

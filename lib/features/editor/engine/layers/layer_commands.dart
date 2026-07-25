import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_factory.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';

/// Command to create a new layer per Blueprint §8.1.
class CreateLayerCommand extends HistoryCommand {
  CreateLayerCommand({required this.insertIndex});

  final int insertIndex;
  String? _createdLayerId;

  @override
  String get name => 'Create Layer';

  @override
  void execute(CanvasEngine engine) {
    final layer = engine.layerFactory.create(
      width: engine.width,
      height: engine.height,
      index: insertIndex,
    );
    _createdLayerId = layer.id;
    engine.grid.layers.insert(insertIndex, layer);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (_createdLayerId != null) {
      engine.grid.layers.removeWhere((l) => l.id == _createdLayerId);
      _reindex(engine);
      engine.compositeVisibleLayers();
    }
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to delete a layer per Blueprint §8.1.
class DeleteLayerCommand extends HistoryCommand {
  DeleteLayerCommand({required this.layerIndex});

  final int layerIndex;
  LayerBuffer? _deletedLayer;

  @override
  String get name => 'Delete Layer';

  @override
  void execute(CanvasEngine engine) {
    if (engine.grid.layers.length <= 1) return;
    if (layerIndex < 0 || layerIndex >= engine.grid.layers.length) return;
    _deletedLayer = engine.grid.layers.removeAt(layerIndex);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (_deletedLayer != null) {
      final idx = layerIndex.clamp(0, engine.grid.layers.length);
      engine.grid.layers.insert(idx, _deletedLayer!);
      _reindex(engine);
      engine.compositeVisibleLayers();
    }
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to duplicate a layer per Blueprint §8.1.
class DuplicateLayerCommand extends HistoryCommand {
  DuplicateLayerCommand({required this.sourceIndex});

  final int sourceIndex;
  String? _duplicatedLayerId;

  @override
  String get name => 'Duplicate Layer';

  @override
  void execute(CanvasEngine engine) {
    if (sourceIndex < 0 || sourceIndex >= engine.grid.layers.length) return;
    final source = engine.grid.layers[sourceIndex];
    final copy = engine.layerFactory.duplicate(
      source: source,
      width: engine.width,
      height: engine.height,
    );
    _duplicatedLayerId = copy.id;
    engine.grid.layers.insert(sourceIndex + 1, copy);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (_duplicatedLayerId != null) {
      engine.grid.layers.removeWhere((l) => l.id == _duplicatedLayerId);
      _reindex(engine);
      engine.compositeVisibleLayers();
    }
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to rename a layer per Blueprint §8.1.
class RenameLayerCommand extends HistoryCommand {
  RenameLayerCommand({required this.layerIndex, required this.newName});

  final int layerIndex;
  final String newName;
  String? _oldName;

  @override
  String get name => 'Rename Layer';

  @override
  void execute(CanvasEngine engine) {
    if (layerIndex < 0 || layerIndex >= engine.grid.layers.length) return;
    _oldName = engine.grid.layers[layerIndex].name;
    engine.grid.layers[layerIndex].name = newName;
  }

  @override
  void undo(CanvasEngine engine) {
    if (_oldName != null && layerIndex < engine.grid.layers.length) {
      engine.grid.layers[layerIndex].name = _oldName!;
    }
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to move a layer up or down in the stack per Blueprint §8.1.
class MoveLayerCommand extends HistoryCommand {
  MoveLayerCommand({required this.fromIndex, required this.toIndex});

  final int fromIndex;
  final int toIndex;

  @override
  String get name => 'Move Layer';

  @override
  void execute(CanvasEngine engine) {
    if (fromIndex < 0 || fromIndex >= engine.grid.layers.length) return;
    if (toIndex < 0 || toIndex >= engine.grid.layers.length) return;
    final layer = engine.grid.layers.removeAt(fromIndex);
    engine.grid.layers.insert(toIndex, layer);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (toIndex < 0 || toIndex >= engine.grid.layers.length) return;
    final layer = engine.grid.layers.removeAt(toIndex);
    engine.grid.layers.insert(fromIndex.clamp(0, engine.grid.layers.length), layer);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to merge a layer down onto the layer below per Blueprint §8.1.
class MergeLayerCommand extends HistoryCommand {
  MergeLayerCommand({required this.sourceIndex});

  final int sourceIndex;
  LayerBuffer? _savedSource;
  LayerBuffer? _savedTarget;

  @override
  String get name => 'Merge Layer Down';

  @override
  void execute(CanvasEngine engine) {
    if (sourceIndex <= 0 || sourceIndex >= engine.grid.layers.length) return;

    final source = engine.grid.layers[sourceIndex];
    final target = engine.grid.layers[sourceIndex - 1];

    // Snapshot source and target for undo
    _savedSource = engine.layerFactory.duplicate(
      source: source,
      width: engine.width,
      height: engine.height,
    );
    _savedTarget = engine.layerFactory.duplicate(
      source: target,
      width: engine.width,
      height: engine.height,
    );

    // Merge source pixels onto target
    for (var y = 0; y < engine.height; y++) {
      for (var x = 0; x < engine.width; x++) {
        final px = source.getPixel(x, y);
        if (!px.isEmpty) {
          target.setPixel(x, y, px);
        }
      }
    }

    engine.grid.layers.removeAt(sourceIndex);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (_savedSource == null || _savedTarget == null) return;

    final targetIndex = sourceIndex - 1;
    if (targetIndex < 0 || targetIndex >= engine.grid.layers.length) return;

    // Restore target layer pixel data
    final target = engine.grid.layers[targetIndex];
    for (var y = 0; y < engine.height; y++) {
      for (var x = 0; x < engine.width; x++) {
        target.setPixel(x, y, _savedTarget!.getPixel(x, y));
      }
    }

    // Re-insert source layer
    engine.grid.layers.insert(sourceIndex, _savedSource!);
    _reindex(engine);
    engine.compositeVisibleLayers();
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to toggle layer visibility per Blueprint §8.1.
class VisibilityCommand extends HistoryCommand {
  VisibilityCommand({required this.layerIndex});

  final int layerIndex;

  @override
  String get name => 'Toggle Visibility';

  @override
  void execute(CanvasEngine engine) {
    if (layerIndex < 0 || layerIndex >= engine.grid.layers.length) return;
    engine.grid.layers[layerIndex].isVisible = !engine.grid.layers[layerIndex].isVisible;
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) => execute(engine);

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to toggle layer lock per Blueprint §8.1.
class LockCommand extends HistoryCommand {
  LockCommand({required this.layerIndex});

  final int layerIndex;

  @override
  String get name => 'Toggle Lock';

  @override
  void execute(CanvasEngine engine) {
    if (layerIndex < 0 || layerIndex >= engine.grid.layers.length) return;
    engine.grid.layers[layerIndex].isLocked = !engine.grid.layers[layerIndex].isLocked;
  }

  @override
  void undo(CanvasEngine engine) => execute(engine);

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Command to change layer opacity per Blueprint §8.1.
class OpacityCommand extends HistoryCommand {
  OpacityCommand({required this.layerIndex, required this.newOpacity});

  final int layerIndex;
  final double newOpacity;
  double? _oldOpacity;

  @override
  String get name => 'Set Opacity';

  @override
  void execute(CanvasEngine engine) {
    if (layerIndex < 0 || layerIndex >= engine.grid.layers.length) return;
    _oldOpacity = engine.grid.layers[layerIndex].opacity;
    engine.grid.layers[layerIndex].opacity = newOpacity.clamp(0.0, 1.0);
    engine.compositeVisibleLayers();
  }

  @override
  void undo(CanvasEngine engine) {
    if (_oldOpacity != null && layerIndex < engine.grid.layers.length) {
      engine.grid.layers[layerIndex].opacity = _oldOpacity!;
      engine.compositeVisibleLayers();
    }
  }

  @override
  void redo(CanvasEngine engine) => execute(engine);
}

/// Re-indexes all layer stack indices after a structural change.
void _reindex(CanvasEngine engine) {
  for (var i = 0; i < engine.grid.layers.length; i++) {
    engine.grid.layers[i].index = i;
  }
}

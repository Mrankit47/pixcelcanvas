import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/layer_buffer.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_commands.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_validator.dart';

/// Multi-layer management orchestrator per Blueprint §8.1.
///
/// **Purpose**: Provides high-level layer operations that validate state, create history commands,
/// and execute through [HistoryManager] so every action is undoable.
/// **Layer Lifecycle**: Create → Configure → Render → (Merge/Delete).
/// **Compositing Order**: Index 0 = bottom of stack, highest index = top of stack.
/// **Memory Considerations**: Each layer owns a dense [PixelBuffer]. At 512×512 × 100 layers,
/// memory usage remains under ~100 MB.
class LayerManager {
  /// Creates a [LayerManager].
  LayerManager(this._engine);

  final CanvasEngine _engine;

  /// Current layer count.
  int get layerCount => _engine.grid.layers.length;

  /// Read-only view of layer list.
  List<LayerBuffer> get layers => List.unmodifiable(_engine.grid.layers);

  /// Creates a new layer above the current active layer index.
  void createLayer() {
    if (!LayerValidator.canCreateLayer(_engine.grid.layers)) return;
    final insertIdx = (_engine.session.activeLayerIndex + 1)
        .clamp(0, _engine.grid.layers.length);
    final cmd = CreateLayerCommand(insertIndex: insertIdx);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.session.activeLayerIndex = insertIdx;
    _engine.notifyListeners();
  }

  /// Deletes the layer at [index].
  void deleteLayer(int index) {
    if (!LayerValidator.canDelete(_engine.grid.layers)) return;
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = DeleteLayerCommand(layerIndex: index);
    _engine.historyManager.executeCommand(cmd, _engine);
    if (_engine.session.activeLayerIndex >= _engine.grid.layers.length) {
      _engine.session.activeLayerIndex = _engine.grid.layers.length - 1;
    }
    _engine.notifyListeners();
  }

  /// Duplicates the layer at [index].
  void duplicateLayer(int index) {
    if (!LayerValidator.canCreateLayer(_engine.grid.layers)) return;
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = DuplicateLayerCommand(sourceIndex: index);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.session.activeLayerIndex = index + 1;
    _engine.notifyListeners();
  }

  /// Renames the layer at [index].
  void renameLayer(int index, String newName) {
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = RenameLayerCommand(layerIndex: index, newName: newName);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.notifyListeners();
  }

  /// Moves the layer at [index] one position up in the stack.
  void moveLayerUp(int index) {
    if (!LayerValidator.canMoveUp(_engine.grid.layers, index)) return;
    final cmd = MoveLayerCommand(fromIndex: index, toIndex: index + 1);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.session.activeLayerIndex = index + 1;
    _engine.notifyListeners();
  }

  /// Moves the layer at [index] one position down in the stack.
  void moveLayerDown(int index) {
    if (!LayerValidator.canMoveDown(_engine.grid.layers, index)) return;
    final cmd = MoveLayerCommand(fromIndex: index, toIndex: index - 1);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.session.activeLayerIndex = index - 1;
    _engine.notifyListeners();
  }

  /// Merges the layer at [index] down onto the layer below it.
  void mergeLayerDown(int index) {
    if (!LayerValidator.canMergeDown(_engine.grid.layers, index)) return;
    final cmd = MergeLayerCommand(sourceIndex: index);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.session.activeLayerIndex = (index - 1).clamp(0, _engine.grid.layers.length - 1);
    _engine.notifyListeners();
  }

  /// Toggles visibility of the layer at [index].
  void toggleVisibility(int index) {
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = VisibilityCommand(layerIndex: index);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.notifyListeners();
  }

  /// Toggles lock of the layer at [index].
  void toggleLock(int index) {
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = LockCommand(layerIndex: index);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.notifyListeners();
  }

  /// Sets opacity of the layer at [index].
  void setOpacity(int index, double opacity) {
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    final cmd = OpacityCommand(layerIndex: index, newOpacity: opacity);
    _engine.historyManager.executeCommand(cmd, _engine);
    _engine.notifyListeners();
  }

  /// Selects the active layer by [index].
  void selectLayer(int index) {
    if (!LayerValidator.isValidIndex(_engine.grid.layers, index)) return;
    _engine.session.activeLayerIndex = index;
    _engine.notifyListeners();
  }
}

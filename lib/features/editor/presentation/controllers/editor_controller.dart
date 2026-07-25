import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';

/// Riverpod Controller managing Pixel Editor workspace presentation state per Blueprint §6.3.
///
/// **Purpose**: Exposes tool selection, brush/eraser settings, zoom, grid, undo/redo, and layer state to UI.
/// **Responsibilities**: Presentation state only. Business logic resides in [CanvasEngine].
class EditorController extends StateNotifier<EditorState> {
  /// Creates an [EditorController].
  EditorController() : super(const EditorState());

  /// Sets active drawing tool.
  void selectTool(PixelTool tool) {
    state = state.copyWith(selectedTool: tool);
  }

  /// Sets brush size (1 to 8 px).
  void setBrushSize(int size) {
    state = state.copyWith(
      brushSettings: state.brushSettings.copyWith(size: size),
    );
  }

  /// Sets eraser size (1 to 8 px).
  void setEraserSize(int size) {
    state = state.copyWith(
      eraserSettings: state.eraserSettings.copyWith(size: size),
    );
  }

  /// Updates brush settings.
  void updateBrushSettings(BrushSettings settings) {
    state = state.copyWith(brushSettings: settings);
  }

  /// Updates eraser settings.
  void updateEraserSettings(EraserSettings settings) {
    state = state.copyWith(eraserSettings: settings);
  }

  /// Syncs undo/redo availability and layer list from [CanvasEngine].
  void syncEngineState(CanvasEngine engine) {
    state = state.copyWith(
      canUndo: engine.canUndo,
      canRedo: engine.canRedo,
      selectedLayerIndex: engine.session.activeLayerIndex,
      layers: engine.grid.layers
          .map((l) => LayerInfo(
                id: l.id,
                name: l.name,
                isVisible: l.isVisible,
                isLocked: l.isLocked,
                opacity: l.opacity,
              ))
          .toList(),
    );
  }

  /// Legacy alias for [syncEngineState].
  void updateHistoryState(CanvasEngine engine) => syncEngineState(engine);

  /// Sets active layer index.
  void selectLayer(int index) {
    state = state.copyWith(selectedLayerIndex: index);
  }

  /// Sets zoom level multiplier.
  void setZoom(double zoom) {
    state = state.copyWith(zoomLevel: zoom.clamp(0.5, 8.0));
  }

  /// Toggles pixel grid visibility.
  void toggleGrid() {
    state = state.copyWith(showGrid: !state.showGrid);
  }

  /// Sets active primary color hex string.
  void setActiveColor(String hex) {
    state = state.copyWith(activeColorHex: hex);
  }
}

/// Riverpod provider for [EditorController].
final editorControllerProvider = StateNotifierProvider<EditorController, EditorState>((ref) {
  return EditorController();
});

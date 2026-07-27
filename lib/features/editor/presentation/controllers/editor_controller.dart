import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';
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

  /// Syncs undo/redo availability, layer list, selection state, clipboard and floating selection state from [CanvasEngine].
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
      hasSelection: engine.hasSelection,
      selectionBounds: engine.selectionEngine.selectionBounds,
      isSelectionVisible: engine.selectionEngine.isSelectionVisible,
      hasClipboard: engine.hasClipboard,
      hasFloatingSelection: engine.hasFloatingSelection,
      isMovingSelection: engine.hasFloatingSelection,
      shapeSettings: engine.shapeEngine.settings,
      hasActiveTransform: engine.hasActiveTransform,
      hasActiveImport: engine.hasActiveImport,
      importSettings: engine.importEngine.settings,
      hasSpriteSheet: engine.hasSpriteSheet,
      frameCount: engine.spriteSheetEngine.frameCount,
      activeFrameIndex: engine.spriteSheetEngine.activeFrameIndex,
      isAnimationPlaying: engine.isAnimationPlaying,
      currentAnimationFrameIndex: engine.currentAnimationFrameIndex,
      activeClipName: engine.activeAnimationClip?.name ?? 'Idle',
      onionSkinEnabled: engine.animationEngine.settings.onionSkinEnabled,
      animationFps: engine.animationEngine.settings.fps,
      animationLoopMode: engine.animationEngine.settings.loopMode,
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

  /// Sets the active selection tool type.
  void setSelectionTool(SelectionType type) {
    state = state.copyWith(activeSelectionTool: type);
  }

  /// Toggles selection overlay visibility.
  void toggleSelectionVisibility() {
    state = state.copyWith(isSelectionVisible: !state.isSelectionVisible);
  }

  /// Syncs only selection state from [CanvasEngine].
  void syncSelectionState(CanvasEngine engine) {
    state = state.copyWith(
      hasSelection: engine.hasSelection,
      selectionBounds: engine.selectionEngine.selectionBounds,
      isSelectionVisible: engine.selectionEngine.isSelectionVisible,
      hasClipboard: engine.hasClipboard,
      hasFloatingSelection: engine.hasFloatingSelection,
      isMovingSelection: engine.hasFloatingSelection,
    );
  }

  /// Copies selection in [engine] and updates controller state.
  void copy(CanvasEngine engine) {
    engine.copySelection();
    syncEngineState(engine);
  }

  /// Cuts selection in [engine] and updates controller state.
  void cut(CanvasEngine engine) {
    engine.cutSelection();
    syncEngineState(engine);
  }

  /// Pastes selection in [engine] and updates controller state.
  void paste(CanvasEngine engine) {
    engine.pasteSelection();
    syncEngineState(engine);
  }

  /// Begins moving selection in [engine] and updates controller state.
  void beginMove(CanvasEngine engine) {
    engine.beginMoveSelection();
    syncEngineState(engine);
  }

  /// Updates move offset in [engine] and updates controller state.
  void updateMove(CanvasEngine engine, int dx, int dy) {
    engine.updateMoveSelection(dx, dy);
    syncEngineState(engine);
  }

  /// Commits movement in [engine] and updates controller state.
  void commitMove(CanvasEngine engine) {
    engine.commitMoveSelection();
    syncEngineState(engine);
  }

  /// Cancels movement in [engine] and updates controller state.
  void cancelMove(CanvasEngine engine) {
    engine.cancelMoveSelection();
    syncEngineState(engine);
  }

  /// Sets active shape type in [engine] and controller state.
  void setShapeType(CanvasEngine engine, ShapeType type) {
    engine.setShapeType(type);
    state = state.copyWith(shapeSettings: engine.shapeEngine.settings);
  }

  /// Sets active shape fill mode in [engine] and controller state.
  void setShapeFillMode(CanvasEngine engine, ShapeFillMode fillMode) {
    engine.setShapeFillMode(fillMode);
    state = state.copyWith(shapeSettings: engine.shapeEngine.settings);
  }

  /// Begins shape preview drag in [engine].
  void beginShape(CanvasEngine engine, int x, int y) {
    engine.beginShape(x, y);
    syncEngineState(engine);
  }

  /// Updates shape preview drag destination in [engine].
  void updateShape(CanvasEngine engine, int x, int y) {
    engine.updateShape(x, y);
    syncEngineState(engine);
  }

  /// Commits active shape in [engine] to layer and updates controller state.
  void commitShape(CanvasEngine engine) {
    engine.commitShape();
    syncEngineState(engine);
  }

  /// Cancels active shape drag in [engine] and updates controller state.
  void cancelShape(CanvasEngine engine) {
    engine.cancelShape();
    syncEngineState(engine);
  }

  /// Begins transformation session in [engine].
  void beginTransform(CanvasEngine engine) {
    engine.beginTransform();
    syncEngineState(engine);
  }

  /// Updates transform preview in [engine].
  void updateTransform(CanvasEngine engine) {
    engine.updateTransform();
    syncEngineState(engine);
  }

  /// Commits active transformation in [engine] and updates controller state.
  void commitTransform(CanvasEngine engine) {
    engine.commitTransform();
    syncEngineState(engine);
  }

  /// Cancels active transformation in [engine] and updates controller state.
  void cancelTransform(CanvasEngine engine) {
    engine.cancelTransform();
    syncEngineState(engine);
  }

  /// Rotates selection 90° Clockwise.
  void rotateClockwise(CanvasEngine engine) {
    engine.rotateClockwise();
    syncEngineState(engine);
  }

  /// Rotates selection 90° Counter-Clockwise.
  void rotateCounterClockwise(CanvasEngine engine) {
    engine.rotateCounterClockwise();
    syncEngineState(engine);
  }

  /// Rotates selection 180°.
  void rotate180(CanvasEngine engine) {
    engine.rotate180();
    syncEngineState(engine);
  }

  /// Flips selection horizontally.
  void flipHorizontal(CanvasEngine engine) {
    engine.flipHorizontal();
    syncEngineState(engine);
  }

  /// Flips selection vertically.
  void flipVertical(CanvasEngine engine) {
    engine.flipVertical();
    syncEngineState(engine);
  }

  /// Mirrors horizontal left half to right half.
  void mirrorHorizontal(CanvasEngine engine) {
    engine.mirrorHorizontal();
    syncEngineState(engine);
  }

  /// Mirrors vertical top half to bottom half.
  void mirrorVertical(CanvasEngine engine) {
    engine.mirrorVertical();
    syncEngineState(engine);
  }

  /// Scales selection to [newWidth] × [newHeight].
  void scaleSelection(CanvasEngine engine, int newWidth, int newHeight) {
    engine.scaleSelection(newWidth, newHeight);
    syncEngineState(engine);
  }

  /// Imports image bytes into [engine] and updates controller state.
  void importImage(CanvasEngine engine, Uint8List bytes, [ImportSettings? settings]) {
    engine.importImage(bytes, settings);
    syncEngineState(engine);
  }

  /// Updates active import preview with [settings] in [engine].
  void previewImport(CanvasEngine engine, ImportSettings settings) {
    engine.previewImport(settings);
    syncEngineState(engine);
  }

  /// Commits active image import in [engine] and updates controller state.
  void commitImport(CanvasEngine engine) {
    engine.commitImport();
    syncEngineState(engine);
  }

  /// Cancels active image import in [engine] and updates controller state.
  void cancelImport(CanvasEngine engine) {
    engine.cancelImport();
    syncEngineState(engine);
  }

  /// Imports sprite sheet PNG into [engine].
  void importSpriteSheet(CanvasEngine engine, Uint8List bytes, [SpriteSheetSettings? settings]) {
    engine.importSpriteSheet(bytes, settings);
    syncEngineState(engine);
  }

  /// Performs grid slicing in [engine].
  void sliceSpriteSheet(CanvasEngine engine, SpriteSheetSettings settings) {
    engine.sliceSpriteSheet(settings);
    syncEngineState(engine);
  }

  /// Manually creates frame from [bounds] in [engine].
  void createFrame(CanvasEngine engine, SelectionBounds bounds, [String? name]) {
    engine.createFrame(bounds, name);
    syncEngineState(engine);
  }

  /// Duplicates frame at [frameIndex] in [engine].
  void duplicateFrame(CanvasEngine engine, int frameIndex) {
    engine.duplicateFrame(frameIndex);
    syncEngineState(engine);
  }

  /// Deletes frame at [frameIndex] in [engine].
  void deleteFrame(CanvasEngine engine, int frameIndex) {
    engine.deleteFrame(frameIndex);
    syncEngineState(engine);
  }

  /// Renames frame at [frameIndex] in [engine].
  void renameFrame(CanvasEngine engine, int frameIndex, String newName) {
    engine.renameFrame(frameIndex, newName);
    syncEngineState(engine);
  }

  /// Reorders frame from [oldIndex] to [newIndex] in [engine].
  void reorderFrame(CanvasEngine engine, int oldIndex, int newIndex) {
    engine.reorderFrame(oldIndex, newIndex);
    syncEngineState(engine);
  }

  /// Creates animation clip [name] in [engine].
  void createAnimation(CanvasEngine engine, String name, [List<AnimationFrame>? frames]) {
    engine.createAnimation(name, frames);
    syncEngineState(engine);
  }

  /// Deletes animation clip by [clipId] in [engine].
  void deleteAnimation(CanvasEngine engine, String clipId) {
    engine.deleteAnimation(clipId);
    syncEngineState(engine);
  }

  /// Duplicates animation clip by [clipId] in [engine].
  void duplicateAnimation(CanvasEngine engine, String clipId) {
    engine.duplicateAnimation(clipId);
    syncEngineState(engine);
  }

  /// Renames animation clip by [clipId] to [newName] in [engine].
  void renameAnimation(CanvasEngine engine, String clipId, String newName) {
    engine.renameAnimation(clipId, newName);
    syncEngineState(engine);
  }

  /// Starts animation playback in [engine].
  void playAnimation(CanvasEngine engine) {
    engine.playAnimation();
    syncEngineState(engine);
  }

  /// Pauses animation playback in [engine].
  void pauseAnimation(CanvasEngine engine) {
    engine.pauseAnimation();
    syncEngineState(engine);
  }

  /// Stops animation playback in [engine].
  void stopAnimation(CanvasEngine engine) {
    engine.stopAnimation();
    syncEngineState(engine);
  }

  /// Seeks animation playhead to [frameIndex] in [engine].
  void seekFrame(CanvasEngine engine, int frameIndex) {
    engine.seekFrame(frameIndex);
    syncEngineState(engine);
  }

  /// Steps to next animation frame in [engine].
  void nextAnimationFrame(CanvasEngine engine) {
    engine.nextAnimationFrame();
    syncEngineState(engine);
  }

  /// Steps to previous animation frame in [engine].
  void previousAnimationFrame(CanvasEngine engine) {
    engine.previousAnimationFrame();
    syncEngineState(engine);
  }

  /// Updates animation FPS in [engine].
  void setFPS(CanvasEngine engine, int fps) {
    engine.setFPS(fps);
    syncEngineState(engine);
  }

  /// Updates animation loop mode in [engine].
  void setLoopMode(CanvasEngine engine, LoopMode loopMode) {
    engine.setLoopMode(loopMode);
    syncEngineState(engine);
  }

  /// Toggles onion skin overlay in [engine].
  void toggleOnionSkin(CanvasEngine engine, [bool? enabled]) {
    engine.toggleOnionSkin(enabled);
    syncEngineState(engine);
  }

  /// Advances animation playback ticker by [deltaMs] in [engine].
  void tickAnimation(CanvasEngine engine, int deltaMs) {
    engine.tickAnimation(deltaMs);
    syncEngineState(engine);
  }
}

/// Riverpod provider for [EditorController].
final editorControllerProvider = StateNotifierProvider<EditorController, EditorState>((ref) {
  return EditorController();
});

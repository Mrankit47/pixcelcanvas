import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/brush/brush_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_viewport_controller.dart';
import 'package:pixelcanvas/features/editor/engine/clipboard/clipboard_manager.dart';
import 'package:pixelcanvas/features/editor/engine/commands/circle_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/copy_selection_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/cut_selection_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/draw_commands.dart';
import 'package:pixelcanvas/features/editor/engine/commands/create_animation_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/create_frame_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/delete_animation_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/delete_frame_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/duplicate_animation_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/duplicate_frame_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/ellipse_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/flip_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/import_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/import_sprite_sheet_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/line_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/mirror_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/move_selection_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/paste_selection_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';
import 'package:pixelcanvas/features/editor/engine/commands/playback_settings_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/rectangle_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/rename_animation_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/rename_frame_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/reorder_frame_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/timeline_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/rotate_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/scale_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/transform_command.dart';
import 'package:pixelcanvas/features/editor/engine/commands/history_command.dart';
import 'package:pixelcanvas/features/editor/engine/drawing_session.dart';
import 'package:pixelcanvas/features/editor/engine/eraser/eraser_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/export/export_engine.dart';
import 'package:pixelcanvas/features/editor/engine/export/models/export_settings.dart';
import 'package:pixelcanvas/features/editor/engine/fill/flood_fill_engine.dart';
import 'package:pixelcanvas/features/editor/engine/floating_selection/floating_selection.dart';
import 'package:pixelcanvas/features/editor/engine/history/history_manager.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_factory.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_manager.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/fill_settings.dart';
import 'package:pixelcanvas/features/editor/engine/picker/color_sampler.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_grid.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_bounds.dart';
import 'package:pixelcanvas/features/editor/engine/selection/models/selection_region.dart';
import 'package:pixelcanvas/features/editor/engine/selection/selection_engine.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_preview.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/shape_engine.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/shape_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/models/sprite_sheet_settings.dart';
import 'package:pixelcanvas/features/editor/engine/sprite_sheet/sprite_sheet_engine.dart';
import 'package:pixelcanvas/features/editor/engine/animation/animation_engine.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_clip.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_frame.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/animation_settings.dart';
import 'package:pixelcanvas/features/editor/engine/animation/models/loop_mode.dart';
import 'package:pixelcanvas/features/editor/engine/serialization/project_deserializer.dart';
import 'package:pixelcanvas/features/editor/engine/serialization/project_serializer.dart';
import 'package:pixelcanvas/features/editor/engine/import/import_engine.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_preview.dart';
import 'package:pixelcanvas/features/editor/engine/import/models/import_settings.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/brush_stroke.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/stroke_point.dart';
import 'package:pixelcanvas/features/editor/engine/tools/brush_tool.dart';
import 'package:pixelcanvas/features/editor/engine/tools/eraser_tool.dart';
import 'package:pixelcanvas/features/editor/engine/transform/models/transform_preview.dart';
import 'package:pixelcanvas/features/editor/engine/transform/transform_engine.dart';

/// Central Core Pixel Canvas Engine per Blueprint §8.1.
///
/// **Purpose**: Orchestrates pixel grid, layers, history, brush, eraser, fill, and viewport.
/// **Responsibilities**: Initialize, resize, draw, erase, fill, sample, undo, redo, layer management.
/// **Performance**: Command pattern pixel deltas, bottom-to-top opacity compositing, up to 100 layers.
class CanvasEngine extends ChangeNotifier {
  /// Creates a [CanvasEngine].
  CanvasEngine({
    int width = 32,
    int height = 32,
  })  : grid = PixelGrid(width: width, height: height),
        viewportController = CanvasViewportController(),
        session = DrawingSession(),
        currentStroke = BrushStroke(),
        historyManager = HistoryManager(),
        layerFactory = LayerFactory(),
        brushSettings = const BrushSettings(),
        eraserSettings = const EraserSettings(),
        fillSettings = const FillSettings() {
    layerManager = LayerManager(this);
    compositeVisibleLayers();
  }

  /// Composite pixel grid matrix.
  PixelGrid grid;

  /// Viewport transformation controller.
  final CanvasViewportController viewportController;

  /// Active drawing session.
  final DrawingSession session;

  /// Active continuous brush stroke.
  final BrushStroke currentStroke;

  /// History manager instance.
  final HistoryManager historyManager;

  /// Layer creation factory.
  final LayerFactory layerFactory;

  /// Multi-layer management orchestrator.
  late final LayerManager layerManager;

  /// Active brush settings configuration.
  BrushSettings brushSettings;

  /// Active eraser settings configuration.
  EraserSettings eraserSettings;

  /// Active fill settings configuration.
  FillSettings fillSettings;

  /// Selection engine instance for managing selection state.
  final SelectionEngine selectionEngine = SelectionEngine();

  /// Shape drawing engine instance.
  final ShapeEngine shapeEngine = ShapeEngine();

  /// Transform engine instance for non-destructive transformations.
  final TransformEngine transformEngine = TransformEngine();

  /// Import engine instance for PNG image-to-pixel processing.
  final ImportEngine importEngine = ImportEngine();

  /// Sprite sheet engine instance for frame management and slicing.
  final SpriteSheetEngine spriteSheetEngine = SpriteSheetEngine();

  /// Animation engine instance for timeline management and playback.
  final AnimationEngine animationEngine = AnimationEngine();

  /// Clipboard manager for copy/cut/paste operations.
  final ClipboardManager clipboardManager = ClipboardManager();

  /// Active floating selection during move/paste, or null.
  FloatingSelection? _floatingSelection;

  /// Pixel deltas recorded when the source pixels were cleared for a move.
  /// Stored temporarily between beginMove and commit/cancel.
  List<PixelDelta> _moveSourceDeltas = [];

  CommandBatch? _activeBatch;

  /// Width in pixels.
  int get width => grid.width;

  /// Height in pixels.
  int get height => grid.height;

  /// True if undo action is available.
  bool get canUndo => historyManager.canUndo;

  /// True if redo action is available.
  bool get canRedo => historyManager.canRedo;

  /// Current floating selection, or null.
  FloatingSelection? get floatingSelection => _floatingSelection;

  /// Active shape preview state, or null.
  ShapePreview? get shapePreview => shapeEngine.preview;

  /// Active transform preview state, or null.
  TransformPreview? get transformPreview => transformEngine.preview;

  /// True if there is an active transformation session.
  bool get hasActiveTransform => transformEngine.hasActiveTransform;

  /// Active import preview state, or null.
  ImportPreview? get importPreview => importEngine.preview;

  /// True if an image import session is currently active.
  bool get hasActiveImport => importEngine.hasActiveImport;

  /// Active sprite sheet asset container, or null.
  SpriteSheet? get activeSpriteSheet => spriteSheetEngine.sheet;

  /// True if a sprite sheet with frames is currently loaded.
  bool get hasSpriteSheet => spriteSheetEngine.hasSpriteSheet;

  /// Active animation clip sequence, or null.
  AnimationClip? get activeAnimationClip => animationEngine.activeClip;

  /// True if animation playback is currently running.
  bool get isAnimationPlaying => animationEngine.isPlaying;

  /// Current animation playhead frame index.
  int get currentAnimationFrameIndex => animationEngine.currentFrameIndex;

  /// True if the clipboard contains data.
  bool get hasClipboard => clipboardManager.hasClipboardData;

  /// True if there is an active floating selection.
  bool get hasFloatingSelection => _floatingSelection != null;

  // ---------------------------------------------------------------------------
  // Layer Operations (delegate to LayerManager)
  // ---------------------------------------------------------------------------

  /// Creates a new layer above the active layer.
  void createLayer() => layerManager.createLayer();

  /// Deletes the layer at [index].
  void deleteLayer(int index) => layerManager.deleteLayer(index);

  /// Duplicates the layer at [index].
  void duplicateLayer(int index) => layerManager.duplicateLayer(index);

  /// Renames the layer at [index].
  void renameLayer(int index, String newName) => layerManager.renameLayer(index, newName);

  /// Moves the layer at [index] one position up.
  void moveLayerUp(int index) => layerManager.moveLayerUp(index);

  /// Moves the layer at [index] one position down.
  void moveLayerDown(int index) => layerManager.moveLayerDown(index);

  /// Merges the layer at [index] down onto the layer below.
  void mergeLayerDown(int index) => layerManager.mergeLayerDown(index);

  /// Toggles visibility of the layer at [index].
  void toggleLayerVisibility(int index) => layerManager.toggleVisibility(index);

  /// Toggles lock of the layer at [index].
  void toggleLayerLock(int index) => layerManager.toggleLock(index);

  /// Sets opacity of the layer at [index].
  void setLayerOpacity(int index, double opacity) => layerManager.setOpacity(index, opacity);

  /// Selects the active layer by [index].
  void selectLayer(int index) => layerManager.selectLayer(index);

  // ---------------------------------------------------------------------------
  // Undo / Redo
  // ---------------------------------------------------------------------------

  /// Executes undo operation.
  void undo() {
    historyManager.undo(this);
    notifyListeners();
  }

  /// Executes redo operation.
  void redo() {
    historyManager.redo(this);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Settings
  // ---------------------------------------------------------------------------

  /// Updates brush size settings.
  void setBrushSize(int size) {
    brushSettings = brushSettings.copyWith(size: size);
    notifyListeners();
  }

  /// Updates eraser size settings.
  void setEraserSize(int size) {
    eraserSettings = eraserSettings.copyWith(size: size);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Flood Fill & Eyedropper
  // ---------------------------------------------------------------------------

  /// Begins a flood fill operation at `(x, y)`.
  void beginFill(int x, int y, Color fillColor) {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      final activeLayer = grid.layers[session.activeLayerIndex];
      final oldPixel = activeLayer.getPixel(x, y);

      if (oldPixel.color.value == fillColor.value) return;

      final batch = CommandBatch('Bucket Fill');

      FloodFillEngine.fill(
        layer: activeLayer,
        startX: x,
        startY: y,
        fillColor: fillColor,
      );

      batch.addDelta(PixelDelta(
        x: x,
        y: y,
        oldPixel: oldPixel,
        newPixel: Pixel(color: fillColor),
        layerIndex: session.activeLayerIndex,
      ));

      historyManager.executeCommand(batch, this);
      compositeVisibleLayers();
    }
  }

  /// Samples composite pixel color at `(x, y)`.
  Color sampleColor(int x, int y) {
    return ColorSampler.sampleColor(grid: grid, x: x, y: y);
  }

  // ---------------------------------------------------------------------------
  // Brush Stroke
  // ---------------------------------------------------------------------------

  /// Begins a new drawing stroke at `(x, y)`.
  void beginStroke(int x, int y) {
    currentStroke.clear();
    currentStroke.addPoint(StrokePoint(x: x, y: y));
    _activeBatch = CommandBatch('Brush Stroke');

    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      final activeLayer = grid.layers[session.activeLayerIndex];
      final oldPixel = activeLayer.getPixel(x, y);

      BrushRenderer.plotBrush(
        layer: activeLayer,
        centerX: x,
        centerY: y,
        color: session.activeColor,
        settings: brushSettings,
      );

      final newPixel = activeLayer.getPixel(x, y);
      _activeBatch?.addDelta(PixelDelta(
        x: x, y: y,
        oldPixel: oldPixel, newPixel: newPixel,
        layerIndex: session.activeLayerIndex,
      ));
      compositeVisibleLayers();
    }
  }

  /// Continues drawing stroke to `(x, y)`.
  void continueStroke(int x, int y) {
    if (currentStroke.points.isEmpty) { beginStroke(x, y); return; }
    final lastPt = currentStroke.points.last;
    if (lastPt.x == x && lastPt.y == y) return;

    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      final activeLayer = grid.layers[session.activeLayerIndex];
      final oldPixel = activeLayer.getPixel(x, y);

      BrushTool.drawStroke(
        layer: activeLayer, x0: lastPt.x, y0: lastPt.y, x1: x, y1: y,
        color: session.activeColor, settings: brushSettings,
      );

      final newPixel = activeLayer.getPixel(x, y);
      _activeBatch?.addDelta(PixelDelta(
        x: x, y: y,
        oldPixel: oldPixel, newPixel: newPixel,
        layerIndex: session.activeLayerIndex,
      ));
      currentStroke.addPoint(StrokePoint(x: x, y: y));
      compositeVisibleLayers();
    }
  }

  /// Ends current drawing stroke.
  void endStroke() {
    if (_activeBatch != null && _activeBatch!.deltas.isNotEmpty) {
      historyManager.executeCommand(_activeBatch!, this);
    }
    _activeBatch = null;
    currentStroke.clear();
  }

  // ---------------------------------------------------------------------------
  // Eraser Stroke
  // ---------------------------------------------------------------------------

  /// Begins erasing at `(x, y)`.
  void beginErase(int x, int y) {
    currentStroke.clear();
    currentStroke.addPoint(StrokePoint(x: x, y: y));
    _activeBatch = CommandBatch('Eraser Stroke');

    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      final activeLayer = grid.layers[session.activeLayerIndex];
      final oldPixel = activeLayer.getPixel(x, y);

      EraserRenderer.eraseBrush(
        layer: activeLayer, centerX: x, centerY: y, settings: eraserSettings,
      );

      _activeBatch?.addDelta(PixelDelta(
        x: x, y: y,
        oldPixel: oldPixel, newPixel: Pixel.empty,
        layerIndex: session.activeLayerIndex,
      ));
      compositeVisibleLayers();
    }
  }

  /// Continues erasing to `(x, y)`.
  void continueErase(int x, int y) {
    if (currentStroke.points.isEmpty) { beginErase(x, y); return; }
    final lastPt = currentStroke.points.last;
    if (lastPt.x == x && lastPt.y == y) return;

    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      final activeLayer = grid.layers[session.activeLayerIndex];
      final oldPixel = activeLayer.getPixel(x, y);

      EraserTool.eraseStroke(
        layer: activeLayer, x0: lastPt.x, y0: lastPt.y, x1: x, y1: y,
        settings: eraserSettings,
      );

      _activeBatch?.addDelta(PixelDelta(
        x: x, y: y,
        oldPixel: oldPixel, newPixel: Pixel.empty,
        layerIndex: session.activeLayerIndex,
      ));
      currentStroke.addPoint(StrokePoint(x: x, y: y));
      compositeVisibleLayers();
    }
  }

  /// Ends current erasing sequence.
  void endErase() {
    if (_activeBatch != null && _activeBatch!.deltas.isNotEmpty) {
      historyManager.executeCommand(_activeBatch!, this);
    }
    _activeBatch = null;
    currentStroke.clear();
  }

  // ---------------------------------------------------------------------------
  // Direct Pixel Operations
  // ---------------------------------------------------------------------------

  /// Erases single pixel at `(x, y)`.
  void erasePixel(int x, int y) {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      EraserRenderer.erasePixel(layer: grid.layers[session.activeLayerIndex], x: x, y: y);
      compositeVisibleLayers();
    }
  }

  /// Plots a single pixel at `(x, y)`.
  void plotPixel(int x, int y, Color color) {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      BrushRenderer.plotPixel(layer: grid.layers[session.activeLayerIndex], x: x, y: y, color: color);
      compositeVisibleLayers();
    }
  }

  /// Reads pixel at (x, y) from active layer.
  Pixel readPixel(int x, int y) {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      return grid.layers[session.activeLayerIndex].getPixel(x, y);
    }
    return Pixel.empty;
  }

  /// Writes pixel at (x, y) to active layer.
  void writePixel(int x, int y, Pixel pixel) {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      grid.layers[session.activeLayerIndex].setPixel(x, y, pixel);
      compositeVisibleLayers();
    }
  }

  /// Clears active layer.
  void clearLayer() {
    if (session.activeLayerIndex >= 0 && session.activeLayerIndex < grid.layers.length) {
      grid.layers[session.activeLayerIndex].clear();
      compositeVisibleLayers();
    }
  }

  /// Clears all layers.
  void clearCanvas() {
    for (final layer in grid.layers) { layer.clear(); }
    compositeVisibleLayers();
  }

  /// Composites visible layers and triggers painter repaint.
  void compositeVisibleLayers() {
    grid.recomposite();
    notifyListeners();
  }

  /// Resizes canvas matrix dimensions.
  void resizeCanvas(int newWidth, int newHeight) {
    grid = PixelGrid(width: newWidth, height: newHeight);
    compositeVisibleLayers();
  }

  // ---------------------------------------------------------------------------
  // Export
  // ---------------------------------------------------------------------------

  /// Exports the composited canvas as PNG binary data.
  Future<Uint8List?> exportAsPng({ExportSettings settings = const ExportSettings()}) async {
    compositeVisibleLayers();
    return ExportEngine.exportAsPng(
      compositeBuffer: grid.compositeBuffer,
      settings: settings,
    );
  }

  /// Renders the composited canvas to raw RGBA bytes without encoding.
  Uint8List renderFlattenedCanvas({ExportSettings settings = const ExportSettings()}) {
    compositeVisibleLayers();
    return ExportEngine.renderFlattenedCanvas(
      compositeBuffer: grid.compositeBuffer,
      settings: settings,
    );
  }

  // ---------------------------------------------------------------------------
  // Selection
  // ---------------------------------------------------------------------------

  /// Begins a new selection at canvas pixel `(x, y)`.
  void beginSelection(int x, int y) {
    selectionEngine.beginSelection(x, y);
    notifyListeners();
  }

  /// Updates the pending selection to include canvas pixel `(x, y)`.
  void updateSelection(int x, int y) {
    selectionEngine.updateSelection(x, y);
    notifyListeners();
  }

  /// Ends the current selection drag, clamping to canvas bounds.
  void endSelection() {
    selectionEngine.endSelectionWithValidation(width, height);
    notifyListeners();
  }

  /// Clears the active selection.
  void clearSelection() {
    selectionEngine.clearSelection();
    notifyListeners();
  }

  /// Returns the active committed [SelectionRegion], or null.
  SelectionRegion? getSelection() => selectionEngine.getSelection();

  /// True if there is an active committed selection.
  bool get hasSelection => selectionEngine.hasSelection;

  // ---------------------------------------------------------------------------
  // Clipboard Operations
  // ---------------------------------------------------------------------------

  /// Copies selected pixels from the active layer to the clipboard.
  ///
  /// Validates: selection exists, layer in range, layer not locked, layer visible.
  /// Pushes [CopySelectionCommand] for history consistency.
  void copySelection() {
    if (!_validateSelectionOperation()) return;

    final bounds = selectionEngine.getSelection()!.bounds;
    final layer = grid.layers[session.activeLayerIndex];

    clipboardManager.copy(
      layer: layer,
      bounds: bounds,
      layerIndex: session.activeLayerIndex,
      canvasWidth: width,
      canvasHeight: height,
    );

    historyManager.executeCommand(CopySelectionCommand(), this);
    notifyListeners();
  }

  /// Cuts selected pixels from the active layer to the clipboard.
  ///
  /// Copies pixels to clipboard, then clears them from the layer.
  /// Pushes [CutSelectionCommand] with pixel deltas for undo.
  void cutSelection() {
    if (!_validateSelectionOperation()) return;

    final bounds = selectionEngine.getSelection()!.bounds;
    final layer = grid.layers[session.activeLayerIndex];
    final layerIndex = session.activeLayerIndex;

    // Copy to clipboard
    clipboardManager.cut(
      layer: layer,
      bounds: bounds,
      layerIndex: layerIndex,
      canvasWidth: width,
      canvasHeight: height,
    );

    // Clear source pixels and record deltas
    final deltas = <PixelDelta>[];
    for (var y = bounds.top; y < bounds.bottom; y++) {
      for (var x = bounds.left; x < bounds.right; x++) {
        final oldPixel = layer.getPixel(x, y);
        if (!oldPixel.isEmpty) {
          deltas.add(PixelDelta(
            x: x,
            y: y,
            oldPixel: oldPixel,
            newPixel: Pixel.empty,
            layerIndex: layerIndex,
          ));
          layer.setPixel(x, y, Pixel.empty);
        }
      }
    }

    if (deltas.isNotEmpty) {
      historyManager.executeCommand(
        CutSelectionCommand(deltas: deltas),
        this,
      );
    }

    selectionEngine.clearSelection();
    compositeVisibleLayers();
  }

  /// Pastes clipboard data as a floating selection on the active layer.
  ///
  /// Creates a [FloatingSelection] at the original source bounds.
  /// The user can then move it before committing with [commitMoveSelection].
  void pasteSelection() {
    final clipData = clipboardManager.paste();
    if (clipData == null || clipData.isEmpty) return;
    if (!_isActiveLayerValid()) return;

    // If there's already a floating selection, commit it first
    if (_floatingSelection != null) {
      commitMoveSelection();
    }

    _floatingSelection = FloatingSelection(
      pixels: List<Pixel>.from(clipData.pixels),
      width: clipData.width,
      height: clipData.height,
      originalBounds: clipData.sourceBounds,
      sourceLayerIndex: session.activeLayerIndex,
    );

    selectionEngine.replaceSelection(
      SelectionRegion(bounds: clipData.sourceBounds),
    );

    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Move Operations
  // ---------------------------------------------------------------------------

  /// Begins moving the selected pixels on the active layer.
  ///
  /// Lifts pixels from the layer into a [FloatingSelection] and clears the
  /// source pixels. The source clearing is NOT pushed to history yet —
  /// history is only recorded on [commitMoveSelection].
  void beginMoveSelection() {
    if (!_validateSelectionOperation()) return;

    final bounds = selectionEngine.getSelection()!.bounds;
    final layer = grid.layers[session.activeLayerIndex];
    final layerIndex = session.activeLayerIndex;

    // Extract pixels and clear source
    final pixels = <Pixel>[];
    _moveSourceDeltas = [];

    for (var y = bounds.top; y < bounds.bottom; y++) {
      for (var x = bounds.left; x < bounds.right; x++) {
        final pixel = layer.getPixel(x, y);
        pixels.add(pixel);

        if (!pixel.isEmpty) {
          _moveSourceDeltas.add(PixelDelta(
            x: x,
            y: y,
            oldPixel: pixel,
            newPixel: Pixel.empty,
            layerIndex: layerIndex,
          ));
          layer.setPixel(x, y, Pixel.empty);
        }
      }
    }

    _floatingSelection = FloatingSelection(
      pixels: pixels,
      width: bounds.right - bounds.left,
      height: bounds.bottom - bounds.top,
      originalBounds: bounds,
      sourceLayerIndex: layerIndex,
    );

    compositeVisibleLayers();
  }

  /// Updates the floating selection's position by absolute offset from origin.
  ///
  /// [dx] and [dy] are the total offset from the original position.
  /// Pixel-perfect movement — no interpolation.
  void updateMoveSelection(int dx, int dy) {
    if (_floatingSelection == null) return;

    _floatingSelection!.offsetX = dx;
    _floatingSelection!.offsetY = dy;

    // Update the selection bounds to follow the floating selection
    selectionEngine.replaceSelection(
      SelectionRegion(bounds: _floatingSelection!.currentBounds),
    );

    notifyListeners();
  }

  /// Commits the floating selection to the active layer.
  ///
  /// Writes floating pixels at their destination position and pushes a single
  /// [MoveSelectionCommand] (or [PasteSelectionCommand]) to history.
  void commitMoveSelection() {
    if (_floatingSelection == null) return;
    if (!_isActiveLayerValid()) return;

    final floating = _floatingSelection!;
    final layer = grid.layers[session.activeLayerIndex];
    final layerIndex = session.activeLayerIndex;
    final destBounds = floating.currentBounds;

    // Write floating pixels to destination and record deltas
    final destDeltas = <PixelDelta>[];
    for (var localY = 0; localY < floating.height; localY++) {
      for (var localX = 0; localX < floating.width; localX++) {
        final pixel = floating.getPixel(localX, localY);
        if (pixel.isEmpty) continue;

        final canvasX = destBounds.left + localX;
        final canvasY = destBounds.top + localY;

        // Skip pixels outside canvas bounds
        if (canvasX < 0 || canvasX >= width ||
            canvasY < 0 || canvasY >= height) {
          continue;
        }

        final oldPixel = layer.getPixel(canvasX, canvasY);
        destDeltas.add(PixelDelta(
          x: canvasX,
          y: canvasY,
          oldPixel: oldPixel,
          newPixel: pixel,
          layerIndex: layerIndex,
        ));
        layer.setPixel(canvasX, canvasY, pixel);
      }
    }

    // Push the appropriate history command
    if (_moveSourceDeltas.isNotEmpty) {
      // This was a move operation
      historyManager.executeCommand(
        MoveSelectionCommand(
          sourceDeltas: _moveSourceDeltas,
          destDeltas: destDeltas,
        ),
        this,
      );
    } else if (destDeltas.isNotEmpty) {
      // This was a paste operation (no source clearing)
      historyManager.executeCommand(
        PasteSelectionCommand(deltas: destDeltas),
        this,
      );
    }

    // Update selection to the destination bounds
    final clampedBounds = destBounds.clampTo(width, height);
    if (clampedBounds.isValid) {
      selectionEngine.replaceSelection(
        SelectionRegion(bounds: clampedBounds),
      );
    } else {
      selectionEngine.clearSelection();
    }

    _floatingSelection = null;
    _moveSourceDeltas = [];
    compositeVisibleLayers();
  }

  /// Cancels the floating selection and restores source pixels.
  ///
  /// No history entry is created — the canvas returns to its pre-move state.
  void cancelMoveSelection() {
    if (_floatingSelection == null) return;

    // Restore source pixels from the move deltas
    for (final delta in _moveSourceDeltas) {
      if (delta.layerIndex >= 0 &&
          delta.layerIndex < grid.layers.length) {
        grid.layers[delta.layerIndex]
            .setPixel(delta.x, delta.y, delta.oldPixel);
      }
    }

    _floatingSelection = null;
    _moveSourceDeltas = [];
    compositeVisibleLayers();
  }

  // ---------------------------------------------------------------------------
  // Shape Operations
  // ---------------------------------------------------------------------------

  /// Begins a new shape preview drag at canvas pixel `(x, y)`.
  ///
  /// Shape drawing is rejected if active layer is locked or hidden.
  void beginShape(int x, int y) {
    if (!_isActiveLayerValid()) return;
    final layer = grid.layers[session.activeLayerIndex];
    if (layer.isLocked || !layer.isVisible) return;

    shapeEngine.settings = shapeEngine.settings.copyWith(
      color: session.activeColor,
    );
    shapeEngine.beginShape(x, y);
    notifyListeners();
  }

  /// Updates active shape preview destination to canvas pixel `(x, y)`.
  void updateShape(int x, int y) {
    shapeEngine.updateShape(x, y);
    notifyListeners();
  }

  /// Commits the active shape preview to the active layer.
  ///
  /// Plots points to layer buffer with selection clipping, creates a history
  /// command, and updates composited layers.
  void commitShape() {
    if (!shapeEngine.isDrawing) return;
    if (!_isActiveLayerValid()) {
      shapeEngine.cancelShape();
      notifyListeners();
      return;
    }

    final layer = grid.layers[session.activeLayerIndex];
    if (layer.isLocked || !layer.isVisible) {
      shapeEngine.cancelShape();
      notifyListeners();
      return;
    }

    final points = shapeEngine.getShapePoints();
    final activeType = shapeEngine.settings.type;
    final activeColor = session.activeColor;
    final selectionRegion = selectionEngine.getSelection();

    final deltas = ShapeRenderer.drawShapePoints(
      layer: layer,
      points: points,
      color: activeColor,
      layerIndex: session.activeLayerIndex,
      selectionRegion: selectionRegion,
    );

    if (deltas.isNotEmpty) {
      HistoryCommand command;
      switch (activeType) {
        case ShapeType.line:
          command = LineCommand(deltas: deltas);
        case ShapeType.rectangle:
          command = RectangleCommand(deltas: deltas);
        case ShapeType.circle:
          command = CircleCommand(deltas: deltas);
        case ShapeType.ellipse:
          command = EllipseCommand(deltas: deltas);
      }
      historyManager.executeCommand(command, this);
    }

    shapeEngine.commitShape();
    compositeVisibleLayers();
  }

  /// Cancels active shape drag interaction.
  void cancelShape() {
    shapeEngine.cancelShape();
    notifyListeners();
  }

  /// Sets the active shape type.
  void setShapeType(ShapeType type) {
    shapeEngine.settings = shapeEngine.settings.copyWith(type: type);
    notifyListeners();
  }

  /// Sets the active shape fill mode.
  void setShapeFillMode(ShapeFillMode fillMode) {
    shapeEngine.settings = shapeEngine.settings.copyWith(fillMode: fillMode);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Transform Operations
  // ---------------------------------------------------------------------------

  /// Begins a transformation session for the active selection.
  ///
  /// Lifts pixels into floating selection if not already floating.
  void beginTransform() {
    if (!_validateSelectionOperation()) return;

    if (_floatingSelection == null) {
      beginMoveSelection();
    }

    if (_floatingSelection != null) {
      transformEngine.beginTransform(_floatingSelection!);
      notifyListeners();
    }
  }

  /// Updates active transform preview drag destination.
  void updateTransform() {
    notifyListeners();
  }

  /// Commits the active transformation to the canvas layer.
  void commitTransform() {
    if (!hasActiveTransform) return;

    final preview = transformEngine.commitTransform();
    if (preview != null) {
      commitMoveSelection();
    }
  }

  /// Cancels active transformation, restoring original source pixels.
  void cancelTransform() {
    if (!hasActiveTransform) return;

    transformEngine.cancelTransform();
    cancelMoveSelection();
  }

  /// Rotates selection 90 degrees Clockwise.
  void rotateClockwise() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.rotateClockwise();
    _syncTransformSelection();
  }

  /// Rotates selection 90 degrees Counter-Clockwise.
  void rotateCounterClockwise() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.rotateCounterClockwise();
    _syncTransformSelection();
  }

  /// Rotates selection 180 degrees.
  void rotate180() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.rotate180();
    _syncTransformSelection();
  }

  /// Flips selection horizontally.
  void flipHorizontal() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.flipHorizontal();
    _syncTransformSelection();
  }

  /// Flips selection vertically.
  void flipVertical() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.flipVertical();
    _syncTransformSelection();
  }

  /// Mirrors horizontal left half to right half.
  void mirrorHorizontal() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.mirrorHorizontal();
    _syncTransformSelection();
  }

  /// Mirrors vertical top half to bottom half.
  void mirrorVertical() {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.mirrorVertical();
    _syncTransformSelection();
  }

  /// Scales selection to [newWidth] × [newHeight] using Nearest-Neighbor sampling.
  void scaleSelection(int newWidth, int newHeight) {
    _ensureTransformStarted();
    if (!hasActiveTransform) return;

    transformEngine.scaleSelection(newWidth, newHeight);
    _syncTransformSelection();
  }

  void _ensureTransformStarted() {
    if (!hasActiveTransform && hasSelection) {
      beginTransform();
    }
  }

  void _syncTransformSelection() {
    if (_floatingSelection != null) {
      selectionEngine.replaceSelection(
        SelectionRegion(bounds: _floatingSelection!.currentBounds),
      );
    }
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Import Operations
  // ---------------------------------------------------------------------------

  /// Decodes and initializes an image import session for [bytes].
  void importImage(Uint8List bytes, [ImportSettings? settings]) {
    importEngine.importImage(
      bytes: bytes,
      canvasWidth: width,
      canvasHeight: height,
      settings: settings,
    );
    notifyListeners();
  }

  /// Re-processes active import preview with updated [settings].
  void previewImport(ImportSettings settings) {
    importEngine.updateSettings(
      settings: settings,
      canvasWidth: width,
      canvasHeight: height,
    );
    notifyListeners();
  }

  /// Commits the active import preview to the canvas layer stack.
  void commitImport() {
    if (!hasActiveImport) return;

    final preview = importEngine.commitImport();
    if (preview == null || preview.isCorrupted) return;

    switch (preview.settings.destination) {
      case ImportDestination.newLayer:
        createLayer();
        final newIndex = grid.layers.length - 1;
        final layer = grid.layers[newIndex];

        final deltas = <PixelDelta>[];
        for (var y = 0; y < preview.targetHeight; y++) {
          for (var x = 0; x < preview.targetWidth; x++) {
            final pixel = preview.getPixel(x, y);
            if (!pixel.isEmpty && x < width && y < height) {
              deltas.add(PixelDelta(
                x: x,
                y: y,
                oldPixel: Pixel.empty,
                newPixel: pixel,
                layerIndex: newIndex,
              ));
              layer.setPixel(x, y, pixel);
            }
          }
        }

        historyManager.executeCommand(
          ImportCommand(
            destination: ImportDestination.newLayer,
            createdLayerIndex: newIndex,
            deltas: deltas,
          ),
          this,
        );
        break;

      case ImportDestination.replaceActive:
        if (!_isActiveLayerValid()) return;
        final layer = grid.layers[session.activeLayerIndex];
        if (layer.isLocked) return;

        final deltas = <PixelDelta>[];
        for (var y = 0; y < preview.targetHeight; y++) {
          for (var x = 0; x < preview.targetWidth; x++) {
            final pixel = preview.getPixel(x, y);
            if (x < width && y < height) {
              final oldPixel = layer.getPixel(x, y);
              deltas.add(PixelDelta(
                x: x,
                y: y,
                oldPixel: oldPixel,
                newPixel: pixel,
                layerIndex: session.activeLayerIndex,
              ));
              layer.setPixel(x, y, pixel);
            }
          }
        }

        historyManager.executeCommand(
          ImportCommand(
            destination: ImportDestination.replaceActive,
            deltas: deltas,
          ),
          this,
        );
        break;

      case ImportDestination.newCanvas:
        final prevW = width;
        final prevH = height;
        final prevLayers = grid.layers.map((l) => l.clone()).toList();

        resizeCanvas(preview.targetWidth, preview.targetHeight);
        final baseLayer = grid.layers.first;
        baseLayer.clear();

        for (var y = 0; y < preview.targetHeight; y++) {
          for (var x = 0; x < preview.targetWidth; x++) {
            baseLayer.setPixel(x, y, preview.getPixel(x, y));
          }
        }

        historyManager.executeCommand(
          ImportCommand(
            destination: ImportDestination.newCanvas,
            previousWidth: prevW,
            previousHeight: prevH,
            previousLayers: prevLayers,
          ),
          this,
        );
        break;
    }

    compositeVisibleLayers();
  }

  /// Cancels the active import session and clears preview.
  void cancelImport() {
    importEngine.cancelImport();
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Sprite Sheet & Frame Operations
  // ---------------------------------------------------------------------------

  /// Imports sprite sheet PNG [bytes] and slices grid automatically.
  void importSpriteSheet(Uint8List bytes, [SpriteSheetSettings? settings]) {
    final prevSheet = spriteSheetEngine.sheet;
    final newSheet = spriteSheetEngine.importSpriteSheet(
      bytes: bytes,
      id: 'sheet_${DateTime.now().millisecondsSinceEpoch}',
      name: 'SpriteSheet',
      settings: settings ?? const SpriteSheetSettings(),
    );

    if (newSheet != null) {
      historyManager.executeCommand(
        ImportSpriteSheetCommand(
          previousSheet: prevSheet,
          newSheet: newSheet,
        ),
        this,
      );
      notifyListeners();
    }
  }

  /// Performs automatic grid slicing on composite canvas buffer.
  void sliceSpriteSheet(SpriteSheetSettings settings) {
    grid.recomposite();
    final canvasPixels = grid.compositeBuffer.pixels;

    final prevSheet = spriteSheetEngine.sheet;
    spriteSheetEngine.sliceGrid(
      canvasPixels: canvasPixels,
      canvasWidth: width,
      canvasHeight: height,
      settings: settings,
    );

    final newSheet = spriteSheetEngine.sheet;
    if (newSheet != null) {
      historyManager.executeCommand(
        ImportSpriteSheetCommand(
          previousSheet: prevSheet,
          newSheet: newSheet,
        ),
        this,
      );
      notifyListeners();
    }
  }

  /// Manually creates a new frame from selection [bounds].
  void createFrame(SelectionBounds bounds, [String? name]) {
    grid.recomposite();
    final canvasPixels = grid.compositeBuffer.pixels;

    final created = spriteSheetEngine.createFrame(
      canvasPixels: canvasPixels,
      canvasWidth: width,
      canvasHeight: height,
      bounds: bounds,
      name: name,
    );

    historyManager.executeCommand(
      CreateFrameCommand(
        createdFrame: created,
        insertedIndex: spriteSheetEngine.activeFrameIndex,
      ),
      this,
    );

    notifyListeners();
  }

  /// Duplicates frame at [frameIndex].
  void duplicateFrame(int frameIndex) {
    final duplicated = spriteSheetEngine.duplicateFrame(frameIndex);
    if (duplicated != null) {
      historyManager.executeCommand(
        DuplicateFrameCommand(
          duplicatedFrame: duplicated,
          insertedIndex: frameIndex + 1,
        ),
        this,
      );
      notifyListeners();
    }
  }

  /// Deletes frame at [frameIndex].
  void deleteFrame(int frameIndex) {
    final deleted = spriteSheetEngine.deleteFrame(frameIndex);
    if (deleted != null) {
      historyManager.executeCommand(
        DeleteFrameCommand(
          deletedFrame: deleted,
          deletedIndex: frameIndex,
        ),
        this,
      );
      notifyListeners();
    }
  }

  /// Renames frame at [frameIndex] to [newName].
  void renameFrame(int frameIndex, String newName) {
    final activeSheet = spriteSheetEngine.sheet;
    if (activeSheet != null &&
        frameIndex >= 0 &&
        frameIndex < activeSheet.frames.length) {
      final oldName = activeSheet.frames[frameIndex].metadata.name;
      spriteSheetEngine.renameFrame(frameIndex, newName);

      historyManager.executeCommand(
        RenameFrameCommand(
          frameIndex: frameIndex,
          oldName: oldName,
          newName: newName,
        ),
        this,
      );

      notifyListeners();
    }
  }

  /// Reorders frame from [oldIndex] to [newIndex].
  void reorderFrame(int oldIndex, int newIndex) {
    spriteSheetEngine.reorderFrame(oldIndex, newIndex);
    historyManager.executeCommand(
      ReorderFrameCommand(oldIndex: oldIndex, newIndex: newIndex),
      this,
    );
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Animation Timeline & Playback Operations
  // ---------------------------------------------------------------------------

  /// Creates a new animation clip [name].
  void createAnimation(String name, [List<AnimationFrame>? frames]) {
    final created = animationEngine.createAnimation(name, frames);
    historyManager.executeCommand(
      CreateAnimationCommand(
        createdClip: created,
        insertedIndex: animationEngine.timeline.clips.length - 1,
      ),
      this,
    );
    notifyListeners();
  }

  /// Deletes animation clip by [clipId].
  void deleteAnimation(String clipId) {
    final idx = animationEngine.timeline.clips.indexWhere((c) => c.id == clipId);
    if (idx >= 0) {
      final deleted = animationEngine.deleteAnimation(clipId);
      if (deleted != null) {
        historyManager.executeCommand(
          DeleteAnimationCommand(
            deletedClip: deleted,
            deletedIndex: idx,
          ),
          this,
        );
        notifyListeners();
      }
    }
  }

  /// Duplicates animation clip by [clipId].
  void duplicateAnimation(String clipId) {
    final duplicated = animationEngine.duplicateAnimation(clipId);
    if (duplicated != null) {
      historyManager.executeCommand(
        DuplicateAnimationCommand(
          duplicatedClip: duplicated,
          insertedIndex: animationEngine.timeline.activeClipIndex,
        ),
        this,
      );
      notifyListeners();
    }
  }

  /// Renames animation clip by [clipId] to [newName].
  void renameAnimation(String clipId, String newName) {
    final clip = animationEngine.timeline.clips.firstWhere(
      (c) => c.id == clipId,
      orElse: () => animationEngine.timeline.clips.first,
    );
    final oldName = clip.name;
    animationEngine.renameAnimation(clipId, newName);

    historyManager.executeCommand(
      RenameAnimationCommand(
        clipId: clipId,
        oldName: oldName,
        newName: newName,
      ),
      this,
    );

    notifyListeners();
  }

  /// Starts animation playback.
  void playAnimation() {
    animationEngine.play();
    notifyListeners();
  }

  /// Pauses animation playback.
  void pauseAnimation() {
    animationEngine.pause();
    notifyListeners();
  }

  /// Stops animation playback and resets playhead.
  void stopAnimation() {
    animationEngine.stop();
    notifyListeners();
  }

  /// Seeks playhead directly to [frameIndex].
  void seekFrame(int frameIndex) {
    final prevIdx = animationEngine.currentFrameIndex;
    animationEngine.seekFrame(frameIndex);
    historyManager.executeCommand(
      TimelineCommand(
        description: 'Seek Playhead',
        previousFrameIndex: prevIdx,
        newFrameIndex: frameIndex,
      ),
      this,
    );
    notifyListeners();
  }

  /// Steps to next animation frame.
  void nextAnimationFrame() {
    animationEngine.nextFrame();
    notifyListeners();
  }

  /// Steps to previous animation frame.
  void previousAnimationFrame() {
    animationEngine.previousFrame();
    notifyListeners();
  }

  /// Updates animation playback FPS rate.
  void setFPS(int fps) {
    final prevSettings = animationEngine.settings;
    animationEngine.setFPS(fps);

    historyManager.executeCommand(
      PlaybackSettingsCommand(
        previousSettings: prevSettings,
        newSettings: animationEngine.settings,
      ),
      this,
    );

    notifyListeners();
  }

  /// Updates animation playback loop mode.
  void setLoopMode(LoopMode loopMode) {
    final prevSettings = animationEngine.settings;
    animationEngine.setLoopMode(loopMode);

    historyManager.executeCommand(
      PlaybackSettingsCommand(
        previousSettings: prevSettings,
        newSettings: animationEngine.settings,
      ),
      this,
    );

    notifyListeners();
  }

  /// Toggles onion skin translucent frame overlay.
  void toggleOnionSkin([bool? enabled]) {
    final prevSettings = animationEngine.settings;
    animationEngine.toggleOnionSkin(enabled);

    historyManager.executeCommand(
      PlaybackSettingsCommand(
        previousSettings: prevSettings,
        newSettings: animationEngine.settings,
      ),
      this,
    );

    notifyListeners();
  }

  /// Advances animation playback ticker by [deltaMs] milliseconds.
  void tickAnimation(int deltaMs) {
    animationEngine.tick(deltaMs);
    notifyListeners();
  }

  // ---------------------------------------------------------------------------
  // Project Serialization Operations
  // ---------------------------------------------------------------------------

  /// Serializes active project state to a JSON string (.pixelcanvas).
  String saveProjectJson() {
    return ProjectSerializer.serialize(this);
  }

  /// Deserializes and loads [jsonString] project into canvas engine.
  bool loadProjectJson(String jsonString) {
    final success = ProjectDeserializer.deserialize(jsonString, this);
    if (success) {
      notifyListeners();
    }
    return success;
  }

  // ---------------------------------------------------------------------------
  // Private Helpers
  // ---------------------------------------------------------------------------

  /// Validates that a selection operation can proceed.
  ///
  /// Returns true if: selection exists, active layer is valid, not locked,
  /// and visible.
  bool _validateSelectionOperation() {
    if (!selectionEngine.hasSelection) return false;
    if (!_isActiveLayerValid()) return false;

    final layer = grid.layers[session.activeLayerIndex];
    if (layer.isLocked) return false;
    if (!layer.isVisible) return false;

    return true;
  }

  /// Returns true if the active layer index is within range.
  bool _isActiveLayerValid() {
    return session.activeLayerIndex >= 0 &&
        session.activeLayerIndex < grid.layers.length;
  }
}

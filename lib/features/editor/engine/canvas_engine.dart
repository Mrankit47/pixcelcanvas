import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/editor/engine/brush/brush_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_viewport_controller.dart';
import 'package:pixelcanvas/features/editor/engine/commands/draw_commands.dart';
import 'package:pixelcanvas/features/editor/engine/commands/pixel_delta.dart';
import 'package:pixelcanvas/features/editor/engine/drawing_session.dart';
import 'package:pixelcanvas/features/editor/engine/eraser/eraser_renderer.dart';
import 'package:pixelcanvas/features/editor/engine/export/export_engine.dart';
import 'package:pixelcanvas/features/editor/engine/export/models/export_settings.dart';
import 'package:pixelcanvas/features/editor/engine/fill/flood_fill_engine.dart';
import 'package:pixelcanvas/features/editor/engine/history/history_manager.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_factory.dart';
import 'package:pixelcanvas/features/editor/engine/layers/layer_manager.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/eraser_settings.dart';
import 'package:pixelcanvas/features/editor/engine/models/fill_settings.dart';
import 'package:pixelcanvas/features/editor/engine/picker/color_sampler.dart';
import 'package:pixelcanvas/features/editor/engine/pixel.dart';
import 'package:pixelcanvas/features/editor/engine/pixel_grid.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/brush_stroke.dart';
import 'package:pixelcanvas/features/editor/engine/stroke/stroke_point.dart';
import 'package:pixelcanvas/features/editor/engine/tools/brush_tool.dart';
import 'package:pixelcanvas/features/editor/engine/tools/eraser_tool.dart';

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

  CommandBatch? _activeBatch;

  /// Width in pixels.
  int get width => grid.width;

  /// Height in pixels.
  int get height => grid.height;

  /// True if undo action is available.
  bool get canUndo => historyManager.canUndo;

  /// True if redo action is available.
  bool get canRedo => historyManager.canRedo;

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

      if (oldPixel.color.toARGB32() == fillColor.toARGB32()) return;

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
}

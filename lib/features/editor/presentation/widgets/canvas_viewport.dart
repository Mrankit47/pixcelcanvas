import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/engine/shapes/models/shape_settings.dart';
import 'package:pixelcanvas/features/editor/presentation/controllers/editor_controller.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/pixel_canvas_painter.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_radius.dart';
import 'package:pixelcanvas/theme/app_shadows.dart';

/// Riverpod Provider instantiating single [CanvasEngine] per editor session.
final canvasEngineProvider = Provider<CanvasEngine>((ref) {
  return CanvasEngine(width: 32, height: 32);
});

/// Interactive Canvas Viewport Component per Blueprint §5.1 & §8.1.
///
/// **Purpose**: Centered canvas box supporting continuous brush, pencil, eraser, fill, and eyedropper gestures.
/// **History Integration**: Syncs [EditorController] canUndo/canRedo flags after each stroke completion.
class CanvasViewport extends ConsumerStatefulWidget {
  /// Creates a [CanvasViewport].
  const CanvasViewport({
    this.onCursorHover,
    super.key,
  });

  /// Hover callback emitting current canvas pixel coordinates `(x, y)`.
  final ValueChanged<Point<int>?>? onCursorHover;

  @override
  ConsumerState<CanvasViewport> createState() => _CanvasViewportState();
}

class _CanvasViewportState extends ConsumerState<CanvasViewport> {
  late final TransformationController _transformationController;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorControllerProvider);
    final engine = ref.watch(canvasEngineProvider);

    // Sync settings to engine
    final colorHex = editorState.activeColorHex.replaceFirst('#', '');
    final activeColor = Color(
      int.parse(colorHex, radix: 16) | 0xFF000000,
    );
    engine.session.activeColor = activeColor;
    engine.session.activeTool = editorState.selectedTool;
    engine.brushSettings = editorState.brushSettings;
    engine.eraserSettings = editorState.eraserSettings;

    // Synchronize zoom controller scale programmatically
    final zoom = editorState.zoomLevel;
    _transformationController.value = Matrix4.identity()..scale(zoom);

    /// Helper: sync history flags to EditorController after mutation.
    void syncHistory() {
      ref.read(editorControllerProvider.notifier).updateHistoryState(engine);
    }

    final isDrawingTool = editorState.selectedTool != PixelTool.select;

    return Center(
      child: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(200),
        minScale: 0.5,
        maxScale: 8.0,
        panEnabled: !isDrawingTool,
        scaleEnabled: !isDrawingTool,
        child: MouseRegion(
          onHover: (event) {
            final point = _hitTest(event.localPosition, engine);
            widget.onCursorHover?.call(point);
          },
          onExit: (_) {
            widget.onCursorHover?.call(null);
          },
          child: Container(
            width: 384,
            height: 384,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: AppRadius.borderSm,
              boxShadow: AppShadows.md,
            ),
            child: GestureDetector(
              onTapDown: (details) {
                final point = _hitTest(details.localPosition, engine);
                if (point == null) return;

                switch (editorState.selectedTool) {
                  case PixelTool.fill:
                    engine.beginFill(point.x, point.y, activeColor);
                    syncHistory();
                    break;
                  case PixelTool.eyedropper:
                    final sampledColor = engine.sampleColor(point.x, point.y);
                    final argbHex = sampledColor.value.toRadixString(16).padLeft(8, '0');
                    final hex = '#${argbHex.substring(2).toUpperCase()}';
                    ref.read(editorControllerProvider.notifier).setActiveColor(hex);
                    break;
                  case PixelTool.pencil:
                  case PixelTool.brush:
                    engine.plotPixel(point.x, point.y, activeColor);
                    syncHistory();
                    break;
                  case PixelTool.eraser:
                    engine.erasePixel(point.x, point.y);
                    syncHistory();
                    break;
                  case PixelTool.line:
                    engine.setShapeType(ShapeType.line);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.rectangle:
                    engine.setShapeType(ShapeType.rectangle);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.circle:
                    engine.setShapeType(ShapeType.circle);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.select:
                    engine.beginSelection(point.x, point.y);
                    break;
                  case PixelTool.move:
                    engine.beginMoveSelection();
                    break;
                  case PixelTool.text:
                    engine.plotPixel(point.x, point.y, activeColor);
                    syncHistory();
                    break;
                }
              },
              onPanStart: (details) {
                final point = _hitTest(details.localPosition, engine);
                if (point == null) return;

                switch (editorState.selectedTool) {
                  case PixelTool.eraser:
                    engine.beginErase(point.x, point.y);
                    break;
                  case PixelTool.pencil:
                  case PixelTool.brush:
                    engine.beginStroke(point.x, point.y);
                    break;
                  case PixelTool.line:
                    engine.setShapeType(ShapeType.line);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.rectangle:
                    engine.setShapeType(ShapeType.rectangle);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.circle:
                    engine.setShapeType(ShapeType.circle);
                    engine.beginShape(point.x, point.y);
                    break;
                  case PixelTool.select:
                    engine.beginSelection(point.x, point.y);
                    break;
                  case PixelTool.move:
                    engine.beginMoveSelection();
                    break;
                  default:
                    break;
                }
              },
              onPanUpdate: (details) {
                final point = _hitTest(details.localPosition, engine);
                if (point == null) return;

                switch (editorState.selectedTool) {
                  case PixelTool.eraser:
                    engine.continueErase(point.x, point.y);
                    break;
                  case PixelTool.pencil:
                  case PixelTool.brush:
                    engine.continueStroke(point.x, point.y);
                    break;
                  case PixelTool.line:
                  case PixelTool.rectangle:
                  case PixelTool.circle:
                    engine.updateShape(point.x, point.y);
                    break;
                  case PixelTool.select:
                    engine.selectionEngine.updateSelection(point.x, point.y);
                    engine.notifyListeners();
                    break;
                  case PixelTool.move:
                    engine.updateMoveSelection(1, 1);
                    break;
                  default:
                    break;
                }
              },
              onPanEnd: (_) {
                switch (editorState.selectedTool) {
                  case PixelTool.eraser:
                    engine.endErase();
                    break;
                  case PixelTool.pencil:
                  case PixelTool.brush:
                    engine.endStroke();
                    break;
                  case PixelTool.line:
                  case PixelTool.rectangle:
                  case PixelTool.circle:
                    engine.commitShape();
                    break;
                  case PixelTool.select:
                    engine.selectionEngine.endSelection();
                    break;
                  case PixelTool.move:
                    engine.commitMoveSelection();
                    break;
                  default:
                    break;
                }
                syncHistory();
              },
              child: CustomPaint(
                size: const Size(384, 384),
                painter: PixelCanvasPainter(
                  engine: engine,
                  showGrid: editorState.showGrid,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Converts screen position to canvas pixel coordinate.
  Point<int>? _hitTest(Offset localPosition, CanvasEngine engine) {
    return CoordinateTransformer.screenToCanvas(
      screenOffset: localPosition,
      panOffset: Offset.zero,
      zoomLevel: 1.0,
      cellSize: 384 / engine.width,
      canvasWidth: engine.width,
      canvasHeight: engine.height,
    );
  }
}

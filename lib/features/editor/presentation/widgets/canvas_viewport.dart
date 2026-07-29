import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
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
  const CanvasViewport({super.key});

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

    // Disable InteractiveViewer gestures when actively drawing to prevent conflict
    final isDrawingTool = editorState.selectedTool == PixelTool.pencil ||
        editorState.selectedTool == PixelTool.brush ||
        editorState.selectedTool == PixelTool.eraser ||
        editorState.selectedTool == PixelTool.fill ||
        editorState.selectedTool == PixelTool.eyedropper;

    return Center(
      child: InteractiveViewer(
        transformationController: _transformationController,
        boundaryMargin: const EdgeInsets.all(200),
        minScale: 0.5,
        maxScale: 8.0,
        panEnabled: !isDrawingTool,
        scaleEnabled: !isDrawingTool,
        child: Container(
          width: 384,
          height: 384,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.borderSm,
            boxShadow: AppShadows.md,
          ),
          child: GestureDetector(
            onTapDown: (details) {
              final point = _hitTest(details.localPosition, engine);
              if (point == null) return;

              if (editorState.selectedTool == PixelTool.fill) {
                engine.beginFill(point.x, point.y, activeColor);
                syncHistory();
              } else if (editorState.selectedTool == PixelTool.eyedropper) {
                final sampledColor = engine.sampleColor(point.x, point.y);
                final argbHex = sampledColor.toARGB32().toRadixString(16).padLeft(8, '0');
                final hex = '#${argbHex.substring(2).toUpperCase()}';
                ref.read(editorControllerProvider.notifier).setActiveColor(hex);
              } else if (editorState.selectedTool == PixelTool.pencil ||
                  editorState.selectedTool == PixelTool.brush) {
                engine.plotPixel(point.x, point.y, activeColor);
                syncHistory();
              } else if (editorState.selectedTool == PixelTool.eraser) {
                engine.erasePixel(point.x, point.y);
                syncHistory();
              }
            },
            onPanStart: (details) {
              final point = _hitTest(details.localPosition, engine);
              if (point == null) return;

              if (editorState.selectedTool == PixelTool.eraser) {
                engine.beginErase(point.x, point.y);
              } else if (editorState.selectedTool == PixelTool.pencil ||
                  editorState.selectedTool == PixelTool.brush) {
                engine.beginStroke(point.x, point.y);
              }
            },
            onPanUpdate: (details) {
              final point = _hitTest(details.localPosition, engine);
              if (point == null) return;

              if (editorState.selectedTool == PixelTool.eraser) {
                engine.continueErase(point.x, point.y);
              } else if (editorState.selectedTool == PixelTool.pencil ||
                  editorState.selectedTool == PixelTool.brush) {
                engine.continueStroke(point.x, point.y);
              }
            },
            onPanEnd: (_) {
              if (editorState.selectedTool == PixelTool.eraser) {
                engine.endErase();
              } else if (editorState.selectedTool == PixelTool.pencil ||
                  editorState.selectedTool == PixelTool.brush) {
                engine.endStroke();
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

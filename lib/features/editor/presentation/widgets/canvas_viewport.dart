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
/// **Consumed Providers**: [editorControllerProvider], [canvasEngineProvider]
class CanvasViewport extends ConsumerWidget {
  /// Creates a [CanvasViewport].
  const CanvasViewport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editorState = ref.watch(editorControllerProvider);
    final engine = ref.watch(canvasEngineProvider);

    // Sync settings to engine
    final activeColor = Color(
      int.parse(editorState.activeColorHex.replaceFirst('#', '0xFF')),
    );
    engine.session.activeColor = activeColor;
    engine.session.activeTool = editorState.selectedTool;
    engine.brushSettings = editorState.brushSettings;
    engine.eraserSettings = editorState.eraserSettings;

    /// Helper: sync history flags to EditorController after mutation.
    void syncHistory() {
      ref.read(editorControllerProvider.notifier).updateHistoryState(engine);
    }

    return Center(
      child: InteractiveViewer(
        boundaryMargin: const EdgeInsets.all(200),
        minScale: 0.5,
        maxScale: 8.0,
        child: Container(
          width: 384,
          height: 384,
          decoration: const BoxDecoration(
            color: AppColors.surface,
            borderRadius: AppRadius.borderSm,
            boxShadow: [AppShadows.elevationMd],
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
                final hex = '#${sampledColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';
                ref.read(editorControllerProvider.notifier).setActiveColor(hex);
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

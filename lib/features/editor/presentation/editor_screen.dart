import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/editor/engine/models/brush_settings.dart';
import 'package:pixelcanvas/features/editor/presentation/controllers/editor_controller.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/bottom_status_bar.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/canvas_viewport.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/floating_zoom_controls.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/left_toolbar.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/right_inspector.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/top_action_bar.dart';
import 'package:pixelcanvas/theme/app_colors.dart';
import 'package:pixelcanvas/theme/app_spacing.dart';

/// Master Editor Workspace Screen integrating all sub-engines per Blueprint §5.1 & §8.2.
///
/// **Purpose**: Responsive studio workspace layout composing CanvasViewport, LeftToolbar, RightInspector, TopActionBar, and FloatingZoomControls.
/// **Consumed Providers**: [editorControllerProvider], [canvasEngineProvider]
class EditorScreen extends ConsumerStatefulWidget {
  /// Creates an [EditorScreen].
  const EditorScreen({this.projectId = 'new', super.key});

  /// Active project ID.
  final String projectId;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final engine = ref.read(canvasEngineProvider);
      ref.read(editorControllerProvider.notifier).syncEngineState(engine);
    });
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorControllerProvider);
    final controller = ref.read(editorControllerProvider.notifier);
    final engine = ref.watch(canvasEngineProvider);

    return Scaffold(
      backgroundColor: AppColors.neutral50,
      body: SafeArea(
        child: Column(
          children: [
            TopActionBar(
              projectName: 'Untitled 32x32',
              onBack: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.go('/home');
                }
              },
              onUndo: editorState.canUndo
                  ? () {
                      engine.undo();
                      controller.updateHistoryState(engine);
                    }
                  : null,
              onRedo: editorState.canRedo
                  ? () {
                      engine.redo();
                      controller.updateHistoryState(engine);
                    }
                  : null,
              onExport: () {},
              onShare: () {},
            ),
            Expanded(
              child: Row(
                children: [
                  LeftToolbar(
                    selectedTool: editorState.selectedTool.name,
                    onToolSelected: (toolName) {
                      final tool = PixelTool.values.firstWhere(
                        (t) => t.name.toLowerCase() == toolName.toLowerCase(),
                        orElse: () => PixelTool.pencil,
                      );
                      controller.selectTool(tool);
                      controller.syncEngineState(engine);
                    },
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        const CanvasViewport(),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingZoomControls(
                            onZoomIn: () {
                              controller.setZoom(editorState.zoomLevel + 0.5);
                              controller.syncEngineState(engine);
                            },
                            onZoomOut: () {
                              controller.setZoom(editorState.zoomLevel - 0.5);
                              controller.syncEngineState(engine);
                            },
                            onZoomReset: () {
                              controller.setZoom(1.0);
                              controller.syncEngineState(engine);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const RightInspector(),
                ],
              ),
            ),
            BottomStatusBar(
              cursorCoordinates: 'X: 12, Y: 18',
              canvasDimensions: '32 × 32 px',
              zoomLevel: '${(editorState.zoomLevel * 100).toInt()}%',
            ),
          ],
        ),
      ),
    );
  }
}

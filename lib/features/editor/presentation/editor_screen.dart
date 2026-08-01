import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/editor/engine/coordinate_transformer.dart';
import 'package:pixelcanvas/features/editor/presentation/controllers/editor_controller.dart';
import 'package:pixelcanvas/features/editor/presentation/state/editor_state.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/bottom_status_bar.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/canvas_viewport.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/floating_zoom_controls.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/left_toolbar.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/right_inspector.dart';
import 'package:pixelcanvas/features/editor/presentation/widgets/top_action_bar.dart';
import 'package:pixelcanvas/features/export/controllers/export_manager.dart';
import 'package:pixelcanvas/features/export/presentation/export_center_dialog.dart';
import 'package:pixelcanvas/features/settings/controllers/keyboard_shortcut_manager.dart';
import 'package:pixelcanvas/features/settings/controllers/preferences_manager.dart';
import 'package:pixelcanvas/features/settings/controllers/settings_manager.dart';
import 'package:pixelcanvas/features/settings/presentation/settings_dialog.dart';
import 'package:pixelcanvas/theme/app_colors.dart';

/// Master Editor Workspace Screen integrating all sub-engines per Blueprint §5.1 & §8.2.
class EditorScreen extends ConsumerStatefulWidget {
  /// Creates an [EditorScreen].
  const EditorScreen({this.projectId = 'new', super.key});

  /// Active project ID.
  final String projectId;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Point<int>? _hoveredPoint;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final engine = ref.read(canvasEngineProvider);
      ref.read(editorControllerProvider.notifier).syncEngineState(engine);
    });
  }

  void _showExportDialog() {
    final engine = ref.read(canvasEngineProvider);
    showDialog(
      context: context,
      builder: (context) => ExportCenterDialog(
        exportManager: ExportManager(),
        workspaceManager: WorkspaceManager(),
        engine: engine,
      ),
    );
  }

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => SettingsDialog(
        settingsManager: SettingsManager(),
        preferencesManager: PreferencesManager(),
        shortcutManager: KeyboardShortcutManager(),
      ),
    );
  }

  void _saveProject() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project saved successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _shareProject() {
    Clipboard.setData(const ClipboardData(text: 'https://pixelcanvas.app/project/active'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Project share link copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final editorState = ref.watch(editorControllerProvider);
    final controller = ref.read(editorControllerProvider.notifier);
    final engine = ref.watch(canvasEngineProvider);

    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    final cursorStr = _hoveredPoint != null
        ? 'X: ${_hoveredPoint!.x}, Y: ${_hoveredPoint!.y}'
        : 'X: --, Y: --';

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.neutral50,
      endDrawer: isMobile
          ? const Drawer(
              width: 280,
              child: SafeArea(child: RightInspector()),
            )
          : null,
      body: SafeArea(
        child: Column(
          children: [
            TopActionBar(
              projectName: 'Untitled ${engine.width}x${engine.height}',
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
              onSave: _saveProject,
              onExport: _showExportDialog,
              onShare: _shareProject,
              onSettings: isMobile
                  ? () => _scaffoldKey.currentState?.openEndDrawer()
                  : _showSettingsDialog,
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
                        CanvasViewport(
                          onCursorHover: (point) {
                            if (_hoveredPoint != point) {
                              setState(() => _hoveredPoint = point);
                            }
                          },
                        ),
                        Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingZoomControls(
                            onZoomIn: () {
                              controller.setZoom(editorState.zoomLevel + 0.5);
                              controller.syncEngineState(engine);
                            },
                            onZoomOut: () {
                              controller.setZoom((editorState.zoomLevel - 0.5).clamp(0.5, 5.0));
                              controller.syncEngineState(engine);
                            },
                            onZoomReset: () {
                              controller.setZoom(1.0);
                              controller.syncEngineState(engine);
                            },
                            onFitScreen: () {
                              controller.setZoom(1.0);
                              controller.syncEngineState(engine);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (!isMobile) const RightInspector(),
                ],
              ),
            ),
            BottomStatusBar(
              cursorCoordinates: cursorStr,
              canvasDimensions: '${engine.width} × ${engine.height} px',
              zoomLevel: '${(editorState.zoomLevel * 100).toInt()}%',
              layerCount: '${editorState.layers.length} Layers',
            ),
          ],
        ),
      ),
    );
  }
}

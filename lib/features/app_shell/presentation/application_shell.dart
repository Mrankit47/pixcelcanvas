import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/navigation_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/responsive_layout_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/sidebar_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/status_bar_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/top_toolbar_manager.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/app_shell/presentation/widgets/command_palette.dart';
import 'package:pixelcanvas/features/app_shell/presentation/widgets/sidebar_view.dart';
import 'package:pixelcanvas/features/app_shell/presentation/widgets/status_bar_view.dart';
import 'package:pixelcanvas/features/app_shell/presentation/widgets/top_toolbar_view.dart';

/// Main Application Shell UI Layout per Blueprint §6.1.
///
/// **Layout Hierarchy**:
/// +-------------------------------------------------------+
/// | Top Toolbar & Tabs Bar                                |
/// +----------+--------------------------------------------+
/// | Sidebar  |                                            |
/// |          |           Workspace                        |
/// |          |                                            |
/// +----------+--------------------------------------------+
/// | Status Bar                                             |
/// +-------------------------------------------------------+
class ApplicationShell extends StatefulWidget {
  /// Creates an [ApplicationShell].
  const ApplicationShell({
    super.key,
    required this.workspaceManager,
    required this.sidebarManager,
    required this.statusBarManager,
    required this.editorViewBuilder,
  });

  final WorkspaceManager workspaceManager;
  final SidebarManager sidebarManager;
  final StatusBarManager statusBarManager;
  final Widget Function(BuildContext context, WorkspaceManager manager) editorViewBuilder;

  @override
  State<ApplicationShell> createState() => _ApplicationShellState();
}

class _ApplicationShellState extends State<ApplicationShell> {
  final NavigationManager _navigationManager = NavigationManager();
  final ResponsiveLayoutManager _layoutManager = ResponsiveLayoutManager();
  final TopToolbarManager _toolbarManager = TopToolbarManager();
  bool _showCommandPalette = false;

  @override
  void initState() {
    super.initState();
    widget.workspaceManager.addListener(_onStateChange);
    widget.sidebarManager.addListener(_onStateChange);
    widget.statusBarManager.addListener(_onStateChange);
  }

  @override
  void dispose() {
    widget.workspaceManager.removeListener(_onStateChange);
    widget.sidebarManager.removeListener(_onStateChange);
    widget.statusBarManager.removeListener(_onStateChange);
    _navigationManager.dispose();
    _layoutManager.dispose();
    _toolbarManager.dispose();
    super.dispose();
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _layoutManager.updateWidth(constraints.maxWidth);
        final activeWorkspace = widget.workspaceManager.activeWorkspace;

        return Scaffold(
          backgroundColor: const Color(0xFF11111B),
          body: Stack(
            children: [
              Column(
                children: [
                  // 1. Top Toolbar & Tabs Bar
                  TopToolbarView(
                    workspaceManager: widget.workspaceManager,
                    onNewProject: () => widget.workspaceManager.openNewWorkspace(),
                    onOpenProject: () {},
                    onSaveProject: () => widget.workspaceManager.markActiveWorkspaceDirty(false),
                    onUndo: () => activeWorkspace?.engine.undo(),
                    onRedo: () => activeWorkspace?.engine.redo(),
                    onExport: () {},
                    onToggleCommandPalette: () => setState(() => _showCommandPalette = true),
                  ),

                  // 2. Middle Workspace & Sidebar Row
                  Expanded(
                    child: Row(
                      children: [
                        // Sidebar Panel
                        SidebarView(
                          sidebarManager: widget.sidebarManager,
                          child: _buildSidebarContent(),
                        ),

                        // Main Workspace View
                        Expanded(
                          child: widget.editorViewBuilder(context, widget.workspaceManager),
                        ),
                      ],
                    ),
                  ),

                  // 3. Bottom Status Bar
                  StatusBarView(
                    statusBarManager: widget.statusBarManager,
                    workspace: activeWorkspace,
                  ),
                ],
              ),

              // Command Palette Overlay
              if (_showCommandPalette)
                CommandPalette(
                  onClose: () => setState(() => _showCommandPalette = false),
                  onNewProject: () {
                    widget.workspaceManager.openNewWorkspace();
                    setState(() => _showCommandPalette = false);
                  },
                  onOpenProject: () {},
                  onExport: () {},
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSidebarContent() {
    final activeWs = widget.workspaceManager.activeWorkspace;
    final section = widget.sidebarManager.activeSection;

    switch (section) {
      case SidebarSection.layers:
        final layers = activeWs?.engine.grid.layers ?? [];
        return ListView.builder(
          itemCount: layers.length,
          itemBuilder: (context, index) {
            final layer = layers[index];
            final isSelected = index == activeWs?.engine.session.activeLayerIndex;
            return ListTile(
              dense: true,
              selected: isSelected,
              selectedTileColor: const Color(0xFF313244),
              leading: Icon(
                layer.isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                size: 16,
                color: Colors.white60,
              ),
              title: Text(
                layer.name,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 12,
                ),
              ),
            );
          },
        );

      case SidebarSection.animation:
        final clip = activeWs?.engine.animationEngine.activeClip;
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Clip: ${clip?.name ?? "Idle"}', style: const TextStyle(color: Colors.white, fontSize: 13)),
              const SizedBox(height: 8),
              Text('Frames: ${clip?.frameCount ?? 0}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        );

      case SidebarSection.projects:
      case SidebarSection.assets:
      case SidebarSection.history:
      case SidebarSection.inspector:
        return Center(
          child: Text(
            section.name.toUpperCase(),
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        );
    }
  }
}

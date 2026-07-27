import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';

/// Top toolbar and workspace tab bar widget layout.
class TopToolbarView extends StatelessWidget {
  /// Creates a [TopToolbarView].
  const TopToolbarView({
    super.key,
    required this.workspaceManager,
    required this.onNewProject,
    required this.onOpenProject,
    required this.onSaveProject,
    required this.onUndo,
    required this.onRedo,
    required this.onExport,
    required this.onToggleCommandPalette,
  });

  final WorkspaceManager workspaceManager;
  final VoidCallback onNewProject;
  final VoidCallback onOpenProject;
  final VoidCallback onSaveProject;
  final VoidCallback onUndo;
  final VoidCallback onRedo;
  final VoidCallback onExport;
  final VoidCallback onToggleCommandPalette;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: const BoxDecoration(
        color: Color(0xFF1E1E2E),
        border: Border(
          bottom: BorderSide(color: Color(0xFF2A2A3D)),
        ),
      ),
      child: Row(
        children: [
          // App Logo / Title
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: const Row(
              children: [
                Icon(Icons.brush_rounded, color: Color(0xFF6C5CE7), size: 20),
                SizedBox(width: 8),
                Text(
                  'PixelCanvas',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),

          // File / Action Buttons
          IconButton(
            icon: const Icon(Icons.add_rounded, size: 18, color: Colors.white70),
            tooltip: 'New Project',
            onPressed: onNewProject,
          ),
          IconButton(
            icon: const Icon(Icons.folder_open_rounded, size: 18, color: Colors.white70),
            tooltip: 'Open Project',
            onPressed: onOpenProject,
          ),
          IconButton(
            icon: const Icon(Icons.save_rounded, size: 18, color: Colors.white70),
            tooltip: 'Save Project',
            onPressed: onSaveProject,
          ),
          const VerticalDivider(width: 16, indent: 10, endIndent: 10, color: Color(0xFF2A2A3D)),

          IconButton(
            icon: const Icon(Icons.undo_rounded, size: 18, color: Colors.white70),
            tooltip: 'Undo',
            onPressed: onUndo,
          ),
          IconButton(
            icon: const Icon(Icons.redo_rounded, size: 18, color: Colors.white70),
            tooltip: 'Redo',
            onPressed: onRedo,
          ),
          const VerticalDivider(width: 16, indent: 10, endIndent: 10, color: Color(0xFF2A2A3D)),

          IconButton(
            icon: const Icon(Icons.file_upload_outlined, size: 18, color: Colors.white70),
            tooltip: 'Export',
            onPressed: onExport,
          ),

          // Workspace Tabs Bar
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  workspaceManager.workspaces.length,
                  (index) {
                    final tab = workspaceManager.workspaces[index];
                    final isActive = index == workspaceManager.activeWorkspaceIndex;
                    return GestureDetector(
                      onTap: () => workspaceManager.switchWorkspace(index),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: isActive ? const Color(0xFF2A2A3D) : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isActive ? const Color(0xFF6C5CE7) : Colors.transparent,
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              tab.name + (tab.isDirty ? ' •' : ''),
                              style: TextStyle(
                                color: isActive ? Colors.white : Colors.white60,
                                fontSize: 12,
                                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => workspaceManager.closeWorkspace(index),
                              child: const Icon(Icons.close_rounded, size: 14, color: Colors.white38),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),

          // Command Palette Search Trigger
          IconButton(
            icon: const Icon(Icons.search_rounded, size: 18, color: Colors.white70),
            tooltip: 'Command Palette (Ctrl+K)',
            onPressed: onToggleCommandPalette,
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

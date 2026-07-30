import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/sidebar_manager.dart';

/// Collapsible sidebar panel view.
class SidebarView extends StatelessWidget {
  /// Creates a [SidebarView].
  const SidebarView({
    super.key,
    required this.sidebarManager,
    required this.child,
  });

  final SidebarManager sidebarManager;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (sidebarManager.isCollapsed) {
      return Container(
        width: 48,
        color: const Color(0xFF181825),
        child: Column(
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_right_rounded, color: Colors.white70),
              tooltip: 'Expand Sidebar',
              onPressed: sidebarManager.toggleCollapse,
            ),
          ],
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      width: sidebarManager.width,
      decoration: BoxDecoration(
        color: Color(0xFF181825),
        border: Border(
          right: BorderSide(color: Color(0xFF2A2A3D)),
        ),
      ),
      child: Column(
        children: [
          // Sidebar Section Header Bar
          Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: const Color(0xFF1E1E2E),
            child: Row(
              children: [
                _buildTabButton(SidebarSection.layers, Icons.layers_rounded, 'Layers'),
                _buildTabButton(SidebarSection.animation, Icons.movie_creation_rounded, 'Anim'),
                _buildTabButton(SidebarSection.projects, Icons.folder_copy_rounded, 'Projects'),
                _buildTabButton(SidebarSection.history, Icons.history_rounded, 'History'),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.chevron_left_rounded, size: 18, color: Colors.white60),
                  tooltip: 'Collapse Sidebar',
                  onPressed: sidebarManager.toggleCollapse,
                ),
              ],
            ),
          ),

          // Main Sidebar Content Area
          Expanded(child: child),
        ],
      ),
    );
  }

  Widget _buildTabButton(SidebarSection section, IconData icon, String label) {
    final isActive = sidebarManager.activeSection == section;
    return GestureDetector(
      onTap: () => sidebarManager.selectSection(section),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: const EdgeInsets.only(right: 4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF6C5CE7) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(
          icon,
          size: 16,
          color: isActive ? Colors.white : Colors.white60,
        ),
      ),
    );
  }
}

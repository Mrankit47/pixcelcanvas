import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/status_bar_manager.dart';
import 'package:pixelcanvas/features/app_shell/models/project_workspace.dart';

/// Bottom Status Bar widget displaying real-time metrics and cursor coordinates.
class StatusBarView extends StatelessWidget {
  /// Creates a [StatusBarView].
  const StatusBarView({
    super.key,
    required this.statusBarManager,
    required this.workspace,
  });

  final StatusBarManager statusBarManager;
  final ProjectWorkspace? workspace;

  @override
  Widget build(BuildContext context) {
    final w = workspace;
    final canvasSizeStr = w != null ? '${w.canvasWidth} × ${w.canvasHeight}' : '32 × 32';
    final zoomStr = w != null ? '${(w.zoom * 100).round()}%' : '100%';
    final toolStr = w != null ? w.activeTool : 'Brush';
    final layerCountStr = w != null ? '${w.layerCount} Layers' : '1 Layer';
    final frameCountStr = w != null ? '${w.frameCount} Frames' : '0 Frames';

    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFF11111B),
        border: Border(
          top: BorderSide(color: Color(0xFF2A2A3D)),
        ),
      ),
      child: Row(
        children: [
          // Current Tool
          Icon(Icons.border_color_rounded, size: 12, color: Colors.white60),
          const SizedBox(width: 4),
          Text(toolStr, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const VerticalDivider(width: 16, indent: 6, endIndent: 6, color: Color(0xFF2A2A3D)),

          // Canvas Resolution
          Icon(Icons.aspect_ratio_rounded, size: 12, color: Colors.white60),
          const SizedBox(width: 4),
          Text(canvasSizeStr, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const VerticalDivider(width: 16, indent: 6, endIndent: 6, color: Color(0xFF2A2A3D)),

          // Cursor Coordinates
          Text(
            'X: ${statusBarManager.cursorX}  Y: ${statusBarManager.cursorY}',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          const VerticalDivider(width: 16, indent: 6, endIndent: 6, color: Color(0xFF2A2A3D)),

          // Zoom Level
          Text(zoomStr, style: const TextStyle(color: Colors.white70, fontSize: 11)),
          const VerticalDivider(width: 16, indent: 6, endIndent: 6, color: Color(0xFF2A2A3D)),

          // Layer Count & Frame Count
          Text('$layerCountStr  •  $frameCountStr', style: const TextStyle(color: Colors.white70, fontSize: 11)),

          const Spacer(),

          // FPS & Memory Footprint Placeholder
          Text(
            '${statusBarManager.fps.round()} FPS  •  ${statusBarManager.memoryUsage}',
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

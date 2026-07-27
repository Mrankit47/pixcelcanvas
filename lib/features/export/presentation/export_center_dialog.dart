import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package:pixelcanvas/features/editor/engine/canvas_engine.dart';
import 'package:pixelcanvas/features/export/controllers/batch_export_manager.dart';
import 'package:pixelcanvas/features/export/controllers/export_manager.dart';
import 'package:pixelcanvas/features/export/models/export_format.dart';
import 'package:pixelcanvas/features/export/packaging/project_packager.dart';
import 'package:pixelcanvas/features/export/presentation/widgets/export_preset_card.dart';
import 'package:pixelcanvas/features/export/presentation/widgets/export_queue_widget.dart';

/// Modal dialog for Export Center per Blueprint §7.6.
class ExportCenterDialog extends StatefulWidget {
  /// Creates an [ExportCenterDialog].
  const ExportCenterDialog({
    super.key,
    required this.exportManager,
    required this.workspaceManager,
    required this.engine,
  });

  final ExportManager exportManager;
  final WorkspaceManager workspaceManager;
  final CanvasEngine engine;

  @override
  State<ExportCenterDialog> createState() => _ExportCenterDialogState();
}

class _ExportCenterDialogState extends State<ExportCenterDialog> {
  int _activeTab = 0;
  final BatchExportManager _batchManager = BatchExportManager();

  @override
  void initState() {
    super.initState();
    widget.exportManager.addListener(_onChanged);
  }

  @override
  void dispose() {
    widget.exportManager.removeListener(_onChanged);
    _batchManager.dispose();
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF11111B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFF313244)),
      ),
      child: SizedBox(
        width: 780,
        height: 540,
        child: Column(
          children: [
            // Top Header Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF181825),
              child: Row(
                children: [
                  const Icon(Icons.file_upload_rounded, color: Color(0xFF6C5CE7)),
                  const SizedBox(width: 8),
                  const Text('Export Center & Distribution', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white38),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // Tab Bar Navigation Header
            Container(
              color: const Color(0xFF1E1E2E),
              child: Row(
                children: [
                  _buildTab(0, 'Quick Export'),
                  _buildTab(1, 'Batch Export'),
                  _buildTab(2, 'Export Queue'),
                  _buildTab(3, 'History & Stats'),
                  _buildTab(4, 'Packaging'),
                ],
              ),
            ),

            // Main Tab Body Content
            Expanded(child: _buildTabBody()),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _activeTab == index;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: isSelected ? const Color(0xFF6C5CE7) : Colors.transparent, width: 2),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white60,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildTabBody() {
    switch (_activeTab) {
      case 0:
        return _buildQuickExportTab();
      case 1:
        return _buildBatchExportTab();
      case 2:
        return ExportQueueWidget(queue: widget.exportManager.queue);
      case 3:
        return _buildHistoryTab();
      case 4:
        return _buildPackagingTab();
      default:
        return const SizedBox();
    }
  }

  Widget _buildQuickExportTab() {
    final active = widget.exportManager.activePreset;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Select Export Preset:', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 240,
                childAspectRatio: 2.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: widget.exportManager.presets.length,
              itemBuilder: (context, index) {
                final preset = widget.exportManager.presets[index];
                return ExportPresetCard(
                  preset: preset,
                  isSelected: active == preset,
                  onSelect: () => widget.exportManager.selectPreset(preset),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Format: ${active.format.label} (${active.scaleFactor}x Scale)', style: const TextStyle(color: Colors.white60, fontSize: 12)),
              const Spacer(),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
                icon: const Icon(Icons.file_upload_outlined, color: Colors.white, size: 18),
                label: const Text('Export Now', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                onPressed: () {
                  widget.exportManager.quickExport(
                    projectName: 'Artwork',
                    outputPath: '/exports/Artwork.${active.format.extension}',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Export completed successfully!')),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBatchExportTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Batch Export Workspaces', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Active open workspaces: ${widget.workspaceManager.workspaces.length} tabs', style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
            icon: const Icon(Icons.queue_rounded, color: Colors.white),
            label: const Text('Enqueue All Workspaces for Batch Export', style: TextStyle(color: Colors.white)),
            onPressed: () {
              _batchManager.exportAllWorkspaces(
                workspaceManager: widget.workspaceManager,
                exportQueue: widget.exportManager.queue,
                preset: widget.exportManager.activePreset,
              );
              setState(() => _activeTab = 2); // Switch to queue tab
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    final stats = widget.exportManager.history.calculateStatistics();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFF181825), borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Total Exports', '${stats.totalExports}'),
                _buildStatItem('Total Volume', stats.formattedTotalSize),
                _buildStatItem('Most Used', stats.mostUsedFormat.name.toUpperCase()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackagingTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Generate Distribution Project Package (.pixelcanvas)', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Includes full JSON project manifest, canvas dimensions, layer stack details, and integrity checksum.', style: TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C5CE7)),
            icon: const Icon(Icons.archive_rounded, color: Colors.white),
            label: const Text('Generate Package Manifest JSON', style: TextStyle(color: Colors.white)),
            onPressed: () {
              final jsonStr = ProjectPackager.exportManifestJson(projectName: 'ProjectPackage', engine: widget.engine);
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: const Color(0xFF1E1E2E),
                  title: const Text('Generated Package Manifest', style: TextStyle(color: Colors.white, fontSize: 14)),
                  content: SingleChildScrollView(child: Text(jsonStr, style: const TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'monospace'))),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Color(0xFF89B4FA), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(color: Colors.white38, fontSize: 10)),
      ],
    );
  }
}

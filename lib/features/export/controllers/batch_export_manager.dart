import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/app_shell/controllers/workspace_manager.dart';
import 'package0/pixelcanvas/features/export/models/export_preset.dart';
import 'package:pixelcanvas/features/export/queue/export_job.dart';
import 'package:pixelcanvas/features/export/queue/export_queue.dart';

/// Batch export manager coordinating multi-project export jobs.
class BatchExportManager extends ChangeNotifier {
  /// Schedules export jobs for all open workspace tabs using [preset].
  void exportAllWorkspaces({
    required WorkspaceManager workspaceManager,
    required ExportQueue exportQueue,
    required ExportPreset preset,
  }) {
    for (final ws in workspaceManager.workspaces) {
      final now = DateTime.now();
      final job = ExportJob(
        id: 'job_${now.millisecondsSinceEpoch}_${ws.id}',
        projectName: ws.name,
        format: preset.format,
        outputPath: '/exports/${ws.name}_${preset.scaleFactor}x.${preset.format.name}',
        timestamp: now,
      );
      exportQueue.enqueue(job);
    }
    notifyListeners();
  }
}

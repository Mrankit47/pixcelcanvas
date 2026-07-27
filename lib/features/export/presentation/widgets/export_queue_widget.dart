import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/export/models/export_format.dart';
import 'package:pixelcanvas/features/export/queue/export_job.dart';
import 'package:pixelcanvas/features/export/queue/export_queue.dart';

/// Queue widget rendering active and completed export jobs.
class ExportQueueWidget extends StatelessWidget {
  /// Creates an [ExportQueueWidget].
  const ExportQueueWidget({
    super.key,
    required this.queue,
  });

  final ExportQueue queue;

  @override
  Widget build(BuildContext context) {
    if (queue.jobs.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.playlist_add_check_rounded, size: 48, color: Colors.white24),
            SizedBox(height: 12),
            Text('Export Queue is Empty', style: TextStyle(color: Colors.white38, fontSize: 13)),
          ],
        ),
      );
    }

    return Column(
      children: [
        // Queue Toolbar Controls
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: const Color(0xFF181825),
          child: Row(
            children: [
              Text('${queue.jobs.length} Jobs in Queue', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(
                icon: Icon(queue.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded, color: Colors.white70, size: 18),
                tooltip: queue.isPaused ? 'Resume Queue' : 'Pause Queue',
                onPressed: queue.togglePause,
              ),
              IconButton(
                icon: const Icon(Icons.delete_sweep_rounded, color: Colors.white70, size: 18),
                tooltip: 'Clear Completed',
                onPressed: queue.clearCompleted,
              ),
            ],
          ),
        ),

        // Queue List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(12),
            itemCount: queue.jobs.length,
            separatorBuilder: (context, index) => const Divider(color: Color(0xFF2A2A3D)),
            itemBuilder: (context, index) {
              final job = queue.jobs[index];
              return ListTile(
                dense: true,
                title: Text(job.projectName, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                subtitle: Text('${job.format.label} • ${job.outputPath}', style: const TextStyle(color: Colors.white38, fontSize: 11)),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_getStatusLabel(job.status), style: TextStyle(color: _getStatusColor(job.status), fontSize: 11)),
                    const SizedBox(width: 8),
                    if (job.status == ExportJobStatus.queued || job.status == ExportJobStatus.exporting)
                      IconButton(
                        icon: const Icon(Icons.cancel_rounded, size: 16, color: Colors.white38),
                        onPressed: () => queue.cancelJob(job.id),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getStatusLabel(ExportJobStatus status) {
    switch (status) {
      case ExportJobStatus.queued:
        return 'Queued';
      case ExportJobStatus.preparing:
        return 'Preparing...';
      case ExportJobStatus.exporting:
        return 'Exporting...';
      case ExportJobStatus.completed:
        return 'Completed';
      case ExportJobStatus.failed:
        return 'Failed';
      case ExportJobStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color _getStatusColor(ExportJobStatus status) {
    switch (status) {
      case ExportJobStatus.completed:
        return const Color(0xFF2ECC71);
      case ExportJobStatus.failed:
      case ExportJobStatus.cancelled:
        return const Color(0xFFE74C3C);
      case ExportJobStatus.exporting:
      case ExportJobStatus.preparing:
        return const Color(0xFFF1C40F);
      case ExportJobStatus.queued:
      default:
        return Colors.white60;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:pixelcanvas/features/export/queue/export_job.dart';

/// Export Priority Queue Manager.
class ExportQueue extends ChangeNotifier {
  final List<ExportJob> _jobs = [];
  bool _isPaused = false;

  /// Jobs list getter.
  List<ExportJob> get jobs => List.unmodifiable(_jobs);

  /// True if queue is paused.
  bool get isPaused => _isPaused;

  /// Enqueues [job] into queue.
  void enqueue(ExportJob job) {
    _jobs.add(job);
    notifyListeners();
  }

  /// Cancels job [jobId].
  void cancelJob(String jobId) {
    final idx = _jobs.indexWhere((j) => j.id == jobId);
    if (idx >= 0) {
      _jobs[idx] = _jobs[idx].copyWith(status: ExportJobStatus.cancelled);
      notifyListeners();
    }
  }

  /// Retries failed job [jobId].
  void retryJob(String jobId) {
    final idx = _jobs.indexWhere((j) => j.id == jobId);
    if (idx >= 0) {
      _jobs[idx] = _jobs[idx].copyWith(status: ExportJobStatus.queued, progress: 0.0);
      notifyListeners();
    }
  }

  /// Toggles queue pause state.
  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  /// Clears completed jobs.
  void clearCompleted() {
    _jobs.removeWhere((j) => j.status == ExportJobStatus.completed || j.status == ExportJobStatus.cancelled);
    notifyListeners();
  }
}

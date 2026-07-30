import 'package:pixelcanvas/features/export/models/export_format.dart';
import 'package:pixelcanvas/features/export/queue/export_job.dart';

/// Aggregated export statistics.
class ExportStatistics {
  const ExportStatistics({
    this.totalExports = 0,
    this.totalBytesExported = 0,
    this.mostUsedFormat = ExportFormat.png,
    this.averageDurationMs = 0,
  });

  final int totalExports;
  final int totalBytesExported;
  final ExportFormat mostUsedFormat;
  final int averageDurationMs;

  String get formattedTotalSize {
    final mb = totalBytesExported / (1024 * 1024);
    return '${mb.toStringAsFixed(1)} MB';
  }
}

/// Export history container tracking executed jobs and statistics.
class ExportHistory {
  final List<ExportJob> _records = [];

  /// Records list getter.
  List<ExportJob> get records => List<ExportJob>.from(_records);

  /// Adds job to history.
  void addRecord(ExportJob job) {
    _records.insert(0, job);
    if (_records.length > 100) {
      _records.removeLast();
    }
  }

  /// Calculates aggregated statistics.
  ExportStatistics calculateStatistics() {
    if (_records.isEmpty) return const ExportStatistics();

    final completed = _records.where((j) => j.status == ExportJobStatus.completed).toList();
    if (completed.isEmpty) return const ExportStatistics();

    final totalBytes = completed.fold<int>(0, (sum, j) => sum + j.fileSizeBytes);
    final totalDuration = completed.fold<int>(0, (sum, j) => sum + j.durationMs);

    final counts = <ExportFormat, int>{};
    for (final j in completed) {
      counts[j.format] = (counts[j.format] ?? 0) + 1;
    }

    ExportFormat topFormat = ExportFormat.png;
    int topCount = 0;
    counts.forEach((fmt, count) {
      if (count > topCount) {
        topCount = count;
        topFormat = fmt;
      }
    });

    return ExportStatistics(
      totalExports: completed.length,
      totalBytesExported: totalBytes,
      mostUsedFormat: topFormat,
      averageDurationMs: (totalDuration / completed.length).round(),
    );
  }
}

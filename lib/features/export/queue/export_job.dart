import 'package:equatable/equatable.dart';
import 'package:pixelcanvas/features/export/models/export_format.dart';

/// Status state for queued export jobs.
enum ExportJobStatus { queued, preparing, exporting, completed, failed, cancelled }

/// Export job entry descriptor in priority queue.
class ExportJob extends Equatable {
  /// Creates an [ExportJob].
  const ExportJob({
    required this.id,
    required this.projectName,
    required this.format,
    required this.outputPath,
    this.status = ExportJobStatus.queued,
    this.progress = 0.0,
    required this.timestamp,
    this.durationMs = 0,
    this.fileSizeBytes = 0,
    this.errorMessage,
  });

  final String id;
  final String projectName;
  final ExportFormat format;
  final String outputPath;
  final ExportJobStatus status;
  final double progress;
  final DateTime timestamp;
  final int durationMs;
  final int fileSizeBytes;
  final String? errorMessage;

  ExportJob copyWith({
    String? id,
    String? projectName,
    ExportFormat? format,
    String? outputPath,
    ExportJobStatus? status,
    double? progress,
    DateTime? timestamp,
    int? durationMs,
    int? fileSizeBytes,
    String? errorMessage,
  }) =>
      ExportJob(
        id: id ?? this.id,
        projectName: projectName ?? this.projectName,
        format: format ?? this.format,
        outputPath: outputPath ?? this.outputPath,
        status: status ?? this.status,
        progress: progress ?? this.progress,
        timestamp: timestamp ?? this.timestamp,
        durationMs: durationMs ?? this.durationMs,
        fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [
        id,
        projectName,
        format,
        outputPath,
        status,
        progress,
        timestamp,
        durationMs,
        fileSizeBytes,
        errorMessage,
      ];
}

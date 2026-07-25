import 'package:pixelcanvas/features/editor/engine/export/models/export_settings.dart';

/// Export job status tracking container per Blueprint §8.1.
///
/// **Purpose**: Tracks the lifecycle of an export operation from pending to completion.
/// **Future Extensions**: Progress percentage, cancellation token, error details.
class ExportJob {
  /// Creates an [ExportJob].
  ExportJob({
    required this.settings,
    required this.canvasWidth,
    required this.canvasHeight,
  });

  /// Export configuration.
  final ExportSettings settings;

  /// Source canvas width.
  final int canvasWidth;

  /// Source canvas height.
  final int canvasHeight;

  /// Job status.
  ExportJobStatus status = ExportJobStatus.pending;

  /// Output image width (canvas × scale).
  int get outputWidth => canvasWidth * settings.scale;

  /// Output image height (canvas × scale).
  int get outputHeight => canvasHeight * settings.scale;

  /// Marks job as in progress.
  void markInProgress() => status = ExportJobStatus.inProgress;

  /// Marks job as completed.
  void markCompleted() => status = ExportJobStatus.completed;

  /// Marks job as failed.
  void markFailed() => status = ExportJobStatus.failed;
}

/// Export job lifecycle status.
enum ExportJobStatus {
  pending,
  inProgress,
  completed,
  failed,
}

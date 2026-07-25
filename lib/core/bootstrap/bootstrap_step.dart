/// Status enumeration for individual bootstrap initialization steps.
enum BootstrapStepStatus {
  /// Step has not yet executed.
  pending,

  /// Step is currently executing.
  inProgress,

  /// Step completed successfully.
  success,

  /// Step failed with error.
  failed,

  /// Step was skipped.
  skipped,
}

/// Represents a single step in the application startup pipeline.
class BootstrapStep {
  /// Creates a [BootstrapStep] instance.
  BootstrapStep({
    required this.name,
    this.status = BootstrapStepStatus.pending,
    this.duration = Duration.zero,
    this.error,
  });

  /// Human-readable step name.
  final String name;

  /// Current execution status.
  BootstrapStepStatus status;

  /// Duration taken to execute this step.
  Duration duration;

  /// Captured error if step failed.
  Object? error;

  @override
  String toString() =>
      'BootstrapStep($name: ${status.name}, ${duration.inMilliseconds}ms)';
}

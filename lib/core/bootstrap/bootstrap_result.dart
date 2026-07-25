import 'package:pixelcanvas/core/bootstrap/bootstrap_step.dart';

/// Aggregate result container for the complete bootstrap pipeline.
class BootstrapResult {
  /// Creates a [BootstrapResult] instance.
  BootstrapResult({
    required this.steps,
    required this.totalDuration,
    required this.isSuccess,
  });

  /// List of executed bootstrap steps with performance timing.
  final List<BootstrapStep> steps;

  /// Total duration taken for complete startup sequence.
  final Duration totalDuration;

  /// True if all mandatory steps completed successfully.
  final bool isSuccess;

  @override
  String toString() =>
      'BootstrapResult(success: $isSuccess, duration: ${totalDuration.inMilliseconds}ms, steps: ${steps.length})';
}

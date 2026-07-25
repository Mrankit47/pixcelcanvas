import 'package:pixelcanvas/core/bootstrap/bootstrap_result.dart';
import 'package:pixelcanvas/core/bootstrap/bootstrap_step.dart';
import 'package:pixelcanvas/core/utils/logger.dart';

/// Sequential step execution runner for the application startup pipeline.
///
/// Manages step execution, performance timing, error boundaries, and structured logging.
class BootstrapManager {
  final List<BootstrapStep> _steps = [];
  final Stopwatch _totalStopwatch = Stopwatch();

  /// Runs a single named initialization step with performance measurement and error boundary.
  Future<void> runStep({
    required String name,
    required Future<void> Function() action,
  }) async {
    final step = BootstrapStep(name: name, status: BootstrapStepStatus.inProgress);
    _steps.add(step);

    final stepStopwatch = Stopwatch()..start();
    Logger.i('Bootstrap step started: $name');

    try {
      await action();
      stepStopwatch.stop();
      step.status = BootstrapStepStatus.success;
      step.duration = stepStopwatch.elapsed;
      Logger.i('Bootstrap step completed: $name (${step.duration.inMilliseconds}ms)');
    } catch (e, stackTrace) {
      stepStopwatch.stop();
      step.status = BootstrapStepStatus.failed;
      step.duration = stepStopwatch.elapsed;
      step.error = e;
      Logger.e('Bootstrap step failed: $name (${step.duration.inMilliseconds}ms)', e, stackTrace);
      rethrow;
    }
  }

  /// Starts global timing tracking.
  void start() {
    _totalStopwatch.start();
  }

  /// Stops global timing tracking and aggregates result.
  BootstrapResult finish({required bool isSuccess}) {
    _totalStopwatch.stop();
    final result = BootstrapResult(
      steps: List.unmodifiable(_steps),
      totalDuration: _totalStopwatch.elapsed,
      isSuccess: isSuccess,
    );
    Logger.i('Bootstrap pipeline finished in ${result.totalDuration.inMilliseconds}ms (Success: $isSuccess)');
    return result;
  }
}

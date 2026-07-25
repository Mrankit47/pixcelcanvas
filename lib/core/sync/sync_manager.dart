import 'package:pixelcanvas/core/sync/sync_policy.dart';
import 'package:pixelcanvas/core/sync/sync_result.dart';

/// Sync manager orchestrator contract per Blueprint §11.5.
///
/// Purpose: High-level controller for trigger-based and scheduled background cloud sync.
/// Responsibilities: Evaluates sync policies, drains sync queue, handles retry backoff.
/// Future Implementation Notes: Executed by background sync workers and manual pull-to-refresh.
abstract class SyncManager {
  /// Starts background sync pipeline with specified [SyncPolicy].
  Future<SyncResult> synchronize({SyncPolicy policy = SyncPolicy.auto});

  /// Pauses active sync pipeline.
  void pause();

  /// Resumes paused sync pipeline.
  void resume();
}

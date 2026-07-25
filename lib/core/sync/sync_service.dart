import 'package:pixelcanvas/core/sync/sync_status.dart';

/// Abstract contract for background sync orchestrator.
///
/// Implements offline-first cloud sync processing per Blueprint §11.5.
abstract class SyncService {
  /// Stream emitting overall sync status changes.
  Stream<SyncStatus> get onSyncStatusChanged;

  /// Processes pending items in the [SyncQueue].
  Future<void> processQueue();

  /// Enqueues a change operation for cloud sync.
  Future<void> enqueueOperation({
    required String entityType,
    required String entityId,
    required String operation,
    required Map<String, dynamic> payload,
  });
}

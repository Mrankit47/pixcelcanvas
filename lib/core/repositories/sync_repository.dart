import 'package:pixelcanvas/core/repositories/offline_repository.dart';

/// Extension contract for repository entities requiring cloud synchronization.
///
/// Purpose: Handles cloud push/pull and conflict resolution interface boundaries.
/// Responsibilities: Remote fetches, cloud writes, and delta query execution.
abstract class SyncRepository<T, ID> implements OfflineRepository<T, ID> {
  /// Fetches latest delta updates from remote backend since [lastSyncedAt].
  Future<List<T>> fetchRemoteDeltas(DateTime lastSyncedAt);

  /// Pushes local entity changes to remote backend.
  Future<void> pushRemote(T entity);

  /// Marks local entity as synced with cloud.
  Future<void> markSynced(ID id);
}

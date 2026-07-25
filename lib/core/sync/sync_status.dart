/// Sync state enumeration for entity records and global sync state.
///
/// Derived directly from Blueprint §11 and §12.
enum SyncStatus {
  /// Entity exists locally only (unauthenticated or guest user).
  localOnly,

  /// Entity changes are queued and waiting to sync.
  pendingSync,

  /// Entity is fully in sync with cloud database.
  synced,

  /// Sync conflict detected (being resolved via LWW).
  conflict,

  /// Sync failed after max retries.
  failed,
}

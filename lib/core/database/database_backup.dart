/// 4-tier data backup and crash recovery manager per Blueprint §27.6 and §37.1.
///
/// Purpose: Protects user artwork against corruption, crashes, and accidental deletion.
/// Responsibilities:
/// Tier 1: In-memory undo history (50 steps).
/// Tier 2: Isar local autosave snapshot.
/// Tier 3: `.pxc` zip package export.
/// Tier 4: Supabase cloud backup.
/// Future Implementation Notes: Triggers recovery banner on app relaunch if `is_dirty` flag is detected.
abstract class DatabaseBackup {
  /// Creates a local snapshot backup of an active project.
  Future<void> createLocalSnapshot(String projectId);

  /// Restores project state from latest snapshot backup.
  Future<Map<String, dynamic>?> restoreLatestSnapshot(String projectId);

  /// Deletes snapshot backup after successful sync or export.
  Future<void> deleteSnapshot(String projectId);
}

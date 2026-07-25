/// Schema migration runner per Blueprint §37.1 (Gap 1 Amendment A).
///
/// Purpose: Handles version-tagged Isar schema migrations without data loss.
/// Responsibilities: Evaluates current schema version, executes version-increment migrations, logs migration steps.
/// Future Implementation Notes: Migration functions run lazily when Isar opens with a higher schema version.
abstract class DatabaseMigrations {
  /// Current database schema version.
  static const int currentVersion = 1;

  /// Runs migration steps if stored schema version is less than [currentVersion].
  Future<void> migrate({
    required int fromVersion,
    required int toVersion,
  });
}

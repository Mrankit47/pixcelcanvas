import 'package:isar/isar.dart';

/// Database schema migration registry manager per Blueprint §11.2 & §11.4.
///
/// **Purpose**: Handles Isar database schema migrations between versions.
abstract final class MigrationManager {
  /// Current target schema version.
  static const int currentSchemaVersion = 1;

  /// Executes database schema migrations if required.
  static Future<void> performMigrations(Isar isar) async {
    // Schema v1 is initial release database setup.
  }
}

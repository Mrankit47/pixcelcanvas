/// Abstract contract for local NoSQL database initialization and lifecycle.
///
/// Will wrap Isar database instance in future phases per Blueprint §11.2.
abstract class LocalDatabase {
  /// Opens local database connection.
  Future<void> initialize();

  /// Clears local database content (for logout/reset).
  Future<void> clear();
}

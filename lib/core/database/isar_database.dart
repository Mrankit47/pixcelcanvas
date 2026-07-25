/// Abstract contract for Isar local database instance management per Blueprint §11.2.
///
/// Purpose: Provides lifetime control, collection access, and transaction boundaries for local persistence.
/// Responsibilities: Database opening, closing, transaction management, and collection access.
/// Future Implementation Notes: Will wrap `Isar` instance when Isar collection generators run in feature implementation.
abstract class IsarDatabase {
  /// Opens database connection and registers collection schemas.
  Future<void> open();

  /// Closes active database connection.
  Future<void> close();

  /// Clears all stored data collections.
  Future<void> clearAll();

  /// Executes read-write transaction callback.
  Future<T> writeTxn<T>(Future<T> Function() callback);

  /// Executes read-only transaction callback.
  Future<T> readTxn<T>(Future<T> Function() callback);
}

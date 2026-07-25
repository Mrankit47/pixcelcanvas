/// Abstract contract for encrypted key-value storage.
///
/// Wraps secure token storage per Blueprint §17.4.
abstract class SecureStorage {
  /// Reads string value for key.
  Future<String?> read(String key);

  /// Writes string value for key.
  Future<void> write({required String key, required String value});

  /// Deletes key.
  Future<void> delete(String key);

  /// Clears all stored credentials.
  Future<void> deleteAll();
}

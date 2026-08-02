/// Database service wrapper around local storage instance.
class DatabaseService {
  /// Creates a [DatabaseService].
  DatabaseService([this._db]);

  final dynamic _db;

  /// Exposes active instance.
  dynamic get isar => _db;

  /// Clears database collections.
  Future<void> clearAll() async {}
}

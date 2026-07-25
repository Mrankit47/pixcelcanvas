import 'package:isar/isar.dart';

/// Database service wrapper around the active [Isar] instance per Blueprint §11.2.
class DatabaseService {
  /// Creates a [DatabaseService] with an initialized [Isar] instance.
  DatabaseService(this._isar);

  final Isar _isar;

  /// Exposes active Isar instance.
  Isar get isar => _isar;

  /// Clears all database collections (used for testing or account reset).
  Future<void> clearAll() async {
    await _isar.writeTxn(() async {
      await _isar.clear();
    });
  }
}

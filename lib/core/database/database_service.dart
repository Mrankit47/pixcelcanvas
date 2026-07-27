import 'package:isar/isar.dart';

/// Database service wrapper around the active [Isar] instance per Blueprint §11.2.
class DatabaseService {
  /// Creates a [DatabaseService] with an optional [Isar] instance.
  DatabaseService([this._isar]);

  final Isar? _isar;

  /// Exposes active Isar instance (may be null if uninitialized).
  Isar? get isar => _isar;

  /// Clears all database collections.
  Future<void> clearAll() async {
    if (_isar != null) {
      await _isar!.writeTxn(() async {
        await _isar!.clear();
      });
    }
  }
}

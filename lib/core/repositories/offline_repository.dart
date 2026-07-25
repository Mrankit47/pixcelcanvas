import 'package:pixelcanvas/core/repositories/repository.dart';

/// Base Offline-First repository contract per Blueprint §11 and §26.3.
///
/// MUST enforce the mandatory Offline-First data flow:
///
/// **READ ORDER:**
/// 1. Memory Cache (LRU)
/// 2. Local Database (Isar)
/// 3. Remote Backend (Supabase)
///
/// **WRITE ORDER:**
/// 1. Local Database (Isar - immediate write < 5ms)
/// 2. Sync Queue (Enqueued change)
/// 3. Remote Backend (Background network sync)
abstract class OfflineRepository<T, ID> implements Repository<T, ID> {
  /// Fetches entity from local database (tier 2 read).
  Future<T?> getLocal(ID id);

  /// Saves entity directly to local database (tier 1 write < 5ms).
  Future<T> saveLocal(T entity);

  /// Deletes entity from local database.
  Future<void> deleteLocal(ID id);

  /// Stream emitting real-time local entity change events.
  Stream<T?> watchLocal(ID id);
}

import 'package:pixelcanvas/core/cache/cache_policy.dart';
import 'package:pixelcanvas/core/cache/cache_result.dart';

/// Generic in-memory LRU cache manager contract per Blueprint §11.1.
///
/// Purpose: Accelerates entity lookups and reduces database read I/O.
/// Responsibilities: Memory caching, TTL validation, eviction, and cache policy enforcement.
/// Future Implementation Notes: Utilized by repository implementations to serve tier-1 memory reads.
abstract class CacheManager<T> {
  /// Fetches cached entry for key using specified [CachePolicy].
  Future<CacheResult<T>> get(String key, {CachePolicy policy = CachePolicy.cacheFirst});

  /// Stores entry in cache with optional custom TTL.
  Future<void> put(String key, T value, {Duration? ttl});

  /// Removes single entry from cache.
  Future<void> remove(String key);

  /// Clears all entries from cache.
  Future<void> clear();
}

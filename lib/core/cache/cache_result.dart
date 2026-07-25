import 'package:pixelcanvas/core/cache/cache_metadata.dart';

/// Status enumeration for cache lookup operations.
enum CacheStatus {
  /// Entry found in cache and valid.
  hit,

  /// Entry not found in cache.
  miss,

  /// Entry found in cache but expired.
  expired,
}

/// Generic cache lookup result container.
class CacheResult<T> {
  /// Creates a [CacheResult] instance.
  const CacheResult({
    required this.status,
    this.data,
    this.metadata,
  });

  /// Lookup status.
  final CacheStatus status;

  /// Cached data object (null on cache miss).
  final T? data;

  /// Associated cache entry metadata.
  final CacheMetadata? metadata;

  /// True if cache lookup produced a valid hit.
  bool get isHit => status == CacheStatus.hit;
}

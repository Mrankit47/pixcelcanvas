/// Cache metadata tracking entry age and Time-To-Live (TTL) expiration per Blueprint §11.1.
class CacheMetadata {
  /// Creates a [CacheMetadata] instance.
  const CacheMetadata({
    required this.key,
    required this.cachedAt,
    required this.ttl,
  });

  /// Unique cache key identifier.
  final String key;

  /// Timestamp when data was cached.
  final DateTime cachedAt;

  /// Time-To-Live duration before expiration.
  final Duration ttl;

  /// True if cache entry has expired beyond its TTL.
  bool get isExpired => DateTime.now().isAfter(cachedAt.add(ttl));
}

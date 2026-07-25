/// Caching strategy policy enumeration per Blueprint §11.1.
enum CachePolicy {
  /// Reads from local cache first; fetches network only on cache miss or expiration.
  cacheFirst,

  /// Fetches from network first; falls back to local cache if offline.
  networkFirst,

  /// Reads strictly from local cache (offline mode).
  cacheOnly,

  /// Reads strictly from network (bypasses cache).
  networkOnly,
}
